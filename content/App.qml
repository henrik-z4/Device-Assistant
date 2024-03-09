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
                mainScreen.text2.color = "#cb1b1b";
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

        onGoToDbScreenChanged: {
            if (goToDbScreen){
                stackView.replace(dbScreen);
            }
        }
    }

    Screen02 {
        id: aiScreen

        onGoToMainScreenChanged: {
            if (goToMainScreen) {
                stackView.replace(mainScreen);
                mainScreen.text2.color = "#cb1b1b";
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

        onGoToDbScreenChanged: {
            if (goToDbScreen){
                stackView.replace(dbScreen);
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
        id: dbScreen
        onGoToMainScreenChanged: {
            if (goToMainScreen) {
                stackView.replace(mainScreen);
                mainScreen.text2.color = "#cb1b1b";
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

        onGoToDbScreenChanged: {
            if (goToDbScreen){
                stackView.replace(dbScreen);
            }
        }

        ListModel {
            id: gpuListModel
        }

        Component.onCompleted: {
            var dbPath = applicationDirPath + "/data/gpu_database.db";
            console.log("Database path: " + dbPath);
            var db = LocalStorage.openDatabaseSync(dbPath, "", "GPU Database", 1000000);
            if (db) {
                console.log("Database opened successfully");
            } else {
                console.log("Failed to open database");
            }
            db.transaction(function(tx) {
                var results = tx.executeSql('SELECT * FROM gpu');
                if (tx.lastError) {
                    console.log("SQL error: " + tx.lastError.message);
                } else {
                    console.log("Number of rows returned by SELECT query: " + results.rows.length);
                    for (var i = 0; i < results.rows.length; i++) {
                        console.log("Row " + i + ": " + JSON.stringify(results.rows.item(i)));
                        gpuListModel.append(results.rows.item(i));
                    }
                }
            });
        }

        onCurrentTabChanged: {
            switch (dbScreen.currentTab) {
                case 0: stackView.push("GpuList.qml"); break;
                // Сделать все остальные
                default: break;
        }

    }
}

    Screen04 {
        id: settingsScreen

        onGoToMainScreenChanged: {
            if (goToMainScreen) {
                stackView.replace(mainScreen);
                mainScreen.text2.color = "#cb1b1b";
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
        onGoToDbScreenChanged: {
            if (goToDbScreen){
                stackView.replace(dbScreen);
            }
        }

        onGoToDarkmodeChanged: {
            if (goToDarkmode) {
                settingsScreen.color = "#2e2e2e";
                settingsScreen.text1.color = "#ffffff";
                settingsScreen.text2.color = "#ffffff";
                settingsScreen.text3.color = "#ffffff";
                settingsScreen.text4.color = "#ffffff";
                settingsScreen.text6.color = "#ffffff";
                settingsScreen.text8.color = "#ffffff";

                aiScreen.color = "#2e2e2e";
                aiScreen.rectangle1.color = "#2e2e2e";
                aiScreen.text1.color = "#ffffff";
                aiScreen.text2.color = "#ffffff";
                aiScreen.text4.color = "#ffffff";
                aiScreen.text5.color = "#ffffff";
                aiScreen.text7.color = "#ffffff";
                aiScreen.text8.color = "#ffffff";
                aiScreen.text10.color = "#ffffff";
                aiScreen.messageField.placeholderText.color = "#60000000";
            } else {
                settingsScreen.color = "#ffffff";
                settingsScreen.text1.color = "#000000";
                settingsScreen.text2.color = "#000000";
                settingsScreen.text3.color = "#000000";
                settingsScreen.text4.color = "#000000";
                settingsScreen.text6.color = "#000000";
                settingsScreen.text8.color = "#000000";

                aiScreen.color = "#ffffff";
                aiScreen.rectangle1.color = "#ffffff";
                aiScreen.text1.color = "#000000";
                aiScreen.text2.color = "#000000";
                aiScreen.text4.color = "#000000";
                aiScreen.text5.color = "#000000";
                aiScreen.text7.color = "#000000";
                aiScreen.text8.color = "#000000";
                aiScreen.text10.color = "#000000";
                aiScreen.messageField.placeholderText.color = "#000000";
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
        
        mainScreen.text2.color = "#cb1b1b";
    }
}
