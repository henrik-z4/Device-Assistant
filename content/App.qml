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

        onGoToSettingsScreenChanged: {
            if (goToSettingsScreen) {
                stackView.replace(settingsScreen);
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

        onGoToSettingsScreenChanged: {
            if (goToSettingsScreen) {
                stackView.replace(settingsScreen);
            }
        }

        GPT {
            id: gpt
        }

        Component.onCompleted: {
            aiScreen.sendButton.clicked.connect(function() {
                if (aiScreen.messageField.text !== "") {
                    aiScreen.chatModel.append({message: "Вы: " + aiScreen.messageField.text});
                    var response = gpt.getResponse(aiScreen.messageField.text);
                    aiScreen.chatModel.append({message: "GPT-4: " + response});
                    aiScreen.messageField.text = "";
                }
            });
        }

    }

    Screen03 {
        id: settingsScreen

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

        onGoToSettingsScreenChanged: {
            if (goToSettingsScreen) {
                stackView.replace(settingsScreen);
            }
        }

        onGoToDarkmodeChanged: {
            if (goToDarkmode) {
                settingsScreen.color = "#292626";
                settingsScreen.rectangle2.color = "#3f3c3c";
                settingsScreen.label.color = "#ffffff";

                aiScreen.color = "#292626";
                aiScreen.rectangle2.color = "#3f3c3c";
                aiScreen.label.color = "#ffffff";
                aiScreen.messageField.placeholderTextColor = "#ffffff";

                mainScreen.color = "#292626";
                mainScreen.rectangle1.color = "#3f3c3c";
                mainScreen.rectangle2.color = "#3f3c3c";
                mainScreen.label.color = "#ffffff";
                mainScreen.text1.color = "#ffffff";

                mainScreen.gpuInfoField.color = "#ffffff";
                mainScreen.diskInfoField.color = "#ffffff";
                mainScreen.motherboardInfoField.color = "#ffffff";
                mainScreen.cpuInfoField.color = "#ffffff";
                mainScreen.osInfoField.color = "#ffffff";
                mainScreen.ramInfoField.color = "#ffffff";
                mainScreen.pcNameField.color = "#ffffff"
                mainScreen.displayRefreshRateField.color = "#ffffff"
            } else {
                settingsScreen.color = "#eaeaea";
                settingsScreen.rectangle2.color = "#ffffff";
                settingsScreen.label.color = "#000000";

                aiScreen.color = "#eaeaea";
                aiScreen.rectangle2.color = "#ffffff";
                aiScreen.label.color = "#000000";
                aiScreen.messageField.placeholderTextColor = "#000000";

                mainScreen.color = "#eaeaea";
                mainScreen.rectangle1.color = "#ffffff";
                mainScreen.rectangle2.color = "#ffffff";
                mainScreen.label.color = "#000000";
                mainScreen.text1.color = "#000000";

                mainScreen.gpuInfoField.color = "#000000";
                mainScreen.diskInfoField.color = "#000000";
                mainScreen.motherboardInfoField.color = "#000000";
                mainScreen.cpuInfoField.color = "#000000";
                mainScreen.osInfoField.color = "#000000";
                mainScreen.ramInfoField.color = "#000000";
                mainScreen.pcNameField.color = "#000000"
                mainScreen.displayRefreshRateField.color = "#000000"
            }
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: mainScreen
    }

}

