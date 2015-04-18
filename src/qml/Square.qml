import QtQuick 2.4
import QtQml.StateMachine 1.0 as DSM
import "." as App

App.SquareForm {
    id: square

    property int boxIndex
    property int columnIndex
    property int rowIndex

    property string digit: ""

    signal activated()
    signal deactivated()
    signal puzzleReset()
    signal puzzleSetup()
    signal puzzleSolved()

    signal deletePressed()
    signal digitPressed()

    width: dp(48)
    height: dp(48)

    border.width: dp(1)
    label.font.pixelSize: dp(30)

    onCellChanged: {
        if (!cell) {
            return;
        }
        square.boxIndex = cell.box;
        square.columnIndex = cell.column;
        square.rowIndex = cell.row;
    }

    mouseArea.onClicked: {
        App.Active.square = square;
        focus = true;
    }

    Connections {
        target: App.Active
        onSquareChanged: {
            if (square === App.Active.square) {
                activated();
            } else {
                deactivated();
            }
        }
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
            assigned = false;
            label.text = "";
            puzzleReset();
        }
        onPuzzleSetup: {
            if (cell.was_assigned) {
                assigned = true;
                label.text = cell.solved_value;
            }
            puzzleSetup();
        }
        onPuzzleSolved: {
            puzzleSolved();
        }
    }

    DSM.StateMachine {
        id: sm

        initialState: blankState

        running: true

        DSM.State {
            id: blankState

            DSM.SignalTransition {
                signal: puzzleSetup
                targetState: setupState
            }
        }

        DSM.State {
            id: setupState

            initialState: inactiveState

            DSM.SignalTransition {
                signal: puzzleReset
                targetState: blankState
            }
            DSM.SignalTransition {
                signal: puzzleSolved
                targetState: puzzleSolvedState
            }

            DSM.State {
                id: activeState

                onEntered: App.Active.digit = label.text;

                onExited: App.Active.digit = "";

                DSM.SignalTransition {
                    signal: deactivated
                    targetState: inactiveState
                }
                DSM.SignalTransition {
                    signal: deletePressed
                    guard: (!assigned)
                    onTriggered: {
                        cell.update("");
                        label.text = "";
                        App.Active.digit = "";
                        digit = "";
                    }
                }
                DSM.SignalTransition {
                    signal: digitPressed
                    guard: (!assigned)
                    onTriggered: {
                        cell.update(digit);
                        label.text = digit;
                        App.Active.digit = label.text;
                    }
                }
            }

            DSM.State {
                id: inactiveState

                DSM.SignalTransition {
                    signal: activated
                    targetState: activeState
                }
            }

            DSM.State {
                id: puzzleSolvedState

                onEntered: {
                    color = "Green";
                    mouseArea.visible = false;
                }
            }
        }
    }

    focus: true
    Keys.onDeletePressed: deletePressed();
    Keys.onPressed: {
        if (event.key === Qt.Key_Escape) {
            App.Active.reset();
        } else if ("123456789".indexOf(event.text) !== -1) {
            digit = event.text;
            digitPressed();
        }
    }
}
