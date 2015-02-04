import QtQuick 2.4

SquareForm {
    id: square

    property var cell
    property alias cellConnections: cellConnections
    property int index

    signal activated(var square)
    signal deactivated(var square)

    entry.onFocusChanged: {
        if (entry.activeFocus) {
            entry.selectAll();
            activated(square);
        }
        else {
            if (entry.text === "")
                state = "ENTRY-HIDDEN";
            deactivated(square);
        }
    }

    entry.onTextChanged: {
        if (state !== "INIT") {
            cell.update(entry.text);
            entry.selectAll();
        }
        if (game.show_hints) {
            if ((entry.text !== "") && (entry.text !== cell.solved_value))
                entry.state = "WRONG-ANSWER";
            else
                entry.state = "";
        }
    }

    mouseArea.onClicked: {
        if (state === "ENTRY-HIDDEN")
            state = "ENTRY-SHOWN";
        entry.selectAll();
        entry.focus = true;
    }

    Connections {
        id: cellConnections
        target: null // Will be set to cell at a later point in time.
        onHintsChanged: {
            for (var i = 0; i < 9; i++) {
                hints[i].state = "HIDDEN";
            }
            for (var i = 0; i < cell.hints.length; i++) {
                var index = cell.hints[i];
                hints[index].state = "SHOWN";
            }
        }
    }

    Connections {
        target: game
        onHintModeChanged: {
            if (game.show_hints) {
                if ((entry.text !== "") && (entry.text !== cell.solved_value))
                    entry.state = "WRONG-ANSWER";
                else
                    entry.state = "";
            }
            else
                entry.state = "";
        }
        onPuzzleReset: {
            state = "INIT";
            solution.text = "";
            entry.text = "";
            entry.focus = false;
            state = "ENTRY-HIDDEN";
            for (var i = 0; i < 9; i++) {
                hints[i].state = "INIT";
            }
        }
        onPuzzleSetup: {
            solution.text = cell.solved_value;
            if (cell.was_assigned)
                state = "ASSIGNED";
        }
        onPuzzleSolved: {
            state = "PUZZLE-SOLVED";
        }
    }

    transitions: [
        Transition {
            from: "INIT"; to: "*"
            NumberAnimation {
                target: square
                property: "y"
                duration: (Math.random() * 500) + 500
                easing.type: Easing.InOutBounce
            }
        },
        Transition {
            from: "*"; to: "PUZZLE-SOLVED"
            ColorAnimation { target: solution; properties: "color"; duration: 2000 }
        }
    ]
}
