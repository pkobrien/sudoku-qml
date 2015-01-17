import QtQuick 2.4

SquareForm {
    id: square

    property var cell
    property alias cellConnections: cellConnections

    entry.onFocusChanged: {
        if (entry.activeFocus) {
            entry.selectAll()
        }
        else {
            if (entry.text === "") {
                state = "ENTRY_HIDDEN"
            }
        }
    }

    entry.onTextChanged: {
        if (state != "INIT") {
            cell.update(entry.text)
            entry.selectAll()
        }
    }

    mouseArea.onClicked: {
        if (state == "ENTRY_HIDDEN") {
            state = "ENTRY_SHOWN"
        }
        entry.selectAll()
        entry.focus = true
    }

    Connections {
        id: cellConnections
        target: null // Will be set to cell at a later point in time.
        onHintsChanged: {
            for (var i = 0; i < 9; i++) {
                hints[i].state = "HIDDEN"
            }
            for (var i = 0; i < cell.hints.length; i++) {
                var index = cell.hints[i]
                hints[index].state = "SHOWN"
            }
        }
        onValueAssigned: {
            state = "ASSIGNED"
            assigned.text = cell.assigned_value
        }
    }

    Connections {
        target: game
        onHintModeChanged: {
            if (state != "ASSIGNED") {
                hintGrid.visible = game.show_hints
            }
        }
        onPuzzleReset: {
            state = "INIT"
            assigned.text = ""
            entry.text = ""
            state = "ENTRY_HIDDEN"
            hintGrid.visible = game.show_hints
            for (var i = 0; i < 9; i++) {
                hints[i].state = "INIT"
            }
        }
    }
}
