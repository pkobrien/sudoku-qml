import QtQuick 2.4

HintForm {
    id: hint

    Component.onCompleted: {
        hint.hints[0].children[0].text = "1"
        hint.hints[1].children[0].text = "2"
        hint.hints[2].children[0].text = "3"
        hint.hints[3].children[0].text = "4"
        hint.hints[4].children[0].text = "5"
        hint.hints[5].children[0].text = "6"
        hint.hints[6].children[0].text = "7"
        hint.hints[7].children[0].text = "8"
        hint.hints[8].children[0].text = "9"
    }
}
