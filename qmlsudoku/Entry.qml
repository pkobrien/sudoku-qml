import QtQuick 2.4

EntryForm {
    id: entry

    states: [
        State {
            name: "WRONG-ANSWER"
            PropertyChanges {target: entry; font.underline: true}
        }
    ]
}

