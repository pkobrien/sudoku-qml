import QtQuick 2.4
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.2

Rectangle {
    id: square
    width: 40
    height: 40
    border.width: 1
    border.color: "black"

    property alias assigned: assigned
    property alias hint: hint
    property alias hints: hint.children

    Hint {
        id: hint
        width: parent.width
        height: parent.height
        visible: true
    }

    Label {
        id: assigned
        width: parent.width
        height: parent.height
        text: "0"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 24
        font.bold: true
        visible: true
    }
}
