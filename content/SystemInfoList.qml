import QtQuick 6.2
import QtQuick.Controls 2.15
import Device_Assistant

GridView {
    id: systemInfoList
    property var systemInfo: []
    width: parent.width
    height: parent.height
    cellWidth: 300 + 20
    cellHeight: 70 + 20
    model: systemInfo
    delegate: Item {
        width: systemInfoList.cellWidth
        height: systemInfoList.cellHeight
        Column {
            anchors.centerIn: parent
            Label {
                text: modelData.label
            }
            TextArea {
                width: 300
                height: 70
                enabled: false
                text: modelData.info
            }
        }
    }
    Component.onCompleted: {
        var gpuInfo = sysInfo.getGpuInfo();
        for (var i = 0; i < gpuInfo.length; i++) {
            systemInfoList.systemInfo.push({label: "Видеокарта", info: gpuInfo[i]});
        }

        var diskInfo = sysInfo.getDiskInfo();
        systemInfoList.systemInfo.push({label: "Носитель", info: diskInfo});

        var processorInfo = sysInfo.getProcessorInfo();
        systemInfoList.systemInfo.push({label: "Процессор", info: processorInfo});

        var motherboardInfo = sysInfo.getMotherboardInfo();
        systemInfoList.systemInfo.push({label: "Материнская плата", info: motherboardInfo});

        var osInfo = sysInfo.getOSInfo();
        systemInfoList.systemInfo.push({label: "ОС", info: osInfo});

        var ramInfo = sysInfo.getRAMInfo();
        systemInfoList.systemInfo.push({label: "ОЗУ", info: ramInfo});

        var pcName = sysInfo.getPcName();
        systemInfoList.systemInfo.push({label: "Имя ПК", info: pcName});

        var displayRefreshRate = sysInfo.getDisplayRefreshRate();
        systemInfoList.systemInfo.push({label: "Частота обновления дисплея", info: displayRefreshRate});

        systemInfoList.systemInfo = systemInfoList.systemInfo;
    }
}