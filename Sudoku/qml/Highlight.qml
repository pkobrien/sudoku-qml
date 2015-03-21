import QtQuick 2.4

HighlightForm {
    id: highlight

    border.width: dp(3)

    transitions: [
        Transition {
            from: "*"; to: "HIGHLIGHTED"
            ColorAnimation { target: highlight; properties: "border.color"; duration: 1000 }
        },
        Transition {
            from: "HIGHLIGHTED"; to: "*"
            ColorAnimation { target: highlight; properties: "border.color"; duration: 500 }
        }
    ]
}
