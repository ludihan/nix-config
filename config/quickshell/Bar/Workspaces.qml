pragma Singleton

import Quickshell

RowLayout {
    readonly property string socketPath: Quickshell.env("NIRI_SOCKET")
}
