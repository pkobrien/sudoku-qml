import QtQuick 2.4

PuzzleForm {
    id: puzzle

    property var currentBox
    property var currentColumn
    property var currentRow
    property var currentSquare

    signal squareActivated(Square square)
    signal squareDeactivated(Square square)

    border.width: dp(4)

    onSquareActivated: {
        currentSquare = square;
        currentBox = boxes[square.cell.box];
        currentBox.isCurrent = true;
        currentColumn = columns[square.cell.column];
        currentColumn.isCurrent = true;
        currentRow = rows[square.cell.row];
        currentRow.isCurrent = true;
    }

    onSquareDeactivated: {
        if (square === currentSquare) {
            currentBox.isCurrent = false;
            currentBox = undefined;
            currentColumn.isCurrent = false;
            currentColumn = undefined;
            currentRow.isCurrent = false;
            currentRow = undefined;
            currentSquare = undefined;
        }
        else {
            var box = boxes[square.cell.box];
            if (box !== currentBox)
                box.isCurrent = false;
            var column = columns[square.cell.column];
            if (column !== currentColumn)
                column.isCurrent = false;
            var row = rows[square.cell.row];
            if (row !== currentRow)
                row.isCurrent = false;
        }
    }

//    grid.add: Transition {
//        NumberAnimation {
//            id: boxAnimationX
//            properties: "x"
//            from: parent.width / 3
//            duration: (Math.random() * 5000) + 500
//            easing.type: Easing.OutBounce
//        }
//        NumberAnimation {
//            id: boxAnimationY
//            properties: "y"
//            from: (parent.width / -2) - (Math.random() * 100)
//            duration: (Math.random() * 5000) + 500
//            easing.type: Easing.OutBounce
//        }
//    }

    Component.onCompleted: {
        for (var i = 0; i < 81; i++) {
            var cell = py.game.cells[i];
            var square = squares[i];
            square.cell = cell;
            square.cellConnections.target = cell;
            square.index = i;
            square.activated.connect(squareActivated);
            square.deactivated.connect(squareDeactivated);
        }
    }

    Connections {
        target: py.game
        onPuzzleReset: {
            if (currentBox !== undefined)
                currentBox.isCurrent = false;
            currentBox = undefined;
            if (currentColumn !== undefined)
                currentColumn.isCurrent = false;
            currentColumn = undefined;
            if (currentRow !== undefined)
                currentRow.isCurrent = false;
            currentRow = undefined;
            currentSquare = undefined;
        }
        onPuzzleSolved: {
            squareDeactivated(currentSquare);
        }
    }
}
