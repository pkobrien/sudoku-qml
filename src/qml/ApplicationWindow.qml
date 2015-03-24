import QtQuick 2.4
import QtQuick.Window 2.2
import Candy 1.0 as Candy
import "." as App

Candy.ApplicationWindow {
    id: appWindow

    title: qsTr("Sudoku")
    visible: true

    width: 800
    height: 600

    x: Math.max(0, Math.round((Screen.width - width) / 2))
    y: Math.max(0, Math.round((Screen.height - height) / 2))

    Component.onCompleted: {
        Candy.Units.scaleFactor = 3.0;
        appWindow.width = Qt.binding(function() { return puzzle.width + dp(100); });
        appWindow.height = Qt.binding(function() { return puzzle.height + dp(160); });
        App.Active.appWindow = appWindow;
        App.Active.puzzle = puzzle;
    }

    menuBar: App.MenuBar { }

    toolBar: App.ToolBar { }

    App.Puzzle {
        id: puzzle
        anchors.centerIn: parent
    }
}
