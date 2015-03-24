import QtQuick 2.4
import "." as App

App.SquareForm {
    id: square

    width: dp(48)
    height: dp(48)

    border.width: dp(1)
    solution.font.pixelSize: dp(30)

    property var cell: null

    property int boxIndex
    property int columnIndex
    property int rowIndex

    onCellChanged: {
        if (!cell) {
            return;
        }
        entry.cell = cell;
        square.boxIndex = cell.box;
        square.columnIndex = cell.column;
        square.rowIndex = cell.row;
    }

    entry.onFocusChanged: {
        if (!entry.activeFocus && entry.text === "") {
            square.state = "ENTRY-HIDDEN";
        }
    }

    entry.onTextChanged: {
        if (square.state !== "INIT") {
            cell.update(entry.text);
            entry.selectAll();
        }
    }

    mouseArea.onClicked: {
        App.Active.square = square;
        if (state === "ENTRY-HIDDEN") {
            state = "ENTRY-SHOWN";
        }
        entry.focus = true;
    }

    Connections {
        target: square.cell
        onHintsChanged: {
            // Hide all the hints and then turn on the valid ones.
            for (var i = 0; i < 9; i++) {
                square.hints[i].state = "";
            }
            // square.cell.hints is a Python list of valid digits.
            for (var i = 0; i < square.cell.hints.length; i++) {
                var index = square.cell.hints[i];
                square.hints[index].state = "SHOWN";
            }
        }
    }

    Connections {
        target: py.game
        onPuzzleReset: {
            state = "INIT";
            solution.text = "";
            entry.text = "";
            entry.focus = false;
            state = "ENTRY-HIDDEN";
        }
        onPuzzleSetup: {
            solution.text = cell.solved_value;
            if (cell.was_assigned) {
                state = "ASSIGNED";
            }
        }
        onPuzzleSolved: {
            state = "PUZZLE-SOLVED";
        }
    }

    //    ScaleAnimator on scale {
    //        from: 0.1;
    //        to: 1;
    //        duration: 4000;
    //    }

    focus: true
    Keys.onPressed: {
        if (event.key === Qt.Key_Escape) {
            App.Active.square = undefined;
            entry.focus = false;
        }
    }

    transitions: [
        Transition {
            from: "INIT"; to: "*"
            NumberAnimation {
                id: squareAnimationX
                target: square
                property: "y"
                duration: 500
                easing.type: Easing.InOutBounce
            }
        },
        Transition {
            from: "*"; to: "PUZZLE-SOLVED"
            ColorAnimation { target: solution; properties: "color"; duration: 2000 }
        }
    ]
}
