import QtQuick
import QtCore

import QtQuick.Controls
import QtQuick.Layouts

import org.qfield
import org.qgis
import Theme

import "."

Item {
    id: plugin

    Settings {
        id: multiplierSettings
        property real selectedMultiplier: 1.0
        property int selectedMultiplierIndex: 2
        property var showCrosshairOverlay: true
        property bool enableThemeManager: false
        property bool showToolbarButton: true
    }

    property var mainWindow: iface.mainWindow()
    property var positionSource: iface.findItemByObjectName('positionSource')
    property var coordinateLocator: iface.findItemByObjectName('coordinateLocator')
    property var projectInfo: iface.findItemByObjectName('projectInfo')
    property var mapCanvas: null

    property var legend: iface.findItemByObjectName('Legend')

    property point crosshairPos: Qt.point(width / 2, height / 2)

    Loader {
        id: themeManagerLoader
        active: multiplierSettings.enableThemeManager
        sourceComponent: ThemeManager {
            id: themeManager
            width: plugin.mainWindow ? plugin.mainWindow.width : 0
            height: plugin.mainWindow ? plugin.mainWindow.height : 0
        }
    }

    property point displayPosition: coordinateLocator ? coordinateLocator.displayPosition : Qt.point(width / 2, height / 2)

    function recalculateLayerFontSize() {
        let multiplier = multiplierSettings.selectedMultiplier > 0.0 ? multiplierSettings.selectedMultiplier : 1.0;
        var pointSize = Theme.tipFont.pointSize * multiplier;
        var dashBoard = iface.findItemByObjectName('dashBoard');

        var layerElements = dashBoard?.contentData[2]?.children[2]?.children[0]?.children[0]?.children;
        if (!layerElements) {
            return;
        }

        for (var i = 0; i < layerElements.length; i++) {
            var element = layerElements[i];
            let label = element.children[2].children[1].children[2];
            label.font.pointSize = pointSize;
        }
    }
    // Update crosshair position when displayPosition changes
    onDisplayPositionChanged: {
        console.log("Display position changed to:", displayPosition);
        crosshairPos = displayPosition;
    }

    Component.onCompleted: {
        iface.addItemToPluginsToolbar(makeItPinkButton);

        mapCanvas = iface.mapCanvas();
        if (mapCanvas) {
            console.log("MapCanvas found, size:", mapCanvas.width + "x" + mapCanvas.height);

            // Dynamically reparent crosshair to mapCanvas
            customCrosshair.parent = mapCanvas;

            // Set initial position from coordinateLocator's displayPosition
            if (coordinateLocator) {
                crosshairPos = coordinateLocator.displayPosition;
                console.log("Initial crosshair position set to:", crosshairPos);
            }
        } else {
            iface.logMessage("No mapCanvas available.");
        }
        layerTextSizeSettings.parent = iface.mainWindow().contentItem;
        comboBoxMultipliers.currentIndex = multiplierSettings.selectedMultiplierIndex;
        crosshairOverlayCheckbox.checked = multiplierSettings.showCrosshairOverlay;
        themeManagerCheckbox.checked = multiplierSettings.enableThemeManager;
        toolbarButtonCheckbox.checked = multiplierSettings.showToolbarButton;
        makeItPinkButton.visible = multiplierSettings.showToolbarButton;
        plugin.recalculateLayerFontSize();
    }

    // Timer to recalculate layer font size every 10 seconds
    Timer {
        id: fontSizeTimer
        interval: 5000  // 5 seconds in milliseconds
        running: true
        repeat: true
        onTriggered: {
            plugin.recalculateLayerFontSize();
        }
    }

    // Connect to coordinateLocator signals for real-time updates
    Connections {
        target: plugin.coordinateLocator
        function onDisplayPositionChanged() {
            plugin.crosshairPos = plugin.coordinateLocator.displayPosition;
        }
        function onSourceLocationChanged() {
            if (plugin.coordinateLocator.sourceLocation !== undefined) {
                plugin.crosshairPos = plugin.coordinateLocator.sourceLocation;
            }
        }
        function onCurrentCoordinateChanged() {
            // Update display position when coordinate changes
            if (plugin.coordinateLocator.displayPosition !== undefined) {
                plugin.crosshairPos = plugin.coordinateLocator.displayPosition;
            }
        }
    }

    Dialog {
        id: layerTextSizeSettings
        modal: true
        visible: false
        font: Theme.defaultFont
        title: qsTr("FeelGood UI Tweaker Settings")

        x: (mainWindow.width - width) / 2
        y: (mainWindow.height - height) / 2

        contentItem: ScrollView {
            id: settingsScroll
            clip: true
            ScrollBar.vertical.policy: ScrollBar.AsNeeded
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

            ColumnLayout {
                id: settingsContent
                width: settingsScroll.availableWidth
                spacing: 10

                Label {
                    id: labelSelection
                    wrapMode: Text.Wrap
                    text: qsTr("Layer text size settings")
                    font: Theme.defaultFont
                }

                ComboBox {
                    id: comboBoxMultipliers
                    Layout.fillWidth: true
                    currentIndex: 2  // Default to 1.0 (index 2 in the model array)

                    model: [0.5, 0.75, 1.0, 1.25, 1.5, 2.0, 2.5, 3.0]
                }

                CheckBox {
                    id: crosshairOverlayCheckbox
                    text: qsTr("Show Crosshair Overlay")
                    checked: multiplierSettings.showCrosshairOverlay
                    font: Theme.defaultFont
                    onToggled: {
                        multiplierSettings.showCrosshairOverlay = checked;
                        customCrosshair.visible = multiplierSettings.showCrosshairOverlay && projectInfo.stateMode === "digitize";
                    }
                }

                CheckBox {
                    id: themeManagerCheckbox
                    text: qsTr("Enable Theme Manager")
                    checked: multiplierSettings.enableThemeManager
                    font: Theme.defaultFont
                    onToggled: {
                        multiplierSettings.enableThemeManager = checked;
                    }
                }

                CheckBox {
                    id: toolbarButtonCheckbox
                    text: qsTr("Show toolbar button")
                    checked: multiplierSettings.showToolbarButton
                    font: Theme.defaultFont
                    onToggled: {
                        multiplierSettings.showToolbarButton = checked;
                        makeItPinkButton.visible = checked;
                    }
                }

                Label {
                    text: qsTr("Note: You can always access these settings through the plugin manager in Settings.")
                    font: Theme.defaultFont
                    wrapMode: Text.Wrap
                    color: Theme.secondaryTextColor
                    Layout.fillWidth: true
                }
            }
        }

        footer: RowLayout {
            Layout.fillWidth: true
            spacing: 8

            QfToolButton {
                id: themeUiButton
                iconSource: 'palette_icon.svg'
                iconColor: Theme.mainColor
                bgcolor: '#00ffffff'
                visible: multiplierSettings.enableThemeManager
                round: true

                onClicked: {
                    if (themeManagerLoader.item && themeManagerLoader.item.openThemeDialog)
                        themeManagerLoader.item.openThemeDialog();
                }
            }

            Item {
                Layout.fillWidth: true
            }

            DialogButtonBox {
                Layout.alignment: Qt.AlignRight
                standardButtons: DialogButtonBox.Ok
                onAccepted: layerTextSizeSettings.accept()
            }
        }

        onAccepted: {
            multiplierSettings.selectedMultiplier = comboBoxMultipliers.currentText;
            multiplierSettings.selectedMultiplierIndex = comboBoxMultipliers.currentIndex;
            plugin.recalculateLayerFontSize();
        }
    }

    CrosshairOverlay {
        id: customCrosshair
        width: 120
        height: 120

        x: plugin.crosshairPos.x - width / 2
        y: plugin.crosshairPos.y - height / 2
        visible: multiplierSettings.showCrosshairOverlay && projectInfo.stateMode === "digitize"
        z: 999 // High z-index to ensure visibility

        // Smooth animation to match QField's crosshair behavior
        Behavior on x {
            NumberAnimation {
                duration: 10
                easing.type: Easing.OutCubic
            }
        }
        Behavior on y {
            NumberAnimation {
                duration: 10
                easing.type: Easing.OutCubic
            }
        }
    }

    QfToolButton {
        id: makeItPinkButton
        iconSource: 'icon.svg'
        iconColor: Theme.mainColor
        bgcolor: Theme.darkGray
        round: true

        onClicked: {
            layerTextSizeSettings.open();
            return;
        }
    }

    Connections {
        target: mainWindow
        onToggleDigitizeMode: {
            customCrosshair.visible = multiplierSettings.showCrosshairOverlay && projectInfo.stateMode === "digitize";
        }
    }

    function configure() {
        layerTextSizeSettings.open();
    }
}
