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

    Grid {
        id: grid
        anchors.centerIn: parent
        columns: 3
        rows: 3

        Repeater {
            model: 9

            Box {
                id: box
                width: (puzzle.width - 10) / grid.columns
                height: (puzzle.height - 10) / grid.rows
            }
        }
    }
}
