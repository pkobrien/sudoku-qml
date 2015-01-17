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

        Repeater {
            model: 9

            Hint {
                id: hint
                width: hintGrid.width / grid.columns
                height: hintGrid.height / grid.rows
                hintText.text: index + 1
            }
        }
    }
}
