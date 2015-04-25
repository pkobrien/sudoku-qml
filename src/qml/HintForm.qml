import QtQuick 2.4
import QtQuick.Controls 1.3

Rectangle {
    id: hint

    width: 13
    height: 13
    color: (matchingDigit) ? "Yellow" : "Transparent"

    property string digit: "0"

    property bool matchingDigit: false
    property bool on: false

    property alias hintText: hintText

    Text {
        id: hintText

        anchors.fill: parent
        color: "#cccccc"
        font.pixelSize: 10
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: digit
    }

    states: [
        State {
            name: "On"
            when: (on)
            PropertyChanges { target: hintText; color: "#000000" }
        }
    ]
}
