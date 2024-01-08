import QtQuick 6.2
import QtQuick.Controls 2.15
import Device_Assistant
import GPT 1.0

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

        GPT {
            id: gpt
        }

        Component.onCompleted: {
            aiScreen.sendButton.clicked.connect(function() {
                if (aiScreen.messageField.text !== "") {
                    aiScreen.chatModel.append({message: "User: " + aiScreen.messageField.text});
                    var response = gpt.getResponse(aiScreen.messageField.text);
                    aiScreen.chatModel.append({message: "GPT-4: " + response});
                    aiScreen.messageField.text = "";
                }
            });
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
