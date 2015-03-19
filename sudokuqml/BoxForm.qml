import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.3

Rectangle {
    id: box

    width: childrenRect.width
    height: childrenRect.height

    property bool isCurrent: false
    property alias squares: grid.children

    border.color: "blue"
    border.width: 3
    color: "transparent"

    Grid {
        id: grid

        columns: 3
        rows: 3

        Repeater {
            model: 9

            Square { }
        }
    }

    states: [
        State {
            name: "HIGHLIGHTED"
            when: isCurrent && py.game.show_hints
            PropertyChanges {target: box; border.color: "yellow"}
        }
    ]
}
