#include "DoItYourselfBar.hpp"

#include <sys/wait.h>
#include <unistd.h>

#include <QDBusConnection>

#include "BlockInfo.hpp"

DoItYourselfBar::DoItYourselfBar(QObject* parent) :
        QObject(parent),
        childPid(0),
        dbusService(parent),
        dbusSuccess(false),
        dbusPath(),
        cfg_DBusPath() {

    QObject::connect(&dbusService, &DBusService::dataPassed,
                     this, &DoItYourselfBar::handlePassedData);

    QObject::connect(this, &DoItYourselfBar::cfg_DBusPathChanged, this, [&] {
        registerDBusService();
        runStartupScript();
        emit dbusSuccessChanged(dbusSuccess);
    });

    QObject::connect(this, &DoItYourselfBar::cfg_StartupScriptPathChanged, this, [&] {
        runStartupScript();
    });
}

DoItYourselfBar::~DoItYourselfBar() {
    killChild();
}

void DoItYourselfBar::runStartupScript() {
    killChild();

    if (!cfg_StartupScriptPath.isEmpty() && dbusSuccess) {
        childPid = fork();
        if (childPid == 0) {
            QString arg1 = cfg_StartupScriptPath;
            QString arg2 = dbusPath;
            execl(arg1.toStdString().c_str(),
                  arg1.toStdString().c_str(),
                  arg2.toStdString().c_str(), NULL);
            kill(getpid(), SIGTERM);
        }
    }
}

void DoItYourselfBar::runCommand(QString command) {
    if (!command.isEmpty()) {
        system(QString("(" + command + ") &").toStdString().c_str());
    }
}

void DoItYourselfBar::killChild() {
    if (childPid > 0) {
        kill(childPid, SIGTERM);
        wait(NULL);
        childPid = 0;
    }
}

void DoItYourselfBar::registerDBusService() {
    auto sessionBus = QDBusConnection::sessionBus();
    sessionBus.registerService(SERVICE_NAME);

    if (!dbusPath.isEmpty()) {
        sessionBus.unregisterObject(dbusPath, QDBusConnection::UnregisterTree);
    }

    dbusSuccess = false;

    if (!cfg_DBusPath.isEmpty()) {
        if (sessionBus.registerObject(cfg_DBusPath, QString(SERVICE_NAME),
                                      &dbusService, QDBusConnection::ExportAllSlots)) {
            dbusSuccess = true;
            dbusPath = cfg_DBusPath;
        }
    }
}

void DoItYourselfBar::handlePassedData(QString data) {
    QVariantList blockInfoList;

    BlockInfo blockInfo;
    int separatorCount = !data.isEmpty() ? 0 : -1;

    for (int i = 0; i < data.length(); i++) {
        QChar character = data.at(i);

        bool isEscapingCharacter = character == QChar('\\') &&
                                   i < data.length() - 1 &&
                                   data.at(i + 1) == QChar('|');
        if (isEscapingCharacter) {
            continue;
        }

        bool isSeparatorCharacter = character == QChar('|') &&
                                    (i == 0 || data.at(i - 1) != QChar('\\'));
        if (isSeparatorCharacter) {
            separatorCount++;

            if (separatorCount % 5 == 0) {
                blockInfo.style = blockInfo.style.trimmed();
                blockInfo.labelText = blockInfo.labelText.trimmed();
                blockInfo.tooltipText = blockInfo.tooltipText.trimmed();
                blockInfo.commandToExecOnClick = blockInfo.commandToExecOnClick.trimmed();

                blockInfoList << blockInfo.toQVariantMap();
                blockInfo = BlockInfo();
            }

            continue;
        }

        if (separatorCount % 5 == 1) {
            blockInfo.style += character;
        } else if (separatorCount % 5 == 2) {
            blockInfo.labelText += character;
        } else if (separatorCount % 5 == 3) {
            blockInfo.tooltipText += character;
        } else if (separatorCount % 5 == 4) {
            blockInfo.commandToExecOnClick += character;
        } else {
            separatorCount = -1;
            break;
        }
    }

    if (separatorCount % 5 != 0) {
        emit invalidDataFormatDetected();
    } else {
        emit blockInfoListSent(blockInfoList);
    }
}
