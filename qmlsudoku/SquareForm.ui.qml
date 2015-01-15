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
    property alias entry: entry
    property alias hintGrid: hintGrid
    property alias hints: hintGrid.hints

    Hint {
        id: hintGrid
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
        visible: false
    }

    TextField {
        id: entry
        width: parent.width - 4
        height: parent.height - 4
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        placeholderText: qsTr("?")
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 22
        visible: true
    }
}
