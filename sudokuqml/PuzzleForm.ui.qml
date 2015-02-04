import QtQuick 2.4
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.2

Rectangle {
    id: puzzle
    width: 380
    height: 380
    border.color: "black"
    border.width: 5
    gradient: Gradient {
        GradientStop { position: 0.0; color: "white" }
        GradientStop { position: 1.0; color: "#dddddd" }
    }

    property alias boxes: grid.children
    property alias columns: rowOfColumns.children
    property alias grid: grid
    property alias rows: columnOfRows.children

    Grid {
        id: grid
        anchors.centerIn: parent
        columns: 3
        rows: 3
    }

    Column {
        id: columnOfRows
        anchors.centerIn: parent
        spacing: -8

        Repeater {
            model: 9

            PuzzleRow {
                id: row
                width: puzzle.width - (puzzle.border.width * 2)
                height: (puzzle.height - (puzzle.border.width * 2) + 72) / 9
            }
        }
    }

    Row {
        id: rowOfColumns
        anchors.centerIn: parent
        spacing: -8

        Repeater {
            model: 9

            PuzzleColumn {
                id: column
                width: (puzzle.width - (puzzle.border.width * 2) + 72) / 9
                height: puzzle.height - (puzzle.border.width * 2)
            }
        }
    }
}
