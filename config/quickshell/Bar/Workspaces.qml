import QtQuick
import QtQuick.Layouts
import Quickshell

RowLayout {
    readonly property string socketPath: Quickshell.env("NIRI_SOCKET")

    Component.onCompleted: {
        // button.clicked.connect(updateText);
    }
}
