import QtQuick 2.4
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.2

Rectangle {
    id: hintGrid
    width: 40
    height: 40
    color: "#00000000"

    property alias hints: grid.children

    Grid {
        id: grid
        columns: 3
        rows: 3
        anchors.centerIn: parent

        Repeater {
            model: 9

            Hint {
                id: hint
                width: (hintGrid.width - 4) / grid.columns
                height: (hintGrid.height - 4) / grid.rows
                hintText.text: index + 1
            }
        }
    }
}
