import QtQuick 2.4

PuzzleForm {
    id: puzzle

    property var squares: []

    Component.onCompleted: {
        for (var i = 0; i < 3; i++) {
            for (var j = 0; j < 3; j++) {
                for (var x = 0; x < 3; x++) {
                    for (var y = 0; y < 3; y++) {
                        var box = (i * 3) + x;
                        var square = (j * 3) + y;
                        squares.push(boxes[box].squares[square]);
                    }
                }
            }
        }
        for (var i = 0; i < squares.length; i++) {
            var cell = game.cells[i];
            var square = squares[i];
            square.cell = cell;
            square.cellConnections.target = cell;
        }
    }
}
