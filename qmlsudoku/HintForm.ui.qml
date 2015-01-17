import QtQuick 2.4
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.2

Rectangle {
    id: hint
    width: 14
    height: 14
    color: "#00000000"

    property alias hintText: hintText

    Text {
        id: hintText
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: "#cccccc"
        text: "0"
    }

    states: [
        State {
            name: "HIDDEN"
            PropertyChanges {target: hintText; color: "#dddddd"}
        },
        State {
            name: "INIT"
            PropertyChanges {target: hintText; color: "#cccccc"}
        },
        State {
            name: "SHOWN"
            PropertyChanges {target: hintText; color: "#000000"}
        }
    ]
}
