import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.3

Rectangle {
    id: row
    width: 100
    height: 20
    border.color: "transparent"
    border.width: 3
    color: "transparent"

    property bool isCurrent: false

    states: [
        State {
            name: "HIGHLIGHTED"
            when: isCurrent && py.game.show_hints
            PropertyChanges {target: row; border.color: "yellow"}
        }
    ]
}
