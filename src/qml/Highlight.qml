import QtQuick 2.4
import "." as App

App.HighlightForm {
    id: highlight

    border.width: dp(3)

    property bool isActive: false

    on: (App.Active.showHighlights && isActive)

    transitions: [
        Transition {
            from: "*"; to: "On"
            ColorAnimation {
                target: highlight;
                properties: "border.color";
                duration: 1000
            }
        },
        Transition {
            from: "On"; to: "*"
            ColorAnimation {
                target: highlight;
                properties: "border.color";
                duration: 500
            }
        }
    ]
}
