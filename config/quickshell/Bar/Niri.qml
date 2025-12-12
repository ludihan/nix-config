pragma Singleton

import Quickshell

Singleton {
    readonly property string socketPath: Quickshell.env("NIRI_SOCKET")
}
