

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick 6.2
import QtQuick.Controls 6.2
import QtQuick.Layouts 1.3
import Device_Assistant

Rectangle {
    id: rectangle
    width: Constants.width
    height: Constants.height
    color: "#eaeaea"
    property alias imageSource: image.source

    property alias rectangle1: rectangle1
    property alias rectangle2: rectangle2
    property alias label: label
    property alias text1: text1

    property bool goToMainScreen: false
    property bool goToAIScreen: false
    property bool goToSettingsScreen: false

    property alias systemInfoList: systemInfoListInstance
    property alias recommendations: recommendations

    Rectangle {
        id: rectangle1
        x: 377
        y: 223
        width: 1217
        height: 701
        color: "#ffffff"
        radius: 20

        Text {
            id: text1
            x: 145
            y: 41
            text: qsTr("Ваше устройство")
            font.pixelSize: 22
            font.styleName: "Semibold"
        }

        SystemInfoList {
            id: systemInfoListInstance
            x: 144
            y: 124
            width: parent.width
            height: parent.height
        }

        Image {
            id: image
            x: 75
            y: 34
            width: 45
            height: 45
            source: "qrc:/images/assets/Icons/pc.svg"
            fillMode: Image.PreserveAspectFit
        }
    }

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
            highlighted: stackView.currentItem === mainScreen
            onClicked: rectangle.goToMainScreen = !rectangle.goToMainScreen
        }

        Button {
            id: button1
            x: -327
            y: 202
            width: 244
            height: 100
            text: qsTr("AI")
            highlighted: stackView.currentItem === aiScreen
            onClicked: rectangle.goToAIScreen = !rectangle.goToAIScreen
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
            text: qsTr("Добро пожаловать в Device Assistant")
            font.family: Constants.font.family
            anchors.topMargin: 45
            font.pointSize: 28
            anchors.horizontalCenterOffset: -219
            anchors.horizontalCenter: parent.horizontalCenter

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
        }

        Text {
            id: recommendations
            x: 73
            y: 484
            width: 1097
            height: 298
            text: ""
        }
    }

    states: [
        State {
            name: "clicked"

            PropertyChanges {
                target: label
                text: qsTr("Button Checked")
            }
        }
    ]
}
