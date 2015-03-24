import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3
import "." as App

TextField {
    id: entry

    width: 40
    height: 40

    property var cell

    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter

    font.pixelSize: 30
    inputMask: "D"

    style: TextFieldStyle {
        background: Rectangle {
            anchors.fill: parent
            color: "transparent"
        }
    }

    states: [
        State {
            name: "WRONG-ANSWER"
            when: cell && App.Active.showHints && entry.text && entry.text !== cell.solved_value
            PropertyChanges { target: entry; font.underline: true }
        }
    ]
}
