import QtQuick 2.4
import "." as App

App.HintForm {
    id: hint

    width: dp(13)
    height: dp(13)

    hintText.font.pixelSize: dp(10)

    matchingDigit: (on && App.Active.showMatchingDigits && digit &&
                    App.Active.square && digit === App.Active.square.digit)

}
