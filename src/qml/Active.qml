pragma Singleton

import QtQuick 2.4

QtObject {
    id: activeSingleton

    property var appWindow

    property var puzzle

    property bool showHighlights: true
    property bool showHints: true
    property bool showMatchingDigits: true

    property var square: null
}
