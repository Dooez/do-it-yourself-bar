import "../common/Utils.js" as Utils
import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3

Component {
    Rectangle {
        property string style: ""
        property string labelText: ""
        property string tooltipText: ""
        property string commandToExecOnClick: ""
        property int blockIndicatorStyle: getBlockShape()
        property bool blockInvertPosition: getInvertPosition()
        property alias _label: label
        property alias _indicator: indicator
        readonly property int tooltipWaitDuration: 800
        readonly property int animationWidthDuration: 100
        readonly property int animationColorDuration: 150
        readonly property int animationOpacityDuration: 150

        function getBlockColor() {
            if (style == "A")
                return config.BlockAColorOverride ? config.BlockAColor : (config.DefaultColor || theme.textColor);
            else if (style == "B")
                return config.BlockBColorOverride ? config.BlockBColor : (config.DefaultColor || theme.textColor);
            else if (style == "C")
                return config.BlockCColorOverride ? config.BlockCColor : (config.DefaultColor || theme.textColor);
            else if (style == "D")
                return config.BlockDColorOverride ? config.BlockDColor : (config.DefaultColor || theme.textColor);
            else if (style == "E")
                return config.BlockEColorOverride ? config.BlockEColor : (config.DefaultColor || theme.textColor);
            else if (style == "F")
                return config.BlockFColorOverride ? config.BlockFColor : (config.DefaultColor || theme.textColor);
            return config.DefaultColor || theme.textColor;
        }

        function getBlockShape() {
            if (style == "A")
                return config.BlockAShapeOverride ? config.BlockAShape : config.DefaultShape;
            else if (style == "B")
                return config.BlockBShapeOverride ? config.BlockBShape : config.DefaultShape;
            else if (style == "C")
                return config.BlockCShapeOverride ? config.BlockCShape : config.DefaultShape;
            else if (style == "D")
                return config.BlockDShapeOverride ? config.BlockDShape : config.DefaultShape;
            else if (style == "E")
                return config.BlockEShapeOverride ? config.BlockEShape : config.DefaultShape;
            else if (style == "F")
                return config.BlockFShapeOverride ? config.BlockFShape : config.DefaultShape;
            else
                return config.DefaultShape;
        }

        function getInvertPosition() {
            if (style == "A")
                return config.BlockAShapeOverride ? config.BlockAInvertPosition : config.DefaultInvertPosition;
            else if (style == "B")
                return config.BlockBShapeOverride ? config.BlockBInvertPosition : config.DefaultInvertPosition;
            else if (style == "C")
                return config.BlockCShapeOverride ? config.BlockCInvertPosition : config.DefaultInvertPosition;
            else if (style == "D")
                return config.BlockDShapeOverride ? config.BlockDInvertPosition : config.DefaultInvertPosition;
            else if (style == "E")
                return config.BlockEShapeOverride ? config.BlockEInvertPosition : config.DefaultInvertPosition;
            else if (style == "F")
                return config.BlockFShapeOverride ? config.BlockFInvertPosition : config.DefaultInvertPosition;
            else
                return config.DefaultInvertPosition;
        }

        function getRadius() {
            if (style == "A")
                return config.BlockAShapeOverride ? config.BlockARadius : config.DefaultRadius;
            else if (style == "B")
                return config.BlockBShapeOverride ? config.BlockBRadius : config.DefaultRadius;
            else if (style == "C")
                return config.BlockCShapeOverride ? config.BlockCRadius : config.DefaultRadius;
            else if (style == "D")
                return config.BlockDShapeOverride ? config.BlockDRadius : config.DefaultRadius;
            else if (style == "E")
                return config.BlockEShapeOverride ? config.BlockERadius : config.DefaultRadius;
            else if (style == "F")
                return config.BlockFShapeOverride ? config.BlockFRadius : config.DefaultRadius;
            else
                return config.DefaultRadius;
        }

        function updateLabel() {
            label.text = Qt.binding(function() {
                if (labelText.length > config.BlockLabelsMaximumLength)
                    return labelText.substr(0, config.BlockLabelsMaximumLength - 1) + "…";

                return labelText;
            });
        }

        function update(blockInfo) {
            style = blockInfo.style;
            labelText = blockInfo.labelText;
            tooltipText = blockInfo.tooltipText;
            commandToExecOnClick = blockInfo.commandToExecOnClick;
            updateLabel();
        }

        function show() {
            var self = this;
            implicitWidth = Qt.binding(function() {
                if (isVerticalOrientation)
                    return parent.width;

                var newImplicitWidth = label.implicitWidth + 2 * config.BlockButtonsHorizontalMargin + 2 * config.BlockButtonsSpacing;
                if (config.BlockButtonsSetCommonSizeForAll && container.largestBlockButton && container.largestBlockButton != self && container.largestBlockButton.implicitWidth > newImplicitWidth)
                    return container.largestBlockButton.implicitWidth;

                return newImplicitWidth;
            });
            implicitHeight = Qt.binding(function() {
                if (!isVerticalOrientation)
                    return parent.height;

                return label.implicitHeight + 2 * config.BlockButtonsVerticalMargin + 2 * config.BlockButtonsSpacing;
            });
            if (config.AnimationsEnable)
                Utils.delay(animationWidthDuration, function() {
                opacity = 1;
            });

        }

        function hide(callback) {
            opacity = 0;
            var resetDimensions = function resetDimensions() {
                implicitWidth = isVerticalOrientation ? parent.width : 0;
                implicitHeight = isVerticalOrientation ? 0 : parent.height;
            };
            var postHideCallback = callback ? callback : function() {
            };
            if (config.AnimationsEnable) {
                Utils.delay(animationOpacityDuration, function() {
                    resetDimensions();
                    Utils.delay(animationWidthDuration, postHideCallback);
                });
                return ;
            }
            resetDimensions();
            postHideCallback();
        }

        Layout.fillWidth: isVerticalOrientation
        Layout.fillHeight: !isVerticalOrientation
        clip: true
        color: "transparent"
        opacity: !config.AnimationsEnable ? 1 : 0
        onImplicitWidthChanged: {
            if (!config.AnimationsEnable)
                Utils.delay(100, container.updateLargestBlockButton);

        }

        // Indicator
        Rectangle {
            id: indicator

            property int lineWidth: config.DefaultLineWidth

            visible: blockIndicatorStyle != 5
            // color: getBlockColor()
            color: {
                return getBlockColor();
            }
            width: {
                if (isVerticalOrientation) {
                    if (blockIndicatorStyle == 1)
                        return lineWidth;

                    if (blockIndicatorStyle == 4)
                        return parent.width;

                    if (config.BlockButtonsSetCommonSizeForAll && container.largestBlockButton && container.largestBlockButton != parent && container.largestBlockButton._label.implicitWidth > label.implicitWidth)
                        return container.largestBlockButton._indicator.width;

                    return label.implicitWidth + 2 * config.BlockButtonsHorizontalMargin;
                }
                if (blockIndicatorStyle == 1)
                    return lineWidth;

                return parent.width + 0.5 - 2 * config.BlockButtonsSpacing;
            }
            height: {
                if (blockIndicatorStyle == 4) {
                    if (isVerticalOrientation)
                        return parent.height + 0.5 - 2 * config.BlockButtonsSpacing;

                    return parent.height;
                }
                if (blockIndicatorStyle > 0)
                    return label.implicitHeight + 2 * config.BlockButtonsVerticalMargin;

                return lineWidth;
            }
            x: {
                if (isVerticalOrientation) {
                    if (blockIndicatorStyle != 1)
                        return (parent.width - width) / 2;

                    return blockInvertPosition ? parent.width - lineWidth : 0;
                }
                if (blockIndicatorStyle == 1 && blockInvertPosition)
                    return parent.width - width - (config.BlockButtonsSpacing || 0);

                return config.BlockButtonsSpacing || 0;
            }
            y: {
                if (blockIndicatorStyle > 0)
                    return (parent.height - height) / 2;

                if (isTopLocation)
                    return !blockInvertPosition ? parent.height - height + 1 : 0;

                return !blockInvertPosition ? 0 : parent.height - height + 1;
            }
            radius: {
                if (blockIndicatorStyle == 2)
                    return getRadius();

                if (blockIndicatorStyle == 3)
                    return 300;

                return 0;
            }

            Behavior on color {
                enabled: config.AnimationsEnable

                animation: ColorAnimation {
                    duration: animationColorDuration
                }

            }

        }

        // Label
        Text {
            id: label

            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            text: labelText
            textFormat: Text.RichText
            color: {
                if (blockIndicatorStyle == 5)
                    return indicator.color;

                if (parent.style == "A")
                    return config.BlockLabelsCustomColorForStyleA || theme.textColor;

                if (parent.style == "B")
                    return config.BlockLabelsCustomColorForStyleB || theme.textColor;

                if (parent.style == "C")
                    return config.BlockLabelsCustomColorForStyleC || theme.textColor;

                return theme.textColor;
            }
            font.family: config.BlockLabelsCustomFont || theme.defaultFont.family
            font.pixelSize: config.BlockLabelsCustomFontSize || theme.defaultFont.pixelSize

            Behavior on color {
                enabled: config.AnimationsEnable

                animation: ColorAnimation {
                    duration: animationColorDuration
                }

            }

            Behavior on opacity {
                enabled: config.AnimationsEnable

                animation: NumberAnimation {
                    duration: animationOpacityDuration
                }

            }

        }

        MouseArea {
            id: mouseArea

            property var tooltipTimer

            function killTooltipTimer() {
                if (tooltipTimer) {
                    tooltipTimer.stop();
                    tooltipTimer = null;
                }
            }

            anchors.fill: parent
            hoverEnabled: true
            acceptedButtons: Qt.LeftButton
            onEntered: {
                if (!tooltipText)
                    return ;

                tooltipTimer = Utils.delay(tooltipWaitDuration, function() {
                    if (containsMouse)
                        tooltip.show(parent);

                });
            }
            onExited: {
                if (tooltipText) {
                    killTooltipTimer();
                    tooltip.visible = false;
                }
            }
            onClicked: {
                if (tooltipText) {
                    killTooltipTimer();
                    tooltip.visible = false;
                }
                if (mouse.button == Qt.LeftButton)
                    backend.runCommand(commandToExecOnClick);

            }
        }

        Behavior on opacity {
            enabled: config.AnimationsEnable

            animation: NumberAnimation {
                duration: animationOpacityDuration
            }

        }

        Behavior on implicitWidth {
            enabled: config.AnimationsEnable

            animation: NumberAnimation {
                duration: animationWidthDuration
                onRunningChanged: {
                    if (!running)
                        Utils.delay(100, container.updateLargestBlockButton);

                }
            }

        }

        Behavior on implicitHeight {
            enabled: config.AnimationsEnable

            animation: NumberAnimation {
                duration: animationWidthDuration
            }

        }

    }

}
