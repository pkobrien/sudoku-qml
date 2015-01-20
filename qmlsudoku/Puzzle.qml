import QtQuick 2.4

PuzzleForm {
    id: puzzle

    property var currentBox
    property var currentColumn
    property var currentRow
    property var currentSquare
    property var squares: []

    signal squareActivated(Square square)
    signal squareDeactivated(Square square)

    onSquareActivated: {
        currentSquare = square;
        var box = boxes[square.cell.box];
        currentBox = box;
        box.isCurrent = true;
        var column = columns[square.cell.column];
        currentColumn = column;
        column.isCurrent = true;
        var row = rows[square.cell.row];
        currentRow = row;
        row.isCurrent = true;
    }

    onSquareDeactivated: {
        if (square == currentSquare) {
            currentBox.isCurrent = false;
            currentBox = undefined;
            currentRow.isCurrent = false;
            currentColumn = undefined;
            currentColumn.isCurrent = false;
            currentRow = undefined;
            currentSquare = undefined;
        }
        else {
            var box = boxes[square.cell.box];
            if (box != currentBox)
                box.isCurrent = false;
            var column = columns[square.cell.column];
            if (column != currentColumn)
                column.isCurrent = false;
            var row = rows[square.cell.row];
            if (row != currentRow)
                row.isCurrent = false;
        }
    }

    Component.onCompleted: {
        for (var i = 0; i < 3; i++) {
            for (var j = 0; j < 3; j++) {
                for (var x = 0; x < 3; x++) {
                    for (var y = 0; y < 3; y++) {
                        var boxIndex = (i * 3) + x;
                        var squareIndex = (j * 3) + y;
                        squares.push(boxes[boxIndex].squares[squareIndex]);
                    }
                }
            }
        }
        for (var i = 0; i < squares.length; i++) {
            var cell = game.cells[i];
            var square = squares[i];
            square.cell = cell;
            square.cellConnections.target = cell;
            square.index = i;
            square.activated.connect(squareActivated);
            square.deactivated.connect(squareDeactivated);
        }
    }

    Connections {
        target: game
        onPuzzleReset: {
            if (currentBox != undefined)
                currentBox.isCurrent = false;
            currentBox = undefined;
            if (currentColumn != undefined)
                currentColumn.isCurrent = false;
            currentColumn = undefined;
            if (currentRow != undefined)
                currentRow.isCurrent = false;
            currentRow = undefined;
        }
    }
}
