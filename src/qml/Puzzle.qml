import QtQuick 2.4
import "." as App

App.PuzzleForm {
    id: puzzle

    border.width: dp(4)

    Component.onCompleted: {
        for (var i = 0; i < 81; i++) {
            squares[i].cell = py.game.cells[i];
        }
    }

    focus: true
    Keys.onPressed: {
        App.Actions.keyPressed(event, puzzle);
    }

    grid.add: Transition {
        NumberAnimation {
            properties: "x"
            from: puzzle.width / 3
            duration: (Math.random() * 5000) + 500
            easing.type: Easing.OutBounce
        }
        NumberAnimation {
            properties: "y"
            from: (puzzle.width / -2) - (Math.random() * 100)
            duration: (Math.random() * 5000) + 500
            easing.type: Easing.OutBounce
        }
    }
}
