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
            hint.visible = false
        }
    }

    Connections {
        target: game
        onPuzzleReset: {
            assigned.text = ""
            assigned.visible = false
            hint.visible = true
        }
    }
}
