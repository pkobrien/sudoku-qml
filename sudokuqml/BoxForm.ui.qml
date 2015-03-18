import QtQuick 2.4
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.2

Rectangle {
    id: box
    width: 120
    height: 120
    border.width: 3
    border.color: "black"
    color: "transparent"

    property bool isCurrent: false
    property alias squares: grid.children

    Grid {
        id: grid
        anchors.centerIn: parent
        columns: 3
        rows: 3
        spacing: 0

        Repeater {
            model: 9

            Square {
                width: (box.width - (box.border.width * 2)) / grid.columns
                height: (box.height - (box.border.width * 2)) / grid.rows
            }
        }
    }

    states: [
        State {
            name: "HIGHLIGHTED"
            when: (isCurrent && py.game.show_hints)
            PropertyChanges {target: box; border.color: "yellow"}
        }
    ]
}
