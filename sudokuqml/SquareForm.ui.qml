import QtQuick 2.4
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.2
import QtGraphicalEffects 1.0

Rectangle {
    id: square
    width: 40
    height: 40
    border.width: 1
    border.color: "black"
    color: "transparent"
    state: "INIT"

    property alias entry: entry
    property alias hintGrid: hintGrid
    property alias hints: hintGrid.hints
    property alias mouseArea: mouseArea
    property alias solution: solution

    HintGrid {
        id: hintGrid
        anchors.fill: parent
        visible: false
    }

    Label {
        id: solution
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pointSize: 24
        font.bold: true
        visible: false
    }

    DropShadow {
        id: shadow
        anchors.fill: solution
        color: "#80000000"
        horizontalOffset: 3
        verticalOffset: 3
        radius: 8.0
        samples: 16
        source: solution
        visible: solution.visible
    }

    Entry {
        id: entry
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
        visible: false
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        visible: false
    }

    states: [
        State {
            name: "ASSIGNED"
            PropertyChanges {target: entry; visible: false}
            PropertyChanges {target: hintGrid; visible: false}
            PropertyChanges {target: mouseArea; visible: false}
            PropertyChanges {target: solution; visible: true}
        },
        State {
            name: "ENTRY-HIDDEN"
            PropertyChanges {target: entry; visible: false}
            PropertyChanges {target: hintGrid; visible: game.show_hints}
            PropertyChanges {target: mouseArea; visible: true}
            PropertyChanges {target: solution; visible: false}
        },
        State {
            name: "ENTRY-SHOWN"
            PropertyChanges {target: entry; visible: true}
            PropertyChanges {target: hintGrid; visible: false}
            PropertyChanges {target: mouseArea; visible: true}
            PropertyChanges {target: solution; visible: false}
        },
        State {
            name: "INIT"
            PropertyChanges {target: entry; visible: false}
            PropertyChanges {target: hintGrid; visible: game.show_hints}
            PropertyChanges {target: mouseArea; visible: false}
            PropertyChanges {target: solution; visible: false}
        },
        State {
            name: "PUZZLE-SOLVED"
            PropertyChanges {target: entry; visible: false}
            PropertyChanges {target: hintGrid; visible: false}
            PropertyChanges {target: mouseArea; visible: false}
            PropertyChanges {target: solution; visible: true; color: "darkred"}
        }
    ]
}
