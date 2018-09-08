import QtQuick 2.11

Item {
    width: 150
    height: 120

    Rectangle{
        width: 140
        height: 110
        border.color: "white"
        border.width: 0.5
        anchors.centerIn: parent
        color: model.modelData
    }
}
