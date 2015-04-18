import QtQuick 2.4
import "." as App

App.HighlightForm {
    id: highlight

    border.width: dp(3)

    transitions: [
        Transition {
            from: "*"; to: "ACTIVE"
            ColorAnimation {
                target: highlight;
                properties: "border.color";
                duration: 1000
            }
        },
        Transition {
            from: "ACTIVE"; to: "*"
            ColorAnimation {
                target: highlight;
                properties: "border.color";
                duration: 500
            }
        }
    ]
}
