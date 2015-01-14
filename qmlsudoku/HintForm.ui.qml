import QtQuick 2.4
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.2

Rectangle {
    id: hint
    width: 40
    height: 40
    color: "#00000000"

    property alias hints: grid.children

    Grid {
        id: grid
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        columns: 3
        rows: 3

        Repeater {
            model: 9

            Rectangle {
                width: hint.width / grid.columns
                height: hint.height / grid.rows
                color: "#00000000"

                Text {
                    text: "0"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }
}
