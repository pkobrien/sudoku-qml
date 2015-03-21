import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.3
import "." as App

Rectangle {
    id: highlight

    width: 100
    height: 100

    border.color: "transparent"
    border.width: 3
    color: "transparent"

    property bool isCurrent: false

    states: [
        State {
            name: "HIGHLIGHTED"
            when: isCurrent && App.Active.showHints
//            PropertyChanges { target: highlight; border.color: "#ccffff00" }
            PropertyChanges { target: highlight; border.color: "yellow" }
        }
    ]
}
