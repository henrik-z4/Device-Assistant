import QtQuick 6.2
import QtQuick.Controls 2.15
import Device_Assistant

ListView {
    id: gpuListView
    anchors.fill: parent
    model: gpuListModel

    delegate: Text {
        text: model.name + ": " + model.price
    }
}