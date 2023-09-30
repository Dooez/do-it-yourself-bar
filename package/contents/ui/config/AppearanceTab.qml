import "../common" as UICommon
import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.0
import QtQuick.Layouts 1.3
import org.kde.plasma.core 2.0 as PlasmaCore

Item {
    // Animations
    property alias cfg_AnimationsEnable: animationsEnableCheckBox.checked
    // Block buttons
    property alias cfg_BlockButtonsVerticalMargin: blockButtonsVerticalMarginSpinBox.value
    property alias cfg_BlockButtonsHorizontalMargin: blockButtonsHorizontalMarginSpinBox.value
    property alias cfg_BlockButtonsSpacing: blockButtonsSpacingSpinBox.value
    property alias cfg_BlockButtonsSetCommonSizeForAll: blockButtonsSetCommonSizeForAllCheckBox.checked
    // Block labels
    property alias cfg_BlockLabelsMaximumLength: blockLabelsMaximumLengthSpinBox.value
    property string cfg_BlockLabelsCustomFont
    property int cfg_BlockLabelsCustomFontSize
    // Default style
    property alias cfg_DefaultShape: defaultShapeComboBox.currentIndex
    property alias cfg_DefaultLineWidth: defaultLineWidth.value
    property alias cfg_DefaultRadius: defaultRadiusSpinBox.value
    property alias cfg_DefaultInvertPosition: defaultInvertCheckBox.checked
    property alias cfg_DefaultColorSource: defaultColorComboBox.currentIndex
    property string cfg_DefaultColor
    // A style
    property alias cfg_BlockAShapeOverride: blockAShapeCheckBox.checked
    property alias cfg_BlockAShape: blockAShapeComboBox.currentIndex
    property alias cfg_BlockARadius: blockARadiusSpinBox.value
    property alias cfg_BlockAInvertPosition: blockAInvertCheckBox.checked
    property alias cfg_BlockAColorOverride: blockAColorCheckBox.checked
    property alias cfg_BlockAColorSource: blockAColorComboBox.currentIndex
    property string cfg_BlockAColor
    // B style
    property alias cfg_BlockBShapeOverride: blockBShapeCheckBox.checked
    property alias cfg_BlockBShape: blockBShapeComboBox.currentIndex
    property alias cfg_BlockBRadius: blockBRadiusSpinBox.value
    property alias cfg_BlockBInvertPosition: blockBInvertCheckBox.checked
    property alias cfg_BlockBColorOverride: blockBColorCheckBox.checked
    property alias cfg_BlockBColorSource: blockBColorComboBox.currentIndex
    property string cfg_BlockBColor
    // C style
    property alias cfg_BlockCShapeOverride: blockCShapeCheckBox.checked
    property alias cfg_BlockCShape: blockCShapeComboBox.currentIndex
    property alias cfg_BlockCRadius: blockCRadiusSpinBox.value
    property alias cfg_BlockCInvertPosition: blockCInvertCheckBox.checked
    property alias cfg_BlockCColorOverride: blockCColorCheckBox.checked
    property alias cfg_BlockCColorSource: blockCColorComboBox.currentIndex
    property string cfg_BlockCColor
    // D style
    property alias cfg_BlockDShapeOverride: blockDShapeCheckBox.checked
    property alias cfg_BlockDShape: blockDShapeComboBox.currentIndex
    property alias cfg_BlockDRadius: blockDRadiusSpinBox.value
    property alias cfg_BlockDInvertPosition: blockDInvertCheckBox.checked
    property alias cfg_BlockDColorOverride: blockDColorCheckBox.checked
    property alias cfg_BlockDColorSource: blockDColorComboBox.currentIndex
    property string cfg_BlockDColor
    // E style
    property alias cfg_BlockEShapeOverride: blockEShapeCheckBox.checked
    property alias cfg_BlockEShape: blockEShapeComboBox.currentIndex
    property alias cfg_BlockERadius: blockERadiusSpinBox.value
    property alias cfg_BlockEInvertPosition: blockEInvertCheckBox.checked
    property alias cfg_BlockEColorOverride: blockEColorCheckBox.checked
    property alias cfg_BlockEColorSource: blockEColorComboBox.currentIndex
    property string cfg_BlockEColor
    // F style
    property alias cfg_BlockFShapeOverride: blockFShapeCheckBox.checked
    property alias cfg_BlockFShape: blockFShapeComboBox.currentIndex
    property alias cfg_BlockFRadius: blockFRadiusSpinBox.value
    property alias cfg_BlockFInvertPosition: blockFInvertCheckBox.checked
    property alias cfg_BlockFColorOverride: blockFColorCheckBox.checked
    property alias cfg_BlockFColorSource: blockFColorComboBox.currentIndex
    property string cfg_BlockFColor

    GridLayout {
        columns: 1

        SectionHeader {
            text: "Animations"
        }

        CheckBox {
            id: animationsEnableCheckBox

            text: "Enable animations"
        }

        SectionHeader {
            text: "Block buttons"
        }

        RowLayout {
            Label {
                text: "Vertical margins:"
            }

            SpinBox {
                id: blockButtonsVerticalMarginSpinBox

                enabled: cfg_BlockIndicatorsStyle != 0 && cfg_BlockIndicatorsStyle != 4 && cfg_BlockIndicatorsStyle != 5
                value: cfg_BlockButtonsVerticalMargin
                minimumValue: 0
                maximumValue: 300
                suffix: " px"
            }

            HintIcon {
                visible: !blockButtonsVerticalMarginSpinBox.enabled
                tooltipText: "Not available for the selected indicator style"
            }

        }

        RowLayout {
            Label {
                text: "Horizontal margins:"
            }

            SpinBox {
                id: blockButtonsHorizontalMarginSpinBox

                enabled: cfg_BlockIndicatorsStyle != 5
                value: cfg_BlockButtonsHorizontalMargin
                minimumValue: 0
                maximumValue: 300
                suffix: " px"
            }

            HintIcon {
                visible: !blockButtonsHorizontalMarginSpinBox.enabled
                tooltipText: "Not available for the selected indicator style"
            }

        }

        RowLayout {
            Label {
                text: "Spacing between buttons:"
            }

            SpinBox {
                id: blockButtonsSpacingSpinBox

                value: cfg_BlockButtonsSpacing
                minimumValue: 0
                maximumValue: 100
                suffix: " px"
            }

        }

        RowLayout {
            spacing: 0

            CheckBox {
                id: blockButtonsSetCommonSizeForAllCheckBox

                text: "Set common size for all buttons"
            }

            HintIcon {
                tooltipText: "The size is based on the largest button"
            }

        }

        SectionHeader {
            text: "Block labels"
        }

        RowLayout {
            Label {
                text: "Maximum length:"
            }

            SpinBox {
                id: blockLabelsMaximumLengthSpinBox

                minimumValue: 3
                maximumValue: 100
                suffix: " chars"
            }

        }

        RowLayout {
            spacing: 0

            CheckBox {
                id: blockLabelsCustomFontCheckBox

                checked: cfg_BlockLabelsCustomFont
                onCheckedChanged: {
                    if (checked) {
                        var currentIndex = blockLabelsCustomFontComboBox.currentIndex;
                        var selectedFont = blockLabelsCustomFontComboBox.model[currentIndex].value;
                        cfg_BlockLabelsCustomFont = selectedFont;
                    } else {
                        cfg_BlockLabelsCustomFont = "";
                    }
                }
                text: "Custom font:"
            }

            ComboBox {
                id: blockLabelsCustomFontComboBox

                enabled: blockLabelsCustomFontCheckBox.checked
                implicitWidth: 130
                Component.onCompleted: {
                    var array = [];
                    var fonts = Qt.fontFamilies();
                    for (var i = 0; i < fonts.length; i++) {
                        array.push({
                            "text": fonts[i],
                            "value": fonts[i]
                        });
                    }
                    model = array;
                    var foundIndex = find(cfg_BlockLabelsCustomFont);
                    if (foundIndex == -1)
                        foundIndex = find(theme.defaultFont.family);

                    if (foundIndex >= 0)
                        currentIndex = foundIndex;

                }
                onCurrentIndexChanged: {
                    if (enabled && currentIndex) {
                        var selectedFont = model[currentIndex].value;
                        cfg_BlockLabelsCustomFont = selectedFont;
                    }
                }
            }

        }

        RowLayout {
            spacing: 0

            CheckBox {
                id: blockLabelsCustomFontSizeCheckBox

                checked: cfg_BlockLabelsCustomFontSize > 0
                onCheckedChanged: cfg_BlockLabelsCustomFontSize = checked ? blockLabelsCustomFontSizeSpinBox.value : 0
                text: "Custom font size:"
            }

            SpinBox {
                id: blockLabelsCustomFontSizeSpinBox

                enabled: blockLabelsCustomFontSizeCheckBox.checked
                value: cfg_BlockLabelsCustomFontSize || theme.defaultFont.pixelSize
                minimumValue: 5
                maximumValue: 100
                suffix: " px"
                onValueChanged: {
                    if (blockLabelsCustomFontSizeCheckBox.checked)
                        cfg_BlockLabelsCustomFontSize = value;

                }
            }

        }

        // Default
        SectionHeader {
            text: "Default Indicator"
        }

        RowLayout {
            Label {
                text: "Shape:"
            }

            ComboBox {
                id: defaultShapeComboBox

                implicitWidth: 100
                model: ["Edge line", "Side line", "Block", "Rounded", "Full size", "Use labels"]
                onCurrentIndexChanged: {
                    if (cfg_DefaultShape == 2)
                        cfg_DefaultRadius = defaultRadiusSpinBox.value;
                    else
                        cfg_DefaultRadius = 2;
                }
                Component.onCompleted: {
                    if (cfg_DefaultShape != 2)
                        cfg_DefaultRadius = 2;

                }
            }

            SpinBox {
                id: defaultRadiusSpinBox

                visible: cfg_DefaultShape == 2
                value: cfg_DefaultRadius
                minimumValue: 0
                maximumValue: 300
                suffix: " px corner radius"
            }

            CheckBox {
                id: defaultInvertCheckBox

                visible: (cfg_DefaultShape < 2)
                text: "Invert indicator's position"
            }

        }

        RowLayout {
            Label {
                text: "Color:"
            }

            ComboBox {
                id: defaultColorComboBox

                implicitWidth: 100
                model: ["Theme Text", "Theme Accent", "Custom"]
                onCurrentIndexChanged: {
                    if (currentIndex == 0) {
                        defaultColorColorButton.color = theme.textColor;
                        cfg_DefaultColor = theme.textColor;
                    } else if (currentIndex == 1) {
                        defaultColorColorButton.color = theme.buttonFocusColor;
                        cfg_DefaultColor = theme.buttonFocusColor;
                    }
                }
            }

            ColorButton {
                id: defaultColorColorButton

                enabled: defaultColorComboBox.currentIndex == 2
                color: defaultColorComboBox.currentIndex == 0 ? theme.textColor : (defaultColorComboBox.currentIndex == 1 ? theme.buttonFocusColor : (cfg_DefaultColor || theme.textColor))
                colorAcceptedCallback: function(color) {
                    cfg_DefaultColor = color;
                }
            }

        }

        RowLayout {
            Label {
                text: "Line width:"
            }

            SpinBox {
                id: defaultLineWidth

                value: cfg_DefaultLineWidth
                minimumValue: 0
                maximumValue: 300
                suffix: " px"
            }

        }
        // Default end

        // A
        SectionHeader {
            text: "Style A"
        }

        RowLayout {
            CheckBox {
                id: blockAShapeCheckBox

                text: "Override Shape"
            }

            ComboBox {
                id: blockAShapeComboBox

                enabled: blockAShapeCheckBox.checked
                implicitWidth: 100
                model: ["Edge line", "Side line", "Block", "Rounded", "Full size", "Use labels"]
                onCurrentIndexChanged: {
                    if (cfg_BlockAShape == 2)
                        cfg_BlockARadius = blockARadiusSpinBox.value;
                    else
                        cfg_BlockARadius = 2;
                }
                Component.onCompleted: {
                    if (cfg_BlockAShape != 2)
                        cfg_BlockARadius = 2;

                }
            }

            SpinBox {
                id: blockARadiusSpinBox

                enabled: blockAShapeCheckBox.checked
                visible: cfg_BlockAShape == 2
                value: cfg_BlockARadius
                minimumValue: 0
                maximumValue: 300
                suffix: " px corner radius"
            }

            CheckBox {
                id: blockAInvertCheckBox

                visible: blockAShapeCheckBox.checked && (cfg_BlockAShape < 2)
                text: "Invert indicator's position"
            }

        }

        RowLayout {
            CheckBox {
                id: blockAColorCheckBox

                text: "Override Color"
            }

            ComboBox {
                id: blockAColorComboBox

                enabled: blockAColorCheckBox.checked
                implicitWidth: 100
                model: ["Theme Text", "Theme Accent", "Custom"]
                onCurrentIndexChanged: {
                    if (blockAColorCheckBox.checked) {
                        if (currentIndex == 0) {
                            blockAColorColorButton.color = theme.textColor;
                            cfg_BlockAColor = theme.textColor;
                        } else if (currentIndex == 1) {
                            blockAColorColorButton.color = theme.buttonFocusColor;
                            cfg_BlockAColor = theme.buttonFocusColor;
                        }
                    }
                }
            }

            ColorButton {
                id: blockAColorColorButton

                enabled: blockAColorCheckBox.checked && blockAColorComboBox.currentIndex == 2
                color: blockAColorComboBox.currentIndex == 0 ? theme.textColor : (blockAColorComboBox.currentIndex == 1 ? theme.buttonFocusColor : (cfg_BlockAColor || theme.textColor))
                colorAcceptedCallback: function(color) {
                    cfg_BlockAColor = color;
                }
            }

        }
        // A End

        // B
        SectionHeader {
            text: "Style B"
        }

        RowLayout {
            CheckBox {
                id: blockBShapeCheckBox

                text: "Override Shape"
            }

            ComboBox {
                id: blockBShapeComboBox

                enabled: blockBShapeCheckBox.checked
                implicitWidth: 100
                model: ["Edge line", "Side line", "Block", "Rounded", "Full size", "Use labels"]
                onCurrentIndexChanged: {
                    if (cfg_BlockBShape == 2)
                        cfg_BlockBRadius = blockBRadiusSpinBox.value;
                    else
                        cfg_BlockBRadius = 2;
                }
                Component.onCompleted: {
                    if (cfg_BlockBShape != 2)
                        cfg_BlockBRadius = 2;

                }
            }

            SpinBox {
                id: blockBRadiusSpinBox

                enabled: blockBShapeCheckBox.checked
                visible: cfg_BlockBShape == 2
                value: cfg_BlockBRadius
                minimumValue: 0
                maximumValue: 300
                suffix: " px corner radius"
            }

            CheckBox {
                id: blockBInvertCheckBox

                visible: blockBShapeCheckBox.checked && (cfg_BlockBShape < 2)
                text: "Invert indicator's position"
            }

        }

        RowLayout {
            CheckBox {
                id: blockBColorCheckBox

                text: "Override Color"
            }

            ComboBox {
                id: blockBColorComboBox

                enabled: blockBColorCheckBox.checked
                implicitWidth: 100
                model: ["Theme Text", "Theme Accent", "Custom"]
                onCurrentIndexChanged: {
                    if (blockBColorCheckBox.checked) {
                        if (currentIndex == 0) {
                            blockBColorColorButton.color = theme.textColor;
                            cfg_BlockBColor = theme.textColor;
                        } else if (currentIndex == 1) {
                            blockBColorColorButton.color = theme.buttonFocusColor;
                            cfg_BlockBColor = theme.buttonFocusColor;
                        }
                    }
                }
            }

            ColorButton {
                id: blockBColorColorButton

                enabled: blockBColorCheckBox.checked && blockBColorComboBox.currentIndex == 2
                color: blockBColorComboBox.currentIndex == 0 ? theme.textColor : (blockBColorComboBox.currentIndex == 1 ? theme.buttonFocusColor : (cfg_BlockBColor || theme.textColor))
                colorAcceptedCallback: function(color) {
                    cfg_BlockBColor = color;
                }
            }

        }
        // B End

        // C
        SectionHeader {
            text: "Style C"
        }

        RowLayout {
            CheckBox {
                id: blockCShapeCheckBox

                text: "Override Shape"
            }

            ComboBox {
                id: blockCShapeComboBox

                enabled: blockCShapeCheckBox.checked
                implicitWidth: 100
                model: ["Edge line", "Side line", "Block", "Rounded", "Full size", "Use labels"]
                onCurrentIndexChanged: {
                    if (cfg_BlockCShape == 2)
                        cfg_BlockCRadius = blockCRadiusSpinBox.value;
                    else
                        cfg_BlockCRadius = 2;
                }
                Component.onCompleted: {
                    if (cfg_BlockCShape != 2)
                        cfg_BlockCRadius = 2;

                }
            }

            SpinBox {
                id: blockCRadiusSpinBox

                enabled: blockCShapeCheckBox.checked
                visible: cfg_BlockCShape == 2
                value: cfg_BlockCRadius
                minimumValue: 0
                maximumValue: 300
                suffix: " px corner radius"
            }

            CheckBox {
                id: blockCInvertCheckBox

                visible: blockCShapeCheckBox.checked && (cfg_BlockCShape < 2)
                text: "Invert indicator's position"
            }

        }

        RowLayout {
            CheckBox {
                id: blockCColorCheckBox

                text: "Override Color"
            }

            ComboBox {
                id: blockCColorComboBox

                enabled: blockCColorCheckBox.checked
                implicitWidth: 100
                model: ["Theme Text", "Theme Accent", "Custom"]
                onCurrentIndexChanged: {
                    if (blockCColorCheckBox.checked) {
                        if (currentIndex == 0) {
                            blockCColorColorButton.color = theme.textColor;
                            cfg_BlockCColor = theme.textColor;
                        } else if (currentIndex == 1) {
                            blockCColorColorButton.color = theme.buttonFocusColor;
                            cfg_BlockCColor = theme.buttonFocusColor;
                        }
                    }
                }
            }

            ColorButton {
                id: blockCColorColorButton

                enabled: blockCColorCheckBox.checked && blockCColorComboBox.currentIndex == 2
                color: blockCColorComboBox.currentIndex == 0 ? theme.textColor : (blockCColorComboBox.currentIndex == 1 ? theme.buttonFocusColor : (cfg_BlockCColor || theme.textColor))
                colorAcceptedCallback: function(color) {
                    cfg_BlockCColor = color;
                }
            }

        }
        // C End

        // D
        SectionHeader {
            text: "Style D"
        }

        RowLayout {
            CheckBox {
                id: blockDShapeCheckBox

                text: "Override Shape"
            }

            ComboBox {
                id: blockDShapeComboBox

                enabled: blockDShapeCheckBox.checked
                implicitWidth: 100
                model: ["Edge line", "Side line", "Block", "Rounded", "Full size", "Use labels"]
                onCurrentIndexChanged: {
                    if (cfg_BlockDShape == 2)
                        cfg_BlockDRadius = blockDRadiusSpinBox.value;
                    else
                        cfg_BlockDRadius = 2;
                }
                Component.onCompleted: {
                    if (cfg_BlockDShape != 2)
                        cfg_BlockDRadius = 2;

                }
            }

            SpinBox {
                id: blockDRadiusSpinBox

                enabled: blockDShapeCheckBox.checked
                visible: cfg_BlockDShape == 2
                value: cfg_BlockDRadius
                minimumValue: 0
                maximumValue: 300
                suffix: " px corner radius"
            }

            CheckBox {
                id: blockDInvertCheckBox

                visible: blockDShapeCheckBox.checked && (cfg_BlockDShape < 2)
                text: "Invert indicator's position"
            }

        }

        RowLayout {
            CheckBox {
                id: blockDColorCheckBox

                text: "Override Color"
            }

            ComboBox {
                id: blockDColorComboBox

                enabled: blockDColorCheckBox.checked
                implicitWidth: 100
                model: ["Theme Text", "Theme Accent", "Custom"]
                onCurrentIndexChanged: {
                    if (blockDColorCheckBox.checked) {
                        if (currentIndex == 0) {
                            blockDColorColorButton.color = theme.textColor;
                            cfg_BlockDColor = theme.textColor;
                        } else if (currentIndex == 1) {
                            blockDColorColorButton.color = theme.buttonFocusColor;
                            cfg_BlockDColor = theme.buttonFocusColor;
                        }
                    }
                }
            }

            ColorButton {
                id: blockDColorColorButton

                enabled: blockDColorCheckBox.checked && blockDColorComboBox.currentIndex == 2
                color: blockDColorComboBox.currentIndex == 0 ? theme.textColor : (blockDColorComboBox.currentIndex == 1 ? theme.buttonFocusColor : (cfg_BlockDColor || theme.textColor))
                colorAcceptedCallback: function(color) {
                    cfg_BlockDColor = color;
                }
            }

        }
        // D End

        // E
        SectionHeader {
            text: "Style E"
        }

        RowLayout {
            CheckBox {
                id: blockEShapeCheckBox

                text: "Override Shape"
            }

            ComboBox {
                id: blockEShapeComboBox

                enabled: blockEShapeCheckBox.checked
                implicitWidth: 100
                model: ["Edge line", "Side line", "Block", "Rounded", "Full size", "Use labels"]
                onCurrentIndexChanged: {
                    if (cfg_BlockEShape == 2)
                        cfg_BlockERadius = blockERadiusSpinBox.value;
                    else
                        cfg_BlockERadius = 2;
                }
                Component.onCompleted: {
                    if (cfg_BlockEShape != 2)
                        cfg_BlockERadius = 2;

                }
            }

            SpinBox {
                id: blockERadiusSpinBox

                enabled: blockEShapeCheckBox.checked
                visible: cfg_BlockEShape == 2
                value: cfg_BlockERadius
                minimumValue: 0
                maximumValue: 300
                suffix: " px corner radius"
            }

            CheckBox {
                id: blockEInvertCheckBox

                visible: blockEShapeCheckBox.checked && (cfg_BlockEShape < 2)
                text: "Invert indicator's position"
            }

        }

        RowLayout {
            CheckBox {
                id: blockEColorCheckBox

                text: "Override Color"
            }

            ComboBox {
                id: blockEColorComboBox

                enabled: blockEColorCheckBox.checked
                implicitWidth: 100
                model: ["Theme Text", "Theme Accent", "Custom"]
                onCurrentIndexChanged: {
                    if (blockEColorCheckBox.checked) {
                        if (currentIndex == 0) {
                            blockEColorColorButton.color = theme.textColor;
                            cfg_BlockEColor = theme.textColor;
                        } else if (currentIndex == 1) {
                            blockEColorColorButton.color = theme.buttonFocusColor;
                            cfg_BlockEColor = theme.buttonFocusColor;
                        }
                    }
                }
            }

            ColorButton {
                id: blockEColorColorButton

                enabled: blockEColorCheckBox.checked && blockEColorComboBox.currentIndex == 2
                color: blockEColorComboBox.currentIndex == 0 ? theme.textColor : (blockEColorComboBox.currentIndex == 1 ? theme.buttonFocusColor : (cfg_BlockEColor || theme.textColor))
                colorAcceptedCallback: function(color) {
                    cfg_BlockEColor = color;
                }
            }

        }
        // E End

        // F
        SectionHeader {
            text: "Style F"
        }

        RowLayout {
            CheckBox {
                id: blockFShapeCheckBox

                text: "Override Shape"
            }

            ComboBox {
                id: blockFShapeComboBox

                enabled: blockFShapeCheckBox.checked
                implicitWidth: 100
                model: ["Edge line", "Side line", "Block", "Rounded", "Full size", "Use labels"]
                onCurrentIndexChanged: {
                    if (cfg_BlockFShape == 2)
                        cfg_BlockFRadius = blockFRadiusSpinBox.value;
                    else
                        cfg_BlockFRadius = 2;
                }
                Component.onCompleted: {
                    if (cfg_BlockFShape != 2)
                        cfg_BlockFRadius = 2;

                }
            }

            SpinBox {
                id: blockFRadiusSpinBox

                enabled: blockFShapeCheckBox.checked
                visible: cfg_BlockFShape == 2
                value: cfg_BlockFRadius
                minimumValue: 0
                maximumValue: 300
                suffix: " px corner radius"
            }

            CheckBox {
                id: blockFInvertCheckBox

                visible: blockFShapeCheckBox.checked && (cfg_BlockFShape < 2)
                text: "Invert indicator's position"
            }

        }

        RowLayout {
            CheckBox {
                id: blockFColorCheckBox

                text: "Override Color"
            }

            ComboBox {
                id: blockFColorComboBox

                enabled: blockFColorCheckBox.checked
                implicitWidth: 100
                model: ["Theme Text", "Theme Accent", "Custom"]
                onCurrentIndexChanged: {
                    if (blockFColorCheckBox.checked) {
                        if (currentIndex == 0) {
                            blockFColorColorButton.color = theme.textColor;
                            cfg_BlockFColor = theme.textColor;
                        } else if (currentIndex == 1) {
                            blockFColorColorButton.color = theme.buttonFocusColor;
                            cfg_BlockFColor = theme.buttonFocusColor;
                        }
                    }
                }
            }

            ColorButton {
                id: blockFColorColorButton

                enabled: blockFColorCheckBox.checked && blockFColorComboBox.currentIndex == 2
                color: blockFColorComboBox.currentIndex == 0 ? theme.textColor : (blockFColorComboBox.currentIndex == 1 ? theme.buttonFocusColor : (cfg_BlockFColor || theme.textColor))
                colorAcceptedCallback: function(color) {
                    cfg_BlockFColor = color;
                }
            }

        }
        // F End

    }

}
