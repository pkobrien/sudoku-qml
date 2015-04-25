import QtQuick 2.4
import QtQml.StateMachine 1.0 as DSM
import "." as App

App.SquareForm {
    id: square

    property int boxIndex
    property int columnIndex
    property int rowIndex

    signal deletePressed()
    signal digitPressed()

    width: dp(48)
    height: dp(48)

    border.width: dp(1)
    label.font.pixelSize: dp(30)

    property var cell: null

    property string digit: ""

    label.text: digit

    matchingDigit: (!selected && App.Active.showMatchingDigits && digit &&
                    App.Active.square && digit === App.Active.square.digit)

    puzzleSolved: (puzzleSolvedState.active)

    selected: (App.Active.square === square)

    showHints: (App.Active.showHints && digit === "")

    onCellChanged: {
        if (!cell) {
            return;
        }
        square.boxIndex = cell.box;
        square.columnIndex = cell.column;
        square.rowIndex = cell.row;
    }

    mouseArea.onClicked: {
        square.select();
    }

    Connections {
        target: py.game
        onPuzzleReset: square.unselect();
        onPuzzleSolved: square.unselect();
    }

    Connections {
        target: square.cell
        onHintsChanged: {
            // Hide all the hints and then turn on the valid ones.
            for (var i = 0; i < 9; i++) {
                square.hints[i].on = false;
            }
            // square.cell.hints is a Python list of valid digits.
            for (var i = 0; i < square.cell.hints.length; i++) {
                var index = square.cell.hints[i];
                square.hints[index].on = true;
            }
        }
    }

    function clear() {
        digit = "";
        cell.update(digit);
    }

    function reset() {
        assigned = false;
        digit = "";
    }

    function select() {
        App.Active.square = square;
        focus = true;
    }

    function setup() {
        if (cell.was_assigned) {
            assigned = true;
            digit = cell.solved_value;
        }
    }

    function unselect() {
        App.Active.square = null;
    }

    function update() {
        digit = keyInfo.digit;
        cell.update(digit);
    }

    DSM.StateMachine {
        id: sm

        initialState: blankState

        running: true

        DSM.State {
            id: blankState

            DSM.SignalTransition {
                signal: py.game.puzzleSetup
                targetState: setupState
                onTriggered: setup();
            }
        }

        DSM.State {
            id: setupState

            initialState: inactiveState

            DSM.SignalTransition {
                signal: py.game.puzzleReset
                targetState: blankState
                onTriggered: reset();
            }
            DSM.SignalTransition {
                signal: py.game.puzzleSolved
                targetState: puzzleSolvedState
            }

            DSM.State {
                id: activeState

                DSM.SignalTransition {
                    signal: selectedChanged
                    guard: (!selected)
                    targetState: inactiveState
                }
                DSM.SignalTransition {
                    signal: deletePressed
                    guard: (!assigned)
                    onTriggered: clear();
                }
                DSM.SignalTransition {
                    signal: digitPressed
                    guard: (!assigned)
                    onTriggered: update();
                }
            }

            DSM.State {
                id: inactiveState

                DSM.SignalTransition {
                    signal: selectedChanged
                    guard: (selected)
                    targetState: activeState
                }
            }

            DSM.State {
                id: puzzleSolvedState
            }
        }
    }

    QtObject {
        id: keyInfo

        property string digit: ""
    }

    focus: true
    Keys.onDeletePressed: deletePressed();
    Keys.onPressed: {
        if (event.key === Qt.Key_Escape) {
            unselect();
        } else if ("123456789".indexOf(event.text) !== -1) {
            keyInfo.digit = event.text;
            digitPressed();
        }
    }

    transitions: [
        Transition {
            from: "*"; to: "PuzzleSolved"
            ColorAnimation {
                target: square
                properties: "color"
                duration: 2000
            }
        }
    ]
}
