import QtQuick 2.4

PuzzleColumnForm {
    id: column

    border.width: dp(3)

    transitions: [
        Transition {
            from: "*"; to: "HIGHLIGHTED"
            ColorAnimation { target: column; properties: "border.color"; duration: 1000 }
        },
        Transition {
            from: "HIGHLIGHTED"; to: "*"
            ColorAnimation { target: column; properties: "border.color"; duration: 500 }
        }
    ]
}
