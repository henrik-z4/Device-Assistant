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

    property bool goToDarkmode: false

    property alias rectangle2: rectangle2
    property alias switch1: switch1

    Rectangle {
        id: rectangle2
        x: 377
        y: 98
        width: 1217
        height: 96
        color: "#ffffff"
        radius: 20

        Button {
            id: button
            x: -327
            y: 96
            width: 244
            height: 100
            text: qsTr("Главная")
            onClicked: rectangle.goToMainScreen = !rectangle.goToMainScreen
            highlighted: stackView.currentItem === mainScreen
        }

        Button {
            id: button1
            x: -327
            y: 202
            width: 244
            height: 100
            text: qsTr("AI")
            onClicked: rectangle.goToAIScreen = !rectangle.goToAIScreen
            highlighted: stackView.currentItem === aiScreen
        }

        Button {
            id: button2
            x: -327
            y: 308
            width: 244
            height: 100
            text: qsTr("Настройки")
            onClicked: rectangle.goToSettingsScreen = !rectangle.goToSettingsScreen
            highlighted: stackView.currentItem === settingsScreen
        }

        Text {
            id: label
            x: 0
            y: 23
            text: qsTr("Настройки")
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
            anchors.horizontalCenterOffset: -497
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    Switch {
        id: switch1
        x: 433
        y: 289
        text: qsTr("Включить тёмную тему")
        checked: false
        onCheckedChanged: rectangle.goToDarkmode = !rectangle.goToDarkmode
    }
}
