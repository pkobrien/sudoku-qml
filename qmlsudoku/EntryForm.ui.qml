import QtQuick 2.4
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.3

TextField {
    id: entry
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    inputMask: "D"
    font.pointSize: 22
    style: TextFieldStyle {
        background: Rectangle {
            anchors.fill: parent
            color: "#00000000"
        }
    }
}
