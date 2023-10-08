#pragma once

#include <QObject>
#include <QString>
#include <QVariantList>

#include "DBusService.hpp"

class DoItYourselfBar : public QObject {
    Q_OBJECT

public:
    DoItYourselfBar(QObject* parent = nullptr);
    ~DoItYourselfBar();

    Q_INVOKABLE void runStartupScript();
    Q_INVOKABLE void runCommand(QString command);

    Q_PROPERTY(QString cfg_DBusPath
               MEMBER cfg_DBusPath
               NOTIFY cfg_DBusPathChanged)

    Q_PROPERTY(QString cfg_StartupScriptPath
               MEMBER cfg_StartupScriptPath
               NOTIFY cfg_StartupScriptPathChanged)

signals:
    void dbusSuccessChanged(bool dbusSuccess);
    void invalidDataFormatDetected();
    void blockInfoListSent(QVariantList blockInfoList);

    void cfg_DBusPathChanged();
    void cfg_StartupScriptPathChanged();

private:
    pid_t childPid;
    void killChild();

    DBusService dbusService;
    bool dbusSuccess;
    QString dbusPath;
    void registerDBusService();

    QString cfg_DBusPath;
    QString cfg_StartupScriptPath;

    void handlePassedData(QString data);
};
