import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QtQuick.Window 2.2
import Candy 1.0 as Candy
import "." as App

ApplicationWindow {
    id: appWindow

    property var dp: Candy.Units.dp

    title: qsTr("Sudoku")
    visible: true

    width: 800
    height: 600

    x: Math.max(0, Math.round((Screen.width - width) / 2))
    y: Math.max(0, Math.round((Screen.height - height) / 2))

    Component.onCompleted: {
        Candy.Units.pixelDensity = Qt.binding(function() { return Screen.pixelDensity; });
        Candy.Units.scaleFactor = 3.0;
        appWindow.width = Qt.binding(function() { return puzzle.width + dp(100); });
        appWindow.height = Qt.binding(function() { return puzzle.height + dp(160); });
        App.Active.appWindow = appWindow;
        App.Active.puzzle = puzzle;
    }

    menuBar: App.MenuBar { }

    toolBar: App.ToolBar { }

    Puzzle {
        id: puzzle
        anchors.centerIn: parent
        focus: true
        Keys.onPressed: App.Actions.keyPressed(event, appWindow);
    }
}
