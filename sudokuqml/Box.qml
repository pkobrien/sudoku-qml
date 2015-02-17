import QtQuick 2.4

BoxForm {
    id: box

    ScaleAnimator on scale {
        from: 0.1;
        to: 1;
        duration: 2000;
    }

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
