import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QtQuick.Window 2.2
import Android 1.0 as A

ApplicationWindow {
    id: appWindow

    property var dp: A.Units.dp

    title: qsTr("Sudoku")
    visible: true

    x: Screen.width / 2 - width / 2
    y: Screen.height / 2 - height / 2

    Component.onCompleted: {
        A.Units.pixelDensity = Qt.binding(function() { return Screen.pixelDensity; });
        A.Units.scaleFactor = 3.0;
        appWindow.width = Qt.binding(function() { return puzzle.width + dp(100); });
        appWindow.height = Qt.binding(function() { return puzzle.height + dp(160); });
    }

    Action {
        id: develop
        shortcut: StandardKey.Back
        text: qsTr("Developer Info")
        onTriggered: {
            console.log("A.Units.pixelDensity", A.Units.pixelDensity);
            console.log("width/height", width, height);
            console.log("dp(500)", dp(500));
            console.log("dp(48)", dp(48));
            console.log("dp(5)", dp(5));
            console.log("dp(4)", dp(4));
            console.log("dp(3)", dp(3));
            console.log("dp(2)", dp(2));
            console.log("dp(1)", dp(1));
            console.log("dp(0)", dp(0));
        }
    }

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
            MenuItem { action: develop }
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
        height: dp(40)
        RowLayout {
            anchors.fill: parent
            ToolButton { action: newEasyPuzzleAction }
            ToolButton { action: newMediumPuzzleAction }
            ToolButton { action: newHardPuzzleAction }
            Item { Layout.fillWidth: true }
            CheckBox {
                id: showHints
                checked: py.game.show_hints
                text: "Show Hints"
                onClicked: py.game.show_hints = showHints.checked;
            }
        }
    }

    Puzzle {
        id: puzzle
        anchors.centerIn: parent
    }
}
