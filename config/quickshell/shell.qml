import QtQuick
import Quickshell
import qs.Bar

ShellRoot {
    Loader {
        sourceComponent: Audio {}
    }
    Loader {
        sourceComponent: Bar {}
    }
}
