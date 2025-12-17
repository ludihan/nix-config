import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Wayland
import qs

PanelWindow {
    id: root

    function clear() {
        searchBox.clear();
    }

    property var config: QtObject {
        property string fontFamily: "Iosevka"
        property color muted: "#555555"
        property color highlight: "#505050"
        property color text: "#ffffff"
    }

    function closeWindow() {
        searchBox.clear();
        root.visible = false;
    }

    function launchCurrent() {
        if (appList.currentItem) {
            appList.currentItem.launchApp();
        }
    }

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

    implicitWidth: 400
    implicitHeight: 600
    color: "#1A1A1A"

    MouseArea {
        anchors.fill: parent
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 15

        TextField {
            id: searchBox
            Layout.fillWidth: true
            font.family: root.config.fontFamily
            font.pixelSize: 22
            color: root.config.text
            focus: true

            background: Rectangle {
                color: "#1A1A1A"
            }

            Keys.onEscapePressed: root.closeWindow()

            Keys.onReturnPressed: root.launchCurrent()
            Keys.onEnterPressed: root.launchCurrent()

            Keys.onDownPressed: {
                appList.incrementCurrentIndex();
            }
            Keys.onUpPressed: {
                appList.decrementCurrentIndex();
            }
        }

        Rectangle {
            Layout.fillWidth: true
            implicitHeight: 1
            color: root.config.muted
            opacity: 0.5
        }

        ListView {
            id: appList
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            boundsBehavior: Flickable.StopAtBounds

            model: DesktopEntries.applications

            delegate: ItemDelegate {
                id: delegateRoot
                width: ListView.view.width
                height: visible ? 50 : 0
                visible: modelData.name.toLowerCase().includes(searchBox.text.toLowerCase())

                function launchApp() {
                    console.log("Launching: " + modelData.name);
                    modelData.execute();
                    root.closeWindow();
                }

                background: Rectangle {
                    color: delegateRoot.highlighted || delegateRoot.hovered ? root.config.highlight : "transparent"
                    radius: 4
                    opacity: (delegateRoot.highlighted || delegateRoot.hovered) ? 0.3 : 0
                }

                contentItem: RowLayout {
                    spacing: 10

                    Label {
                        text: modelData.name
                        Layout.fillWidth: true
                        font.family: root.config.fontFamily
                        font.pixelSize: 18
                        color: root.config.text
                        elide: Text.ElideRight
                    }
                }

                onClicked: launchApp()

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: appList.currentIndex = index
                    onClicked: delegateRoot.launchApp()
                }
            }

            ScrollBar.vertical: ScrollBar {
                active: true
                width: 5
            }
        }
    }

    onVisibleChanged: {
        if (visible) {
            searchBox.forceActiveFocus();
            searchBox.text = "";
            appList.currentIndex = 0;
        }
    }
}
