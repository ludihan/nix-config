import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Wayland

RowLayout {
    required property DesktopEntry entry
    Label {
        text: entry.name
        font.family: Config.fontFamily
        font.pixelSize: 18
        color: "white"
    }
}
