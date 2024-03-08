import QtQuick 6.2
import QtQuick.Controls 2.15
import QtQuick.LocalStorage 2.15
import QtQuick.Layouts 1.15
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
            }
        }
        onGoToDbScreenChanged: {
            if (goToDbScreen){
                stackView.replace(dbScreen);
            }
        }

        onGoToDarkmodeChanged: {
            if (goToDarkmode) {
                settingsScreen.color = "#292626";
                settingsScreen.rectangle2.color = "#3f3c3c";
            } else {
                settingsScreen.color = "#eaeaea";
                settingsScreen.rectangle2.color = "#ffffff";
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
        mainScreen.gpuInfoText.text = sysInfo.getGpuInfo();

        mainScreen.diskInfoField.text = sysInfo.getDiskInfo();
        mainScreen.diskInfoText.text = sysInfo.getDiskInfo();

        mainScreen.cpuInfoField.text = sysInfo.getProcessorInfo();
        mainScreen.cpuInfoText.text = sysInfo.getProcessorInfo();

        mainScreen.motherboardInfoField.text = sysInfo.getMotherboardInfo();
        mainScreen.motherboardInfoText.text = sysInfo.getMotherboardInfo();

        mainScreen.osInfoField.text = sysInfo.getOSInfo();
        mainScreen.osInfoText.text = sysInfo.getOSInfo();

        mainScreen.ramInfoField.text = sysInfo.getRAMInfo();
        mainScreen.ramInfoText.text = sysInfo.getRAMInfo();
        
        mainScreen.text2.color = "#cb1b1b";
    }
}
