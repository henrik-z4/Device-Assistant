import QtQuick 6.2
import QtQuick.Controls 2.15
import Device_Assistant

Window {
    width: mainScreen.width
    height: mainScreen.height

    visible: true
    title: "Device_Assistant"

    Screen01 {
        id: mainScreen
        onGoToMainScreenChanged: {
            if (goToMainScreen) {
                stackView.replace(mainScreen);
            }
        }
        onGoToAIScreenChanged: {
            if (goToAIScreen) {
                stackView.replace(aiScreen);
            }
        }
    }

    Screen02 {
        id: aiScreen
        onGoToMainScreenChanged: {
            if (goToMainScreen) {
                stackView.replace(mainScreen);
            }
        }
        onGoToAIScreenChanged: {
            if (goToAIScreen) {
                stackView.replace(aiScreen);
            }
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: mainScreen
    }

    Component.onCompleted: {
        mainScreen.gpuInfoField.text = sysInfo.getGpuInfo();
        mainScreen.diskInfoField.text = sysInfo.getDiskInfo();
        mainScreen.cpuInfoField.text = sysInfo.getProcessorInfo();
        mainScreen.motherboardInfoField.text = sysInfo.getMotherboardInfo();
        mainScreen.osInfoField.text = sysInfo.getOSInfo();
        mainScreen.ramInfoField.text = sysInfo.getRAMInfo();
    }
}