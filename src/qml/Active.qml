pragma Singleton

import QtQuick 2.4
import Candy 1.0 as Candy

Candy.Object {
    id: activeSingleton

    property var appWindow
    property var puzzle

    property bool showHints: true

    property var square

    Connections {
        target: py.game
        onPuzzleReset: square = undefined;
        onPuzzleSolved: square = undefined;
    }
}
