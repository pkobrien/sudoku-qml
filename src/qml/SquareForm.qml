import QtQuick 2.4
import QtQuick.Controls 1.3
import QtGraphicalEffects 1.0
import "." as App

Rectangle {
    id: square

    property bool assigned: false
    property bool matchingDigit: false
    property bool puzzleSolved: false
    property bool selected: false
    property bool showHints: false

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
        visible: (showHints)
    }

    Label {
        id: label
        anchors.fill: parent
        font.bold: (square.assigned)
        font.pixelSize: 30
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: "9"
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
    }

    states: [
        State {
            name: "MatchingDigit"
            when: (matchingDigit)
            PropertyChanges { target: square; color: "Yellow" }
        },
        State {
            name: "PuzzleSolved"
            when: (puzzleSolved)
            PropertyChanges { target: mouseArea; visible: false }
            PropertyChanges { target: square; color: "Green" }
        },
        State {
            name: "Selected"
            when: (selected)
            PropertyChanges { target: square; color: "#cccccc" }
        }
    ]
}
