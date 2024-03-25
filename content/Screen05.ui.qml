

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick 6.2
import QtQuick.Controls 6.2
import Device_Assistant
import QtQuick.Layouts

Rectangle {
    id: rectangle
    width: Constants.width
    height: Constants.height
    color: "#ffffff"

    property bool goToMainScreen: false
    property bool goToAIScreen: false
    property bool goToSettingsScreen: false
    property bool goToСomponentsScreen: false

    property alias text8: text8

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

    states: [
        State {
            name: "clicked"
        }
    ]

    Button {
        id: button
        x: 41
        y: 294
        width: 244
        height: 100
        visible: true
        text: qsTr("Главная")
        layer.enabled: true
        highlighted: stackView.currentItem === mainScreen
        font.pointSize: 25

        background: Rectangle {
            radius: 20
            border.color: "#cb1b1b"
            border.width: 0
        }

        contentItem: Text {
            text: button.text
            font.family: "Roboto"
            font.bold: true
            font.pixelSize: 25
            font.weight: Font.SemiBold
            color: "black"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    Button {
        id: button3
        x: 41
        y: 568
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
        x: 41
        y: 710
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
