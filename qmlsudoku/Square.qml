import QtQuick 2.4

SquareForm {
    id: square

    property var cell
    property alias cellConnections: cellConnections

    Connections {
        id: cellConnections
        target: null // Will be set to cell at a later point in time.
        onValueAssigned: {
            assigned.text = cell.assigned_value
            assigned.visible = true
            entry.visible = false
            hintGrid.visible = false
        }
        onHintsChanged: {
            for (var i = 0; i < 9; i++) {
                hints[i].hintText.color = "#dddddd"
            }
            for (var i = 0; i < cell.hints.length; i++) {
                var index = cell.hints[i]
                hints[index].hintText.color = "#000000"
            }
        }
    }

    Connections {
        target: game
        onPuzzleReset: {
            assigned.text = ""
            assigned.visible = false
            entry.text = ""
            entry.visible = true
            hintGrid.visible = false
            for (var i = 0; i < 9; i++) {
                hints[i].hintText.color = "#000000"
            }
        }
    }
}
