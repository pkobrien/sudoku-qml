import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.3

Rectangle {
    id: puzzle

    width: grid.width + (border.width * 2)
    height: grid.height + (border.width * 2)

    border.color: "black"
    border.width: 4

    gradient: Gradient {
        GradientStop { position: 0.0; color: "white" }
        GradientStop { position: 1.0; color: "#dddddd" }
    }

    property alias boxes: boxHighlights.children
    property alias columns: columnHighlights.children
    property alias grid: grid
    property alias rows: rowHighlights.children
    property alias squares: grid.children

    Grid {
        id: boxHighlights

        anchors.centerIn: parent
        columns: 3
        rows: 3

        Repeater {
            model: 9

            Highlight {
                width: grid.width / 3
                height: grid.height / 3
                border.color: "black"
            }
        }
    }

    Row {
        id: columnHighlights

        anchors.centerIn: parent

        Repeater {
            model: 9

            Highlight {
                width: grid.width / 9
                height: grid.height
            }
        }
    }

    Column {
        id: rowHighlights

        anchors.centerIn: parent

        Repeater {
            model: 9

            Highlight {
                width: grid.width
                height: grid.height / 9
            }
        }
    }

    Grid {
        id: grid

        anchors.centerIn: parent
        columns: 9
        rows: 9

        Repeater {
            model: 81

            Square { }
        }
    }
}
