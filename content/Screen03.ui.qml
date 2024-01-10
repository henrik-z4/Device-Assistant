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
    property bool goToDbScreen: false

    property bool goToDarkmode: false

    property alias currentTab: tabBar.currentIndex

    TabBar{
        id: tabBar
        width: parent.width

        TabButton { text: "Видеокарты" }
        TabButton { text: "Процессоры" }
        TabButton { text: "Носители" }
        TabButton { text: "Материнские платы" }
        TabButton { text: "Блоки питания" }
        TabButton { text: "Оперативная память" }
        TabButton { text: "Корпуса" }
        TabButton { text: "Охлаждение" }
        TabButton { text: "Мониторы" }
        TabButton { text: "Клавиатуры" }
        TabButton { text: "Мыши" }
        TabButton { text: "Микрокарты" }
        TabButton { text: "Сетевое оборудование" }
        TabButton { text: "Программное обеспечение" }
    }

    StackView{
        id: stackView
        anchors { top: tabBar.bottom; bottom: parent.bottom; left: parent.left; right: parent.right }
    }

    Button {
        id: button
        x: 43
        y: 212
        width: 244
        height: 100
        text: qsTr("Главная")
        onClicked: rectangle.goToMainScreen = !rectangle.goToMainScreen
        highlighted: stackView.currentItem === mainScreen
    }

    Button {
        id: button1
        x: 43
        y: 318
        width: 244
        height: 100
        text: qsTr("AI")
        onClicked: rectangle.goToAIScreen = !rectangle.goToAIScreen
        highlighted: stackView.currentItem === aiScreen
    }

    Button {
        id: button3
        x: 43
        y: 424
        width: 244
        height: 100
        text: qsTr("База")
        onClicked: rectangle.goToDbScreen = !rectangle.goToDbScreen
        highlighted: stackView.currentItem === dbScreen
    }

    Button {
        id: button2
        x: 43
        y: 528
        width: 244
        height: 100
        text: qsTr("Настройки")
        onClicked: rectangle.goToSettingsScreen = !rectangle.goToSettingsScreen
        highlighted: stackView.currentItem === settingsScreen
    }

    Rectangle {
        id: rectangle2
        x: 377
        y: 98
        width: 1217
        height: 96
        color: "#ffffff"
        radius: 20
        Text {
            id: label
            x: 0
            y: 24
            text: qsTr("База комплектующих")
            anchors.topMargin: 45
            horizontalAlignment: Text.AlignLeft
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
            anchors.horizontalCenterOffset: -397
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
