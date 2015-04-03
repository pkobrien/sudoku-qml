import QtQuick 2.4
import QtQuick.Controls 1.3

Rectangle {
    id: hint

    width: 13
    height: 13
    color: "transparent"

    property alias hintText: hintText

    Text {
        id: hintText

        anchors.fill: parent
        color: "#cccccc"
        font.pixelSize: 10
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: "0"
    }

    states: [
        State {
            name: "SHOWN"
            PropertyChanges { target: hintText; color: "#000000" }
        }
    ]
}
