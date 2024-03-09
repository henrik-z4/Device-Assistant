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
    property bool goToSettingsScreen: false
    property bool goToDbScreen: false

    property bool goToDarkmode: false

    property alias switch1: switch1
    property alias text1: text1
    property alias text2: text2
    property alias text3: text3
    property alias text4: text4
    property alias text5: text5
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
            text: qsTr("Включить ночной режим")
            font.pixelSize: 25
            font.styleName: "Обычный"
        }
    }

    Text {
        id: text2
        x: 100
        y: 341
        width: 126
        height: 55
        text: qsTr("Главная")
        font.pixelSize: 35
        font.styleName: "Semibold Italic"

        Button {
            id: button
            x: -57
            y: -22
            width: 244
            height: 100
            visible: false
            text: qsTr("Главная")
            onClicked: rectangle.goToMainScreen = !rectangle.goToMainScreen
            layer.enabled: false
            highlighted: stackView.currentItem === mainScreen
            font.pointSize: 20
        }
    }

    Text {
        id: text3
        x: 100
        y: 442
        width: 126
        height: 55
        text: qsTr("AI")
        font.pixelSize: 35
        horizontalAlignment: Text.AlignHCenter
        font.styleName: "Semibold Italic"

        Button {
            id: button1
            x: -57
            y: -20
            width: 244
            height: 100
            visible: false
            text: qsTr("AI")
            onClicked: rectangle.goToAIScreen = !rectangle.goToAIScreen
            layer.enabled: false
            highlighted: stackView.currentItem === aiScreen
            font.pointSize: 20
        }
    }

    Text {
        id: text4
        x: 100
        y: 548
        width: 126
        height: 55
        text: qsTr("Комплектующие")
        font.pixelSize: 35
        horizontalAlignment: Text.AlignHCenter
        font.styleName: "Semibold Italic"

        Button {
            id: button3
            x: -57
            y: -20
            width: 244
            height: 100
            visible: false
            text: "База"
            onClicked: rectangle.goToDbScreen = !rectangle.goToDbScreen
            layer.enabled: false
            highlighted: stackView.currentItem === dbScreen
            font.pointSize: 20
        }
    }

    Text {
        id: text5
        x: 100
        y: 654
        width: 126
        height: 55
        text: qsTr("Настройки")
        font.pixelSize: 35
        horizontalAlignment: Text.AlignHCenter
        font.styleName: "Semibold Italic"

        Button {
            id: button2
            x: -57
            y: -26
            width: 244
            height: 100
            visible: false
            text: qsTr("Настройки")
            onClicked: rectangle.goToSettingsScreen = !rectangle.goToSettingsScreen
            layer.enabled: false
            highlighted: stackView.currentItem === settingsScreen
            font.pointSize: 20
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
