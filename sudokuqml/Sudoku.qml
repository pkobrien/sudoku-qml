import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QtQuick.Window 2.2
import Android 1.0 as A

ApplicationWindow {
    title: qsTr("Sudoku")
    width: 500
    height: 500 + toolBar.height
    visible: true

    property var dp: A.Units.dp

    Action {
        id: newEasyPuzzleAction
        text: qsTr("New Easy Puzzle")
        onTriggered: py.game.setup_random_puzzle(50);
    }

    Action {
        id: newMediumPuzzleAction
        text: qsTr("New Medium Puzzle")
        onTriggered: py.game.setup_random_puzzle(40);
    }

    Action {
        id: newHardPuzzleAction
        text: qsTr("New Hard Puzzle")
        onTriggered: py.game.setup_random_puzzle(30);
    }

    menuBar: MenuBar {
        Menu {
            title: qsTr("&File")
            MenuItem { action: newEasyPuzzleAction }
            MenuItem { action: newMediumPuzzleAction }
            MenuItem { action: newHardPuzzleAction }
            MenuItem {
                text: qsTr("E&xit")
                shortcut: StandardKey.Quit
                onTriggered: Qt.quit();
            }
        }
    }

    toolBar: ToolBar {
        height: 40
        RowLayout {
            anchors.fill: parent
            ToolButton { action: newEasyPuzzleAction }
            ToolButton { action: newMediumPuzzleAction }
            ToolButton { action: newHardPuzzleAction }
            Item { Layout.fillWidth: true }
            CheckBox {
                id: showHints
                text: "Show Hints"
                onClicked: py.game.show_hints = showHints.checked;
            }
        }
        Component.onCompleted: showHints.checked = py.game.show_hints;
    }

    Puzzle {
        id: puzzle
        anchors.fill: parent
    }
}
