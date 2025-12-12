pragma ComponentBehavior: Bound
import QtQuick
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import qs

Repeater {
    model: SystemTray.items

    delegate: Rectangle {
        id: trayItem
        color: "transparent"
        required property SystemTrayItem modelData

        Item {
            IconImage {
                id: icon
                anchors.centerIn: parent
                width: Config.iconSize
                height: Config.iconSize
                source: trayItem.modelData.icon
                visible: true
                MouseArea {
                    id: area
                    anchors.fill: parent
                    acceptedButtons: Qt.AllButtons
                    onClicked: mouse => {
                        switch (mouse.button) {
                        case Qt.LeftButton:
                            trayItem.modelData.activate();
                            break;
                        case Qt.MiddleButton:
                            trayItem.modelData.secondaryActivate();
                            break;
                        case Qt.RightButton:
                            trayItem.modelData.display(root, area.mouseX, area.mouseY);
                            break;
                        }
                    }
                }
            }
        }
    }
}
