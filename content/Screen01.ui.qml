

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
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

    property alias gpuInfoField: gpuInfoField
    property alias gpuInfoText: gpuInfoText

    property alias diskInfoField: diskInfoField
    property alias diskInfoText: diskInfoText

    property alias motherboardInfoField: motherboardInfoField
    property alias motherboardInfoText: motherboardInfoText

    property alias cpuInfoField: cpuInfoField
    property alias cpuInfoText: cpuInfoText

    property alias osInfoField: osInfoField
    property alias osInfoText: osInfoText

    property alias ramInfoField: ramInfoField
    property alias ramInfoText: ramInfoText
    property alias text2: text2

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

        Grid {
            id: grid
            x: 75
            y: 247
            width: 461
            height: 678
            rows: 0
            spacing: 30
            columns: 1

            TextArea {
                id: diskInfoField
                width: 300
                height: 70
                placeholderText: qsTr("Носитель")
                enabled: false
            }

            TextArea {
                id: motherboardInfoField
                width: 300
                height: 70
                placeholderText: qsTr("Материнская плата")
                enabled: false
            }

            TextArea {
                id: ramInfoField
                width: 300
                height: 70
                placeholderText: qsTr("Оперативная память")
                enabled: false
            }

            TextArea {
                id: cpuInfoField
                width: 300
                height: 70
                hoverEnabled: true
                placeholderText: qsTr("Процессор")
                enabled: false
            }

            TextArea {
                id: gpuInfoField
                width: 300
                height: 70
                placeholderTextColor: "#60000000"
                enabled: false
                placeholderText: qsTr("Видеокарта")
            }

            TextArea {
                id: osInfoField
                width: 300
                height: 70
                enabled: false
                placeholderText: qsTr("Операционная система")
            }
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

    Text {
        id: text2
        x: 100
        y: 341
        width: 126
        height: 55
        text: qsTr("Главная")
        font.pixelSize: 35
        font.styleName: "Semibold Italic"
    }

    Button {
        id: button
        x: 43
        y: 319
        width: 244
        height: 100
        visible: false
        text: qsTr("Главная")
        onClicked: rectangle.goToMainScreen = !rectangle.goToMainScreen
        layer.enabled: false
        highlighted: stackView.currentItem === mainScreen
        font.pointSize: 20
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
    }

    Button {
        id: button1
        x: 43
        y: 422
        width: 244
        height: 100
        visible: false
        text: qsTr("AI")
        onClicked: rectangle.goToAIScreen = !rectangle.goToAIScreen
        layer.enabled: false
        highlighted: stackView.currentItem === aiScreen
        font.pointSize: 20
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
    }

    Button {
        id: button3
        x: 43
        y: 528
        width: 244
        height: 100
        visible: false
        text: "База"
        onClicked: rectangle.goToDbScreen = !rectangle.goToDbScreen
        layer.enabled: false
        highlighted: stackView.currentItem === dbScreen
        font.pointSize: 20
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
    }

    Button {
        id: button2
        x: 43
        y: 628
        width: 244
        height: 100
        visible: false
        text: qsTr("Настройки")
        onClicked: rectangle.goToSettingsScreen = !rectangle.goToSettingsScreen
        layer.enabled: false
        highlighted: stackView.currentItem === settingsScreen
        font.pointSize: 20
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

        Image {
            id: image2
            x: 75
            y: 34
            width: 45
            height: 45
            source: "qrc:/images/assets/Icons/pc.svg"
            fillMode: Image.PreserveAspectFit
        }
    }

    Text {
        id: motherboardInfoText
        x: 742
        y: 299
        text: qsTr("")
        font.pixelSize: 35
        font.styleName: "Semibold Italic"
    }

    Text {
        id: diskInfoText
        x: 758
        y: 422
        text: qsTr("")
        font.pixelSize: 35
        font.styleName: "Semibold Italic"
    }

    Text {
        id: ramInfoText
        x: 806
        y: 279
        width: 43
        height: 47
        text: qsTr("")
        font.pixelSize: 35
        font.styleName: "Semibold Italic"
    }

    Text {
        id: osInfoText
        x: 850
        y: 385
        width: 65
        height: 47
        text: qsTr("")
        font.pixelSize: 35
        font.styleName: "Semibold Italic"
    }

    Text {
        id: cpuInfoText
        x: 758
        y: 484
        text: qsTr("")
        font.pixelSize: 35
        font.styleName: "Semibold Italic"
    }

    Text {
        id: gpuInfoText
        x: 758
        y: 554
        text: qsTr("")
        font.pixelSize: 35
        font.styleName: "Semibold Italic"
    }

    states: [
        State {
            name: "clicked"
        }
    ]
}
