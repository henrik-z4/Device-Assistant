import QtQuick 6.2
import QtQuick.Controls 2.15
import QtQuick.LocalStorage 2.15
import QtQuick.Layouts 1.15
import Device_Assistant
import GPT 1.0

Window {
    width: Screen.desktopAvailableWidth
    height: Screen.desktopAvailableHeight
    visible: true
    title: "DeviceAssistant"
    visibility: Window.FullScreen

    Screen01 {
        id: mainScreen

        onGoToMainScreenChanged: {
            if (goToMainScreen) {
                stackView.replace(mainScreen);
                goToMainScreen = false;
            }
        }

        onGoToAIScreenChanged: {
            if (goToAIScreen) {
                stackView.replace(aiScreen);
                goToAIScreen = false;
            }
        }

        onGoToSettingsScreenChanged: {
            if (goToSettingsScreen) {
                stackView.replace(settingsScreen);
                goToSettingsScreen = false;
            }
        }

    }

    Screen02 {
        id: aiScreen

        onGoToMainScreenChanged: {
            if (goToMainScreen) {
                stackView.replace(mainScreen);
                goToMainScreen = false;
            }
        }

        onGoToAIScreenChanged: {
            if (goToAIScreen) {
                stackView.replace(aiScreen);
                goToAIScreen = false;
            }
        }

        onGoToSettingsScreenChanged: {
            if (goToSettingsScreen) {
                stackView.replace(settingsScreen);
                goToSettingsScreen = false;
            }
        }

        onExecuteReconnectivityChanged: {
            if (executeReconnectivity) {
                aiScreen.text2.text = sysInfo.getConnectionInfo();

                if(sysInfo.getConnectionInfo() == "Интернет соединение установлено") {
                    aiScreen.connectivityIndicator.color = "#4dea15";
                }
                else {
                    aiScreen.connectivityIndicator.color = "#e82525";
                }

                executeReconnectivity = false;
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


        ListModel {
            id: gpuListModel
        }


    Screen04 {
        id: settingsScreen

        onGoToMainScreenChanged: {
            if (goToMainScreen) {
                stackView.replace(mainScreen);
            }
        }

        onGoToAIScreenChanged: {
            if (goToAIScreen) {
                stackView.replace(aiScreen);
                aiScreen.text3.color = "#0d53fd";
            }
        }

        onGoToSettingsScreenChanged: {
            if (goToSettingsScreen) {
                stackView.replace(settingsScreen);
                settingsScreen.text5.color = "#ddf107";
            }
        }

        onGoToDarkmodeChanged: {
            if (goToDarkmode) {
                settingsScreen.color = "#2e2e2e";
                settingsScreen.text1.color = "#ffffff";
                settingsScreen.text6.color = "#ffffff";
                settingsScreen.text8.color = "#ffffff";
                settingsScreen.text111.color = "#ffffff";



                aiScreen.color = "#2e2e2e";
                aiScreen.rectangle1.color = "#2e2e2e";
                aiScreen.text1.color = "#ffffff";
                aiScreen.text2.color = "#ffffff";
                aiScreen.text7.color = "#ffffff";
                aiScreen.text8.color = "#ffffff";
                aiScreen.messageField.placeholderText.color = "#60000000";



                mainScreen.color = "#2e2e2e";
                mainScreen.rectangle1.color = "#2e2e2e";
                mainScreen.rectangle2.color = "#2e2e2e";
                mainScreen.rectangle3.color = "#2e2e2e";
                mainScreen.rectangle4.color = "#2e2e2e";
                mainScreen.rectangle5.color = "#2e2e2e";
                mainScreen.rectangle6.color = "#2e2e2e";
                mainScreen.rectangle7.color = "#2e2e2e";
                mainScreen.rectangle8.color = "#2e2e2e";
                
                mainScreen.text1.color = "#ffffff";
                mainScreen.text6.color = "#ffffff";
                mainScreen.text8.color = "#ffffff";

                mainScreen.recommendations.color = "#ffffff";

                mainScreen.cpuText.color = "#ffffff";
                mainScreen.cpuInfoText.color = "#ffffff";

                mainScreen.gpuText.color = "#ffffff";
                mainScreen.gpuInfoText.color = "#ffffff";

                mainScreen.diskText.color = "#ffffff";
                mainScreen.diskInfoText.color = "#ffffff";

                mainScreen.ramText.color = "#ffffff";
                mainScreen.ramInfoText.color = "#ffffff";

                mainScreen.motherboardText.color = "#ffffff";
                mainScreen.motherboardInfoText.color = "#ffffff";

                mainScreen.osText.color = "#ffffff";
                mainScreen.osInfoText.color = "#ffffff";
            } else {
                settingsScreen.color = "#ffffff";
                settingsScreen.text1.color = "#000000";
                settingsScreen.text6.color = "#000000";
                settingsScreen.text8.color = "#000000";
                settingsScreen.text111.color = "#00000";



                aiScreen.color = "#ffffff";
                aiScreen.rectangle1.color = "#ffffff";
                aiScreen.text1.color = "#000000";
                aiScreen.text2.color = "#000000";
                aiScreen.text7.color = "#000000";
                aiScreen.text8.color = "#000000";
                aiScreen.messageField.placeholderText.color = "#000000";



                mainScreen.color = "#ffffff";
                mainScreen.rectangle1.color = "#ffffff";
                mainScreen.rectangle2.color = "#ffffff";
                mainScreen.rectangle3.color = "#ffffff";
                mainScreen.rectangle4.color = "#ffffff";
                mainScreen.rectangle5.color = "#ffffff";
                mainScreen.rectangle6.color = "#ffffff";
                mainScreen.rectangle7.color = "#ffffff";
                mainScreen.rectangle8.color = "#ffffff";

                mainScreen.text1.color = "#000000";
                mainScreen.text6.color = "#000000";
                mainScreen.text8.color = "#000000";

                mainScreen.recommendations.color = "#000000";

                mainScreen.cpuText.color = "#000000";
                mainScreen.cpuInfoText.color = "#000000";

                mainScreen.gpuText.color = "#000000";
                mainScreen.gpuInfoText.color = "#000000";

                mainScreen.diskText.color = "#000000";
                mainScreen.diskInfoText.color =  "#000000";

                mainScreen.ramText.color = "#000000";
                mainScreen.ramInfoText.color = "#000000";

                mainScreen.motherboardText.color = "#000000";
                mainScreen.motherboardInfoText.color = "#000000";

                mainScreen.osText.color = "#000000";
                mainScreen.osInfoText.color = "#000000";
            }
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: mainScreen
    }

    Component.onCompleted: {
        mainScreen.gpuInfoText.text = sysInfo.getGpuInfo();
        mainScreen.diskInfoText.text = sysInfo.getDiskInfo();
        mainScreen.cpuInfoText.text = sysInfo.getProcessorInfo();
        mainScreen.motherboardInfoText.text = sysInfo.getMotherboardInfo();
        mainScreen.osInfoText.text = sysInfo.getOSInfo();
        mainScreen.ramInfoText.text = sysInfo.getRAMInfo();
        aiScreen.text2.text = sysInfo.getConnectionInfo();
        mainScreen.recommendations.text = gpt.getRecommendations();

        if(sysInfo.getConnectionInfo() == "Интернет соединение установлено") {
            aiScreen.connectivityIndicator.color = "#4dea15";
        }
        else {
            aiScreen.connectivityIndicator.color = "#e82525";
        }
    }
}
