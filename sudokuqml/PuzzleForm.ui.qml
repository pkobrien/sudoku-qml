import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.3

Rectangle {
    id: puzzle

    width: childrenRect.width
    height: childrenRect.height

    border.color: "black"
    border.width: 1

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
        columns: 3
        rows: 3

        Repeater {
            model: 9

            Box { }
        }
    }

    Column {
        id: columnOfRows

        Repeater {
            model: 9

            PuzzleRow {
                width: grid.width
                height: grid.height / 9
            }
        }
    }

    Row {
        id: rowOfColumns

        Repeater {
            model: 9

            PuzzleColumn {
                width: grid.width / 9
                height: grid.height
            }
        }
    }
}
