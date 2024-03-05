import QtQuick 6.2
import QtQuick.Controls 6.2
import QtQuick.Layouts 1.15
import Device_Assistant

Rectangle {
    id: rectangle
    width: Constants.width
    height: Constants.height
    color: "#ffffff"
    property alias sendButton: sendButton

    property bool goToMainScreen: false
    property bool goToAIScreen: false
    property bool goToSettingsScreen: false
    property bool goToDbScreen: false

    property alias chatModel: chatView.model
    property alias messageField: messageField

    Rectangle {
        id: rectangle1
        x: 322
        y: 99
        width: 1598
        height: 981
        color: "#eaeaea"

        Text {
            id: text2
            x: -220
            y: 230
            width: 126
            height: 55
            text: qsTr("Главная")
            font.pixelSize: 35
            font.styleName: "Semibold Italic"
        }

        Text {
            id: text3
            x: -220
            y: 331
            width: 126
            height: 55
            text: qsTr("AI")
            font.pixelSize: 35
            horizontalAlignment: Text.AlignHCenter
            font.styleName: "Semibold Italic"
        }

        Text {
            id: text4
            x: -220
            y: 437
            width: 126
            height: 55
            text: qsTr("Комплектующие")
            font.pixelSize: 35
            horizontalAlignment: Text.AlignHCenter
            font.styleName: "Semibold Italic"
        }

        Text {
            id: text5
            x: -220
            y: 543
            width: 126
            height: 55
            text: qsTr("Настройки")
            font.pixelSize: 35
            horizontalAlignment: Text.AlignHCenter
            font.styleName: "Semibold Italic"
        }

        Button {
            id: button
            x: -277
            y: 208
            width: 244
            height: 100
            visible: false
            text: qsTr("Главная")
            layer.enabled: false
            font.pointSize: 20
            highlighted: stackView.currentItem === mainScreen
            onClicked: rectangle.goToMainScreen = !rectangle.goToMainScreen
        }

        Button {
            id: button1
            x: -277
            y: 311
            width: 244
            height: 100
            visible: false
            text: qsTr("AI")
            layer.enabled: false
            font.pointSize: 20
            highlighted: stackView.currentItem === aiScreen
            onClicked: rectangle.goToAIScreen = !rectangle.goToAIScreen
        }

        Button {
            id: button3
            x: -277
            y: 417
            width: 244
            height: 100
            visible: false
            text: "База"
            layer.enabled: false
            font.pointSize: 20
            onClicked: rectangle.goToDbScreen = !rectangle.goToDbScreen
            highlighted: stackView.currentItem === dbScreen
        }

        Button {
            id: button2
            x: -277
            y: 517
            width: 244
            height: 100
            visible: false
            text: qsTr("Настройки")
            layer.enabled: false
            font.pointSize: 20
            onClicked: rectangle.goToSettingsScreen = !rectangle.goToSettingsScreen
            highlighted: stackView.currentItem === settingsScreen
        }
    }

    Button {
        id: sendButton
        x: 1574
        y: 940
        width: 60
        height: 88
        visible: false
        text: qsTr("Отправить")
    }

    ListView {
        id: chatView
        x: 538
        y: 184
        width: 1171
        height: 714
        model: ListModel {
            id: chatModel
        }
        delegate: Text {
            text: model.message
        }

        Rectangle {
            id: rectangle2
            x: 1039
            y: 784
            width: 56
            height: 56
            visible: true
            color: "#0581df"
            clip: false
        }

        Text {
            id: text6
            x: 1020
            y: 633
            width: 200
            height: 200
            color: "#ffffff"
            text: qsTr(">")
            font.pixelSize: 60
            rotation: -90
        }

        Text {
            id: text7
            x: -208
            y: -141
            width: 200
            height: 200
            color: "#000000"
            text: qsTr(">")
            font.pixelSize: 50
            rotation: 90
        }
    }
    TextField {
        id: messageField
        x: 538
        y: 946
        width: 1171
        height: 106
        anchors.bottom: sendButton.top
        anchors.bottomMargin: -100
        font.pointSize: 20
        placeholderText: qsTr("Введите сообщение...")
    }

    Text {
        id: text1
        x: 370
        y: 31
        width: 103
        height: 47
        text: qsTr("GPT-4")
        font.pixelSize: 35
        font.styleName: "Semibold Italic"
    }

    Image {
        id: image
        x: 43
        y: 99
        width: 69
        height: 69
        source: "../../../OneDrive/Изображения/Screenshots/Снимок экрана 2024-03-01 222331.png"
        fillMode: Image.PreserveAspectFit

        Text {
            id: text8
            x: 66
            y: 17
            text: qsTr("Device Assistant")
            font.pixelSize: 25
            font.styleName: "Semibold Italic"
        }
    }

    Image {
        id: image1
        x: 43
        y: 99
        width: 69
        height: 69
        source: "../assets/Icons/DeviceAssistant.jpg"
        fillMode: Image.PreserveAspectFit
        Text {
            id: text9
            x: 66
            y: 17
            text: qsTr("Device Assistant")
            font.pixelSize: 25
            font.styleName: "Semibold Italic"
        }
    }
}
