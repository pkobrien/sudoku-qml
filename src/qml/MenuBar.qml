import QtQuick 2.4
import QtQuick.Controls 1.3
import "." as App

MenuBar {
    id: menuBar

    Menu {
        title: "&File"
        MenuItem { action: App.Actions.scaleDownAction }
        MenuItem { action: App.Actions.scaleUpAction }
        MenuSeparator { }
        MenuItem { action: App.Actions.appQuitAction }
    }

    Menu {
        title: "&Puzzle"
        MenuItem { action: App.Actions.newEasyPuzzleAction }
        MenuItem { action: App.Actions.newMediumPuzzleAction }
        MenuItem { action: App.Actions.newHardPuzzleAction }
    }
}
