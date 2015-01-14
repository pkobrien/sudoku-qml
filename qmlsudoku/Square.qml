import QtQuick 2.4

SquareForm {
    id: square

    Connections {
        target: game
        onPuzzleReset: {
            square.assigned.text = ""
            square.assigned.visible = false
            square.hint.visible = false
        }
    }
}
