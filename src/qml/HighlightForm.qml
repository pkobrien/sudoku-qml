import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.3
import "." as App

Rectangle {
    id: highlight

    width: 100
    height: 100

    border.color: "Transparent"
    border.width: 3
    color: "Transparent"

    property bool isActive: false

    states: [
        State {
            name: "On"
            when: App.Active.showHints && isActive
//            PropertyChanges { target: highlight; border.color: "#ccffff00" }
            PropertyChanges { target: highlight; border.color: "Yellow" }
        }
    ]
}
