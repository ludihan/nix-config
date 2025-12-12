//@ pragma UseQApplication
import QtQuick
import Quickshell
import qs.Bar
import qs.AudioOSD

ShellRoot {
    Loader {
        sourceComponent: AudioOSD {}
    }
    Loader {
        sourceComponent: Bar {}
    }
}
