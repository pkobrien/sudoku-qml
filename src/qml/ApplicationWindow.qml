import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import "." as App

ApplicationWindow {
    id: appWindow

    property var dp: App.Units.dp

    title: qsTr("Sudoku")

    x: Math.max(0, Math.round((Screen.width - width) / 2))
    y: Math.max(0, Math.round((Screen.height - height) / 2))

    contentItem.implicitWidth: puzzle.width
    contentItem.implicitHeight: puzzle.height

    contentItem.maximumWidth: puzzle.width
    contentItem.maximumHeight: puzzle.height

    contentItem.minimumWidth: puzzle.width
    contentItem.minimumHeight: puzzle.height

    Component.onCompleted: {
        App.Active.appWindow = appWindow;
        App.Active.puzzle = puzzle;
        App.Units.pixelDensity = Qt.binding(function()
                                            { return Screen.pixelDensity; });
        App.Units.scaleFactor = 3.0;
        visible = true;
    }

    menuBar: App.MenuBar { }

    toolBar: App.ToolBar { }

    App.Puzzle {
        id: puzzle
    }
}
