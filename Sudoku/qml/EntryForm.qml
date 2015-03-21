import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3

TextField {
    id: entry

    width: 40
    height: 40

    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter

    font.pixelSize: 30
    inputMask: "D"

    style: TextFieldStyle {
        background: Rectangle {
            anchors.fill: parent
            color: "#00000000"
        }
    }

    states: [
        State {
            name: "WRONG-ANSWER"
            PropertyChanges { target: entry; font.underline: true }
        }
    ]
}
