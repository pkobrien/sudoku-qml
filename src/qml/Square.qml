import QtQuick 2.4
import QtQml.StateMachine 1.0 as DSM
import "." as App

App.SquareForm {
    id: square

    property int boxIndex
    property int columnIndex
    property int rowIndex

    property string digit: ""

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
        App.Active.reset();
        App.Active.square = square;
        focus = true;
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
                square.hints[index].state = "On";
            }
        }
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
                onTriggered: {
                    if (cell.was_assigned) {
                        assigned = true;
                        label.text = cell.solved_value;
                    }
                }
            }
        }

        DSM.State {
            id: setupState

            initialState: inactiveState

            DSM.SignalTransition {
                signal: py.game.puzzleReset
                targetState: blankState
                onTriggered: {
                    assigned = false;
                    label.text = "";
                }
            }
            DSM.SignalTransition {
                signal: py.game.puzzleSolved
                targetState: puzzleSolvedState
            }

            DSM.State {
                id: activeState

                onEntered: App.Active.digit = label.text;

                DSM.SignalTransition {
                    signal: selectedChanged
                    guard: (!selected)
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
                    signal: selectedChanged
                    guard: (selected)
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
