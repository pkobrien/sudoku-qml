import QtQuick 2.4
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.2

Rectangle {
    id: puzzle
    width: 380
    height: 380
    color: "#000000"
    border.color: "#000000"
    border.width: 5

    property alias boxes: grid.children

    Grid {
        id: grid
        anchors.centerIn: parent
        columns: 3
        rows: 3
        spacing: 5

        Repeater {
            model: 9

            Box {
                width: (puzzle.width - 20) / grid.columns
                height: (puzzle.height - 20) / grid.rows
            }
        }
    }
}
