import QtQuick 2.4
import QtQuick.Controls 1.3
import "." as App

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

    property alias grid: grid
    property alias squares: grid.children

    Grid {
        id: boxHighlights

        anchors.centerIn: parent
        columns: 3
        rows: 3

        Repeater {
            model: 9

            App.Highlight {
                width: grid.width / 3
                height: grid.height / 3
                border.color: "black"
                isActive: App.Active.square ? App.Active.square.boxIndex === index : false
            }
        }
    }

    Row {
        id: columnHighlights

        anchors.centerIn: parent

        Repeater {
            model: 9

            App.Highlight {
                width: grid.width / 9
                height: grid.height
                isActive: App.Active.square ? App.Active.square.columnIndex === index : false
            }
        }
    }

    Column {
        id: rowHighlights

        anchors.centerIn: parent

        Repeater {
            model: 9

            App.Highlight {
                width: grid.width
                height: grid.height / 9
                isActive: App.Active.square ? App.Active.square.rowIndex === index : false
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

            App.Square {  }
        }
    }
}
