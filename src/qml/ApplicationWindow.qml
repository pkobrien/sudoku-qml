import QtQuick 2.4
import QtQuick.Window 2.2
import Candy 1.0 as Candy
import "." as App

Candy.ApplicationWindow {
    id: appWindow

    title: qsTr("Sudoku")
    visible: true

    x: Math.max(0, Math.round((Screen.width - width) / 2))
    y: Math.max(0, Math.round((Screen.height - height) / 2))

    contentItem.implicitWidth: puzzle.width
    contentItem.implicitHeight: puzzle.height

    contentItem.maximumWidth: puzzle.width
    contentItem.maximumHeight: puzzle.height

    contentItem.minimumWidth: puzzle.width
    contentItem.minimumHeight: puzzle.height

    Component.onCompleted: {
        Candy.Units.scaleFactor = 3.0;
        App.Active.appWindow = appWindow;
        App.Active.puzzle = puzzle;
    }

    menuBar: App.MenuBar { }

    toolBar: App.ToolBar { }

    App.Puzzle {
        id: puzzle
    }
}
