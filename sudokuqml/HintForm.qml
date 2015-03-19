import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.3

Rectangle {
    id: hint

    width: 12
    height: 12
    color: "#00000000"

    property alias hintText: hintText

    Text {
        id: hintText

        anchors.fill: parent
        color: "#cccccc"
        fontSizeMode: Text.Fit
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: "0"
    }

    states: [
        State {
            name: "HIDDEN"
            PropertyChanges {target: hintText; color: "#cccccc"}
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
