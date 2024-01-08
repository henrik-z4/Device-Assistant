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
    property alias chatModel: chatView.model
    property alias messageField: messageField
    property alias sendButton: sendButton

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

    ListView {
        id: chatView
        x: 536
        y: 124
        width: 927
        height: 470
        model: ListModel {
            id: chatModel
        }
        delegate: Text {
            text: model.message
        }
    }
    TextField {
        id: messageField
        x: 691
        y: 582
        width: 617
        height: 100
        anchors.bottom: sendButton.top
        anchors.bottomMargin: -6
        placeholderText: qsTr("Введите сообщение для GPT-4")
    }

    Button {
        id: sendButton
        x: 878
        y: 710
        width: 244
        height: 100
        text: qsTr("Отправить")
    }
}
