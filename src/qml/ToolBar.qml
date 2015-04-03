import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3
import QtQuick.Layouts 1.1
import "." as App

ToolBar {
    id: toolBar

//    height: dp(40)

    RowLayout {
        anchors.fill: parent
        anchors.margins: spacing
        ToolButton { action: App.Actions.newEasyPuzzleAction }
        ToolButton { action: App.Actions.newMediumPuzzleAction }
        ToolButton { action: App.Actions.newHardPuzzleAction }
        Item { Layout.fillWidth: true }
        CheckBox {
            checked: App.Active.showHints
            text: "Show Hints"
            onClicked: App.Active.showHints = checked;
        }
    }
}
