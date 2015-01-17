import QtQuick 2.4
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.2

Rectangle {
    id: box
    width: 120
    height: 120

    property alias squares: grid.children

    Grid {
        id: grid
        columns: 3
        rows: 3
        spacing: 0

        Repeater {
            model: 9

            Square {
                width: box.width / grid.columns
                height: box.height / grid.rows
            }
        }
    }
}
