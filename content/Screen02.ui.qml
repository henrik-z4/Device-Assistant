import QtQuick 6.2
import QtQuick.Controls 6.2
import Device_Assistant

Rectangle {
    id: rectangle
    width: Constants.width
    height: Constants.height
    color: "#eaeaea"

    property bool goToMainScreen: false
    property bool goToAIScreen: false
    property bool goToSettingsScreen: false

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
        y: 318
        width: 244
        height: 100
        text: qsTr("AI")
        highlighted: stackView.currentItem === aiScreen
        onClicked: rectangle.goToAIScreen = !rectangle.goToAIScreen
    }

    Button {
        id: button2
        x: 43
        y: 424
        width: 244
        height: 100
        text: qsTr("Настройки")
        onClicked: rectangle.goToSettingsScreen = !rectangle.goToSettingsScreen
        highlighted: stackView.currentItem === settingsScreen
    }

    Button {
        id: sendButton
        x: 886
        y: 841
        width: 244
        height: 100
        text: qsTr("Отправить")
    }

    ListView {
        id: chatView
        x: 545
        y: 229
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
        x: 699
        y: 596
        width: 617
        height: 100
        anchors.bottom: sendButton.top
        anchors.bottomMargin: 14
        placeholderText: qsTr("Введите сообщение для GPT-4")
    }

    Rectangle {
        id: rectangle2
        x: 377
        y: 98
        width: 1217
        height: 96
        color: "#ffffff"
        radius: 20

        Text {
            id: label
            x: 0
            y: 23
            text: qsTr("Искусственный интеллект")
            anchors.topMargin: 45
            font.pointSize: 28
            font.family: Constants.font.family
            SequentialAnimation {
                id: animation
                ColorAnimation {
                    id: colorAnimation1
                    target: rectangle
                    property: "color"
                    to: "#2294c6"
                    from: Constants.backgroundColor
                }

                ColorAnimation {
                    id: colorAnimation2
                    target: rectangle
                    property: "color"
                    to: Constants.backgroundColor
                    from: "#2294c6"
                }
            }
            anchors.horizontalCenterOffset: -368
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
