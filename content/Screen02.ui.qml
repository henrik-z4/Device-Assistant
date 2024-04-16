import QtQuick 6.2
import QtQuick.Controls 6.2
import QtQuick.Layouts 1.15
import Device_Assistant

Rectangle {
    id: rectangle
    width: Constants.width
    height: Constants.height
    color: "#eff4f9"
    property alias sendButton: sendButton

    property bool goToMainScreen: false
    property bool goToAIScreen: false
    property bool goToSettingsScreen: false
    property bool goToDarkmode: false
    property bool executeReconnectivity: false

    property alias chatModel: chatView.model
    property alias messageField: messageField
    property alias rectangle1: rectangle1
    property alias text1: text1
    property alias text8: text8
    property alias sendButtonText: sendButtonText
    property alias reconnectivityButtonText: reconnectivityButtonText
    property alias text2: text2
    property alias connectivityIndicator: connectivityIndicator

    property alias buttonrectangle: buttonrectangle
    property alias button1rectangle: button1rectangle
    property alias button2rectangle: button2rectangle

    Rectangle {
        id: rectangle1
        x: 322
        y: 99
        width: 1598
        height: 981
        color: "#fbfcfd"
        radius: 10

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
            width: chatView.width
            wrapMode: Text.WordWrap
            text: model.message
            font.pixelSize: 24
        }
    }

    Button {
        id: button
        x: 40
        y: 308
        width: 244
        height: 100
        visible: true
        text: qsTr("Главная")
        onClicked: rectangle.goToMainScreen = !rectangle.goToMainScreen
        layer.enabled: true
        highlighted: stackView.currentItem === mainScreen
        font.pointSize: 25

        background: Rectangle {
            id: buttonrectangle
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
        x: 40
        y: 425
        width: 244
        height: 100
        visible: true
        text: qsTr("AI")
        layer.enabled: false
        highlighted: stackView.currentItem === aiScreen
        font.pointSize: 25

        background: Rectangle {
            id: button1rectangle
            radius: 20
            border.width: 3
            border.color: "#0d53fd"
        }

        contentItem: Text {
            text: button1.text
            font.family: "Roboto"
            font.bold: true
            font.pixelSize: 25
            font.weight: Font.SemiBold
            color: "#0d53fd"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    Button {
        id: button2
        x: 40
        y: 542
        width: 244
        height: 100
        visible: true
        text: qsTr("Настройки")
        onClicked: rectangle.goToSettingsScreen = !rectangle.goToSettingsScreen
        layer.enabled: false
        highlighted: stackView.currentItem === settingsScreen
        font.pixelSize: 25

        background: Rectangle {
            id: button2rectangle
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

    Button {
        id: button3
        x: 1156
        y: 11
        width: 207
        height: 85
        visible: true
        text: qsTr("Обновить")
        onClicked: rectangle.executeReconnectivity = !rectangle.executeReconnectivity
        layer.enabled: false
        highlighted: stackView.currentItem === aiScreen
        font.pointSize: 25

        background: Rectangle {
            radius: 20
            border.color: "#000000"
            border.width: 3
            color: button3.hovered ? "#230e3b" : "transparent"
        }

        contentItem: Text {
            id: reconnectivityButtonText
            text: button3.text
            font.family: "Roboto"
            font.bold: true
            font.pixelSize: 25
            font.weight: Font.SemiBold
            color: button3.hovered ? "#ffffff" : "black"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
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
            text: qsTr("Отправить")
            flat: true
            clip: false

            background: Rectangle {
                radius: 28
                border.color: "#7163db"
                border.width: 3
                color: sendButton.hovered ? "#230e3b" : "transparent"
            }

            contentItem: Text {
                id: sendButtonText
                text: sendButton.text
                font.pixelSize: 25
                color: sendButton.hovered ? "#FFFFFF" : "black"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.weight: Font.SemiBold
                font.family: "Roboto"
                font.bold: true
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

    Text {
        id: text2
        x: 520
        y: 31
        width: 615
        height: 47
        text: qsTr("")
        font.pixelSize: 35
        font.styleName: "Semibold Italic"
    }

    Rectangle {
        id: connectivityIndicator
        x: 478
        y: 43
        width: 27
        height: 27
        color: "#eff4f9"
        radius: 49
    }

    Image {
        id: image3
        x: 56
        y: 343
        width: 32
        height: 32
        source: "qrc:/assets/Icons/User.ico"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: image2
        x: 56
        y: 460
        width: 32
        height: 32
        source: "qrc:/assets/Icons/Network.ico"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: image
        x: 56
        y: 578
        width: 32
        height: 32
        source: "qrc:/assets/Icons/Settings.ico"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: image4
        x: 332
        y: 41
        width: 32
        height: 32
        source: "qrc:/assets/Icons/Network.ico"
        fillMode: Image.PreserveAspectFit
    }




}
