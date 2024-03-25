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
    property bool goToСomponentsScreen: false


    property alias chatModel: chatView.model
    property alias messageField: messageField
    property alias rectangle1: rectangle1
    property alias text1: text1
    property alias text7: text7
    property alias text8: text8
    property alias sendButtonText: sendButtonText

    Rectangle {
        id: rectangle1
        x: 322
        y: 99
        width: 1598
        height: 981
        color: "#eaeaea"

        Button {
            id: button
            x: -282
            y: 209
            width: 244
            height: 100
            visible: true
            text: qsTr("Главная")
            onClicked: rectangle.goToMainScreen = !rectangle.goToMainScreen
            layer.enabled: true
            highlighted: stackView.currentItem === mainScreen
            font.pointSize: 25

            background: Rectangle {
                radius: 20
                border.color: button.hovered ? "#cb1b1b" : "transparent"
                border.width: 3
            }

            contentItem: Text {
                text: button.text
                font.family: "Roboto"
                font.bold: true
                font.pixelSize: 25
                font.weight: Font.SemiBold
                color: button.hovered ? "#cb1b1b" : "black"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        Button {
            id: button3
            x: -282
            y: 468
            width: 244
            height: 100
            visible: true
            text: qsTr("Комплектующие")
            onClicked: rectangle.goToСomponentsScreen = !rectangle.goToСomponentsScreen
            layer.enabled: false
            highlighted: stackView.currentItem === componentsScreen
            font.pointSize: 25

            background: Rectangle {
                radius: 20
                border.width: 3
                border.color: button3.hovered ? "#8f0fe8" : "transparent"
            }

            contentItem: Text {
                font.family: "Roboto"
                font.bold: true
                font.pixelSize: 25
                font.weight: Font.SemiBold
                color: button3.hovered ? "#8f0fe8" : "black"
                text: "Комплектующие"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        Button {
            id: button1
            x: -282
            y: 328
            width: 244
            height: 100
            visible: true
            text: qsTr("AI")
            onClicked: rectangle.goToAIScreen = !rectangle.goToAIScreen
            layer.enabled: false
            highlighted: stackView.currentItem === aiScreen
            font.pointSize: 25

            background: Rectangle {
                radius: 20
                border.width: 3
                border.color: button1.hovered ? "#0d53fd" : "transparent"
            }

            contentItem: Text {
                font.family: "Roboto"
                font.bold: true
                font.pixelSize: 25
                font.weight: Font.SemiBold
                color: button1.hovered ? "#0d53fd" : "black"
                text: "AI"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        Button {
            id: button2
            x: -282
            y: 610
            width: 244
            height: 100
            visible: true
            text: qsTr("Настройки")
            onClicked: rectangle.goToSettingsScreen = !rectangle.goToSettingsScreen
            layer.enabled: false
            highlighted: stackView.currentItem === settingsScreen
            font.pixelSize: 25

            background: Rectangle {
                radius: 20
                border.width: 3
                border.color: button2.hovered ? "#ab116b" : "transparent"
            }

            contentItem: Text {
                text: button2.text
                font.family: "Roboto"
                font.bold: true
                font.pixelSize: 25
                font.weight: Font.SemiBold
                color: button2.hovered ? "#ab116b" : "black"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
    }

    ListView {
        id: chatView
        x: 538
        y: 184
        width: 1171
        height: 714
        clip: true
        anchors.bottomMargin: messageField.height
        model: ListModel {
            id: chatModel
        }
        delegate: Text {
            color: "#000000"
            width: chatView.width
            wrapMode: Text.WordWrap
            text: model.message
            font.pixelSize: 24
        }
    }
    TextField {
        id: messageField
        x: 538
        y: 946
        width: 1171
        height: 106
        font.styleName: "Semibold Italic"
        font.pointSize: 20
        placeholderText: qsTr("Введите сообщение...")

        Button {
            id: sendButton
            x: 1183
            y: 6
            width: 174
            height: 98
            visible: true
            flat: true
            clip: false
            background: Rectangle {
                color: sendButton.hovered ? "#230e3b" : "transparent"
                radius: 28
                border.color: "#7163db"
                border.width: 3
            }
            contentItem: Text {
                id: sendButtonText
                text: qsTr("Отправить")
                font.pixelSize: 20
                color: sendButton.hovered ? "#FFFFFF" : "black"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
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

        Text {
            id: text7
            x: -40
            y: 12
            width: 200
            height: 200
            color: "#000000"
            text: qsTr(">")
            font.pixelSize: 50
            rotation: 90
        }
    }

    Text {
        id: text8
        x: 120
        y: 116
        text: qsTr("Device Assistant")
        font.pixelSize: 25
        font.styleName: "Semibold Italic"
        Image {
            id: image1
            x: -72
            y: -17
            width: 69
            height: 69
            source: "qrc:/assets/icons/DeviceAssistant.jpg"
            fillMode: Image.PreserveAspectFit
        }
    }
}
