import QtQuick 2.4

SquareForm {
    id: square

    property var cell
    property alias cellConnections: cellConnections

    entry.onEditingFinished: {
        console.log("entry.onEditingFinished:", entry.text)
    }

    entry.onTextChanged: {
        console.log("entry.onTextChanged:", entry.text)
        cell.update(entry.text)
        if (entry.text === "") {
            entry.visible = false
            hintGrid.visible = true
            mouseArea.visible = true
            mouseArea.focus = true
        }
    }

    mouseArea.onClicked: {
        entry.visible = true
        entry.selectAll()
        entry.focus = true
        hintGrid.visible = false
        mouseArea.visible = false
    }

    Connections {
        id: cellConnections
        target: null // Will be set to cell at a later point in time.
        onValueAssigned: {
            assigned.text = cell.assigned_value
            assigned.visible = true
            entry.visible = false
            hintGrid.visible = false
            mouseArea.visible = false
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
            entry.visible = false
            hintGrid.visible = true
            for (var i = 0; i < 9; i++) {
                hints[i].hintText.color = "#000000"
            }
            mouseArea.visible = true
        }
    }
}
