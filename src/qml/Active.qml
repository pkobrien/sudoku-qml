pragma Singleton

import QtQuick 2.4
import Candy 1.0 as Candy

Candy.Object {
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

    Connections {
        target: py.game

        onPuzzleReset: reset();

        onPuzzleSolved: reset();
    }
}
