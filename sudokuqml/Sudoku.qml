import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QtQuick.Window 2.2
import Android 1.0 as A
import "." as App

ApplicationWindow {
    id: appWindow

    property var dp: A.Units.dp

    title: qsTr("Sudoku")
    visible: true

    x: (Screen.width - width) / 2
    y: (Screen.height - height) / 2

    Component.onCompleted: {
        A.Units.pixelDensity = Qt.binding(function() { return Screen.pixelDensity; });
        A.Units.scaleFactor = 3.0;
        appWindow.width = Qt.binding(function() { return puzzle.width + dp(100); });
        appWindow.height = Qt.binding(function() { return puzzle.height + dp(160); });
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
