import QtQuick 2.4
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.2

Rectangle {
    id: column
    width: 20
    height: 100
    border.width: 3
    border.color: "transparent"
    color: "transparent"

    property bool isCurrent: false

    states: [
        State {
            name: "HIGHLIGHTED"
            when: (isCurrent && game.show_hints)
            PropertyChanges {target: column; border.color: "yellow"}
        }
    ]
}
