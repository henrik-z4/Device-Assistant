import QtQuick 6.2
import QtQuick.Controls 6.2
import Device_Assistant

Rectangle {
    id: rectangle
    width: Constants.width
    height: Constants.height
    color: "#ffffff"

    property bool goToMainScreen: false
    property bool goToAIScreen: false
    property bool goToSettingsScreen: true

    property bool goToDarkmode: false

    property alias switch1: switch1
    property alias text1: text1
    property alias text6: text6
    property alias text8: text8

    Switch {
        id: switch1
        x: 372
        y: 271
        text: qsTr("")
        font.pointSize: 20
        checked: false
        onCheckedChanged: rectangle.goToDarkmode = !rectangle.goToDarkmode

        Text {
            id: text6
            x: 78
            y: 8
            width: 103
            height: 47
            text: qsTr("Включить ночной режим (ЭКСПЕРИМЕНТАЛЬНАЯ ФУНКЦИЯ)")
            font.pixelSize: 25
            font.styleName: "Обычный"
        }
    }
    Text {
        id: text111
        x: 385
        y: 353
        width: 103
        height: 47
        text: qsTr("Выбрать нейросеть (СКОРО)")
        font.pixelSize: 25
        font.styleName: "Обычный"
    }

    Button {
        id: button
        x: 41
        y: 310
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
        id: button1
        x: 41
        y: 428
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
            text: button1.text
            font.family: "Roboto"
            font.bold: true
            font.pixelSize: 25
            font.weight: Font.SemiBold
            color: button1.hovered ? "#0d53fd" : "black"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    Button {
        id: button2
        x: 41
        y: 540
        width: 244
        height: 100
        visible: true
        text: qsTr("Настройки")
        layer.enabled: false
        highlighted: stackView.currentItem === settingsScreen
        font.pixelSize: 25

        background: Rectangle {
            radius: 20
            border.width: 3
            border.color: "#ab116b"
        }

        contentItem: Text {
            text: button2.text
            font.family: "Roboto"
            font.bold: true
            font.pixelSize: 25
            font.weight: Font.SemiBold
            color: "#ab116b"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    Text {
        id: text1
        x: 370
        y: 169
        width: 103
        height: 47
        text: qsTr("Настройки")
        font.pixelSize: 35
        font.styleName: "Semibold Italic"
    }

    Text {
        id: text8
        x: 115
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
