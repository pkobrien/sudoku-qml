import QtQuick 2.4
import QtQuick.Controls 1.3
import "." as App

Rectangle {
    id: highlight

    property bool on: false

    width: 100
    height: 100

    border.color: "Transparent"
    border.width: 3
    color: "Transparent"

    states: [
        State {
            name: "On"
            when: (on)
            PropertyChanges { target: highlight; border.color: "Yellow" }
        }
    ]
}
