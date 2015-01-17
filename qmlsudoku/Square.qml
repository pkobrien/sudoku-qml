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
                entry.visible = false
                hintGrid.visible = true
                mouseArea.visible = true
            }
        }
    }

    entry.onTextChanged: {
        cell.update(entry.text)
        entry.selectAll()
    }

    mouseArea.onClicked: {
        entry.visible = true
        entry.focus = true
        entry.selectAll()
        hintGrid.visible = false
        mouseArea.visible = false
    }

    Connections {
        id: cellConnections
        target: null // Will be set to cell at a later point in time.
        onHintsChanged: {
            for (var i = 0; i < 9; i++) {
                hints[i].hintText.color = "#dddddd"
            }
            for (var i = 0; i < cell.hints.length; i++) {
                var index = cell.hints[i]
                hints[index].hintText.color = "#000000"
            }
        }
        onValueAssigned: {
            assigned.text = cell.assigned_value
            assigned.visible = true
            entry.visible = false
            hintGrid.visible = false
            mouseArea.visible = false
        }
    }

    Connections {
        target: game
        onPuzzleReset: {
            assigned.text = ""
            assigned.visible = false
            entry.text = ""
            entry.visible = false
            hintGrid.visible = true
            for (var i = 0; i < 9; i++) {
                hints[i].hintText.color = "#000000"
            }
            mouseArea.visible = true
        }
    }
}
