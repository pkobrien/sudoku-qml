import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QtQuick.Window 2.2

ApplicationWindow {
    title: qsTr("Sudoku")
    width: 500
    height: 500
    visible: true

    menuBar: MenuBar {
        Menu {
            title: qsTr("&File")
            MenuItem {
                text: qsTr("New Puzzle")
                onTriggered: game.setup_random_puzzle(40)
            }
            MenuItem {
                text: qsTr("E&xit")
                onTriggered: Qt.quit()
            }
        }
    }

    Puzzle {
        id: puzzle
        anchors.fill: parent
    }

}
