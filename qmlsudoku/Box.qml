import QtQuick 2.4

BoxForm {
    id: box

    transitions: [
        Transition {
            from: "*"; to: "HIGHLIGHTED"
            ColorAnimation { target: box; properties: "border.color"; duration: 1000 }
        },
        Transition {
            from: "HIGHLIGHTED"; to: "*"
            ColorAnimation { target: box; properties: "border.color"; duration: 500 }
        }
    ]
}
