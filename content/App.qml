// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

import QtQuick 6.2
import Device_Assistant

Window {
    width: mainScreen.width
    height: mainScreen.height

    visible: true
    title: "Device_Assistant"

    Screen01 {
        id: mainScreen
    }

    Component.onCompleted: {
        mainScreen.gpuInfoField.text = sysInfo.getGpuInfo();
        mainScreen.diskInfoField.text = sysInfo.getDiskInfo();
    }

}

