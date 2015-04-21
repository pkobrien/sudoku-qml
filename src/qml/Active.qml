pragma Singleton

import QtQuick 2.4

QtObject {
    id: activeSingleton

    property var appWindow
    property var puzzle

    property bool showHints: true

    property string digit: ""
    property var square

    function reset() {
        digit = "";
        square = undefined;
    }

    property Connections __connections: Connections {
        target: py.game

        onPuzzleReset: reset();

        onPuzzleSolved: reset();
    }
}
