import QtQuick 2.4
import "." as App

App.EntryForm {
    id: entry

    width: dp(40)
    height: dp(40)

    font.pixelSize: dp(30)

    onFocusChanged: {
        if (entry.activeFocus) {
            entry.selectAll();
        }
    }
}
