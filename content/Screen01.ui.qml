

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

    property alias gpuInfoText: gpuInfoText
    property alias diskInfoText: diskInfoText
    property alias motherboardInfoText: motherboardInfoText
    property alias cpuInfoText: cpuInfoText
    property alias osInfoText: osInfoText
    property alias ramInfoText: ramInfoText

    property alias recommendations: recommendations

    Rectangle {
        id: rectangle1
        x: 314
        y: 17
        width: 557
        height: 1046
        color: "#eaeaea"
        radius: 20

        Text {
            id: text1
            x: 75
            y: 102
            text: qsTr("Ваше устройство")
            font.pixelSize: 35
            font.styleName: "Semibold Italic"
        }

        Text {
            id: text6
            x: 632
            y: 162
            text: qsTr("Персональные рекомендации")
            font.pixelSize: 35
            font.styleName: "Semibold Italic"
        }
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

    Rectangle {
        id: rectangle2
        x: 941
        y: 265
        width: 926
        height: 724
        color: "#ffffff"
        radius: 20
        border.color: "#000000"
        border.width: 2
    }

    Rectangle {
        id: rectangle3
        x: 360
        y: 185
        width: 464
        height: 132
        color: "#ffffff"
        radius: 20
        border.color: "#de2424"
        border.width: 3
    }

    states: [
        State {
            name: "clicked"
        }
    ]

    Text {
        id: cpuText
        x: 514
        y: 193
        width: 165
        height: 40
        text: qsTr("Процессор")
        font.pixelSize: 30
        font.styleName: "Semibold Italic"

        Text {
            id: cpuInfoText
            x: -107
            y: 55
            width: 100
            height: 50
            text: qsTr("")
            font.pixelSize: 20
            font.styleName: "Обычный"
        }
    }

    Rectangle {
        id: rectangle4
        x: 360
        y: 329
        width: 464
        height: 132
        color: "#ffffff"
        radius: 20
        border.color: "#4024d8"
        border.width: 3
    }
    Text {
        id: recommendations
        font.family: "Arial"
        x: 960
        y: 294
        width: 889
        height: 675
        text: ""
        wrapMode: Text.WordWrap
        elide: Text.ElideNone
        font.pixelSize: 20
    }
    Text {
        id: gpuText
        x: 514
        y: 349
        text: qsTr("Видеокарта")
        font.pixelSize: 30
        font.styleName: "Semibold Italic"

        Text {
            id: gpuInfoText
            x: -107
            y: 55
            width: 100
            height: 50
            text: qsTr("")
            font.pixelSize: 20
            font.styleName: "Обычный"
        }
    }

    Rectangle {
        id: rectangle5
        x: 361
        y: 476
        width: 464
        height: 132
        color: "#ffffff"
        radius: 20
        border.color: "#8f0fe8"
        border.width: 3
    }

    Text {
        id: diskText
        x: 508
        y: 504
        width: 165
        text: qsTr("Накопитель")
        font.pixelSize: 30
        font.styleName: "Semibold Italic"

        Text {
            id: diskInfoText
            x: -107
            y: 46
            width: 100
            height: 50
            text: qsTr("")
            font.pixelSize: 20
            font.styleName: "Обычный"
        }
    }

    Rectangle {
        id: rectangle6
        x: 360
        y: 626
        width: 464
        height: 132
        color: "#ffffff"
        radius: 20
        border.color: "#ddf107"
        border.width: 3
    }

    Rectangle {
        id: rectangle7
        x: 360
        y: 773
        width: 464
        height: 132
        color: "#ffffff"
        radius: 20
        border.color: "#2e8737"
        border.width: 3
    }

    Rectangle {
        id: rectangle8
        x: 360
        y: 920
        width: 464
        height: 132
        color: "#ffffff"
        radius: 20
        border.color: "#ea3590"
        border.width: 3
    }
    Text {
        id: motherboardText
        x: 459
        y: 785
        text: qsTr("Материнская плата")
        font.pixelSize: 30
        font.styleName: "Semibold Italic"

        Text {
            id: motherboardInfoText
            x: -61
            y: 50
            width: 100
            height: 50
            text: qsTr("")
            font.pixelSize: 20
            font.styleName: "Обычный"
        }
    }
    Text {
        id: osText
        x: 430
        y: 929
        text: qsTr("Операционная система")
        font.pixelSize: 30
        font.styleName: "Semibold Italic"

        Text {
            id: osInfoText
            x: -48
            y: 50
            width: 100
            height: 50
            text: qsTr("")
            font.pixelSize: 17
            font.styleName: "Обычный"
        }
    }
    Text {
        id: ramText
        x: 449
        y: 633
        text: qsTr("Оперативная память")
        font.pixelSize: 30
        font.styleName: "Semibold Italic"

        Text {
            id: ramInfoText
            x: 97
            y: 50
            width: 100
            height: 50
            text: qsTr("")
            font.pixelSize: 20
            font.styleName: "Обычный"
        }
    }

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
            border.width: 3
        }

        contentItem: Text {
            text: button.text
            font.family: "Roboto"
            font.bold: true
            font.pixelSize: 25
            font.weight: Font.SemiBold
            color: "#cb1b1b"
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
        y: 545
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
