pragma Singleton

import QtQuick 2.4
import QtQuick.Controls 1.3
import Candy 1.0 as Candy
import "." as App

QtObject {
    id: actionsSingleton

//    property var awesome: Candy.FontAwesome
//    property var fa: Candy.FontAwesome.icons

    property Action appQuitAction: Action {
        text: qsTr("E&xit")
        tooltip: qsTr("Exit the application")
        onTriggered: Qt.quit();
    }

    property Action developerInfoAction: Action {
        text: qsTr("Developer Info")
        onTriggered: {
            console.log("dp(48)", dp(48));
            console.log("dp(5)", dp(5));
            console.log("dp(4)", dp(4));
            console.log("dp(3)", dp(3));
            console.log("dp(2)", dp(2));
            console.log("dp(1)", dp(1));
            console.log("dp(0)", dp(0));
        }
    }

    property Action newEasyPuzzleAction: Action {
        text: qsTr("New Easy Puzzle")
        onTriggered: py.game.setup_random_puzzle(50);
    }

    property Action newMediumPuzzleAction: Action {
        text: qsTr("New Medium Puzzle")
        onTriggered: py.game.setup_random_puzzle(40);
    }

    property Action newHardPuzzleAction: Action {
        text: qsTr("New Hard Puzzle")
        onTriggered: py.game.setup_random_puzzle(30);
    }

    property Action scaleDownAction: Action {
        text: qsTr("Scale Down")
        onTriggered: {
            Candy.Units.scaleFactor = Math.max(1.0, Candy.Units.scaleFactor - 1.0);
            console.log("Candy.Units.scaleFactor", Candy.Units.scaleFactor);
        }
    }

    property Action scaleUpAction: Action {
        text: qsTr("Scale Up")
        onTriggered: { Candy.Units.scaleFactor += 1.0; console.log("Candy.Units.scaleFactor", Candy.Units.scaleFactor); }
    }

    function keyPressed(event, source) {
        if (event.key === Qt.Key_Escape) {
            event.accepted = true; // Otherwise menuBarArea gets focus for some strange reason.
        } else if (event.matches(StandardKey.Quit) ||
                (event.key === Qt.Key_Q && event.modifiers === Qt.ControlModifier)) {
            appQuitAction.trigger(source);
        } else if (event.key === Qt.Key_Minus && event.modifiers === (Qt.ControlModifier | Qt.KeypadModifier)) {
            scaleDownAction.trigger(source);
        } else if (event.key === Qt.Key_Plus && event.modifiers === (Qt.ControlModifier | Qt.KeypadModifier)) {
            scaleUpAction.trigger(source);
        } else {
            event.accepted = false;
            return;
        }
        event.accepted = true;
    }

    Component.onCompleted: {
        // Keep all the shortcut assignments here simply to group them together for clarity.
        appQuitAction.shortcut = "Ctrl+Q";
        // There is currently a bug in QML when this file is a singleton whereby the shortcuts
        // no longer work. Therefore the key handling is also handled in the keyPressed function.
    }
}
