import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.3

Rectangle {
    id: column
    width: 20
    height: 100
    border.color: "transparent"
    border.width: 3
    color: "transparent"

    property bool isCurrent: false

    states: [
        State {
            name: "HIGHLIGHTED"
            when: isCurrent && py.game.show_hints
            PropertyChanges {target: column; border.color: "yellow"}
        }
    ]
}
