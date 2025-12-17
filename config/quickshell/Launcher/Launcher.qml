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
        searchBox.clear()
    }
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
    implicitWidth: 800
    implicitHeight: 800
    // match the system theme background color
    color: "#1A1A1A"
    ScrollView {
        anchors.fill: parent
        contentWidth: availableWidth

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 10
            TextField {
                id: searchBox
                font.family: Config.fontFamily
                font.pixelSize: 18
                Layout.fillWidth: true
                padding: 10
                focus: true
                enabled: true
                onEditingFinished: {
                    root.visible = false
                }
                Component.onCompleted: forceActiveFocus()
                Keys.onEscapePressed: root.visible = false
            }


            Rectangle {
                Layout.fillWidth: true
                color: palette.active.text
                implicitHeight: 1
            }

            Repeater {
                model: DesktopEntries.applications

                Entry {
                    required property DesktopEntry modelData

                    entry: modelData
                }
            }
        }
    }
}
