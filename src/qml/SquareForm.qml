import QtQuick 2.4
import QtQuick.Controls 1.3
import QtGraphicalEffects 1.0
import "." as App

Rectangle {
    id: square

    property bool assigned: false
    property bool selected: (App.Active.square === square)

    property var cell: null

    width: 48
    height: 48

    border.color: "Black"
    border.width: 1
    color: "Transparent"

    property alias hints: hintGrid.hints
    property alias label: label
    property alias mouseArea: mouseArea

    App.HintGrid {
        id: hintGrid
        anchors.centerIn: parent
        visible: (App.Active.showHints && label.text === "")
    }

    Label {
        id: label
        anchors.fill: parent
        font.bold: (square.assigned)
        font.pixelSize: 30
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
    }

    states: [
        State {
            name: "MatchingDigit"
            when: (!selected && App.Active.showHints && label.text !== "" &&
                   label.text === App.Active.digit)
            PropertyChanges { target: square; color: "Yellow" }
        },
        State {
            name: "Selected"
            when: (selected)
            PropertyChanges { target: square; color: "#cccccc" }
        }
    ]
}
