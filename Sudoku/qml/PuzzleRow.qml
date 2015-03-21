import QtQuick 2.4

PuzzleRowForm {
    id: row

    border.width: dp(3)

    transitions: [
        Transition {
            from: "*"; to: "HIGHLIGHTED"
            ColorAnimation { target: row; properties: "border.color"; duration: 1000 }
        },
        Transition {
            from: "HIGHLIGHTED"; to: "*"
            ColorAnimation { target: row; properties: "border.color"; duration: 500 }
        }
    ]
}
