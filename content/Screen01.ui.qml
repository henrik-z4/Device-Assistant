

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

    color: Constants.backgroundColor

    Rectangle {
        id: rectangle1
        x: 616
        y: 225
        width: 772
        height: 569
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

        Image {
            id: image
            x: 75
            y: 34
            width: 45
            height: 45
            source: "../assets/Icons/pc-fluent.png"
            fillMode: Image.PreserveAspectFit
        }
    }

    Text {
        id: label
        y: 90
        text: qsTr("Добро пожаловать в device Assistant")
        font.family: Constants.font.family
        anchors.topMargin: 45
        font.pointSize: 28
        anchors.horizontalCenterOffset: 43
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

    property alias gpuInfoField: gpuInfoField

    Grid {
        id: grid
        x: 762
        y: 352
        width: 481
        height: 316
        spacing: 15
        columns: 3

        TextArea {
            id: diskInfoField
            width: 150
            height: 150
            placeholderText: qsTr("Text Area")
            enabled: false
        }

        TextArea {
            id: motherboardInfoField
            width: 150
            height: 150
            placeholderText: qsTr("Text Area")
            enabled: false
        }

        TextArea {
            id: ramInfoField
            width: 150
            height: 150
            placeholderText: qsTr("Text Area")
            enabled: false
        }

        TextArea {
            id: cpuInfoField
            width: 150
            height: 150
            placeholderText: qsTr("Text Area")
            enabled: false
        }

        TextArea {
            id: gpuInfoField
            width: 150
            height: 150
            enabled: false
            placeholderText: qsTr("Text Area")
        }
    }

    Label {
        id: label1
        x: 84
        y: 225
        width: 100
        text: qsTr("Главная")
        font.pointSize: 20
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
