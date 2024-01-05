import QtQuick 6.2
import QtQuick.Controls 6.2
import Device_Assistant

Rectangle {
    id: rectangle
    width: Constants.width
    height: Constants.height
    color: Constants.backgroundColor

    property bool goToMainScreen: false
    property bool goToAIScreen: false

    Button {
        id: button
        x: 43
        y: 212
        width: 244
        height: 100
        text: qsTr("Главная")
        highlighted: stackView.currentItem === mainScreen
        onClicked: rectangle.goToMainScreen = !rectangle.goToMainScreen
    }

    Button {
        id: button1
        x: 43
        y: 361
        width: 244
        height: 100
        text: qsTr("AI")
        highlighted: stackView.currentItem === aiScreen
        onClicked: rectangle.goToAIScreen = !rectangle.goToAIScreen
    }

}