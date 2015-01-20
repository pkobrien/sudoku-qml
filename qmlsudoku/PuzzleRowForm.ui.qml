import QtQuick 2.4
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.2

Rectangle {
    id: row
    width: 100
    height: 20
    border.width: 3
    border.color: "transparent"
    color: "transparent"

    property bool isCurrent: false

    states: [
        State {
            name: "HIGHLIGHTED"
            when: (isCurrent && game.show_hints)
            PropertyChanges {target: row; border.color: "yellow"}
        }
    ]
}
