import QtQuick 2.11

Item {
    width: 150
    height: 120

    Rectangle {
        id: imgRect
        visible: model.modelData.isImgSource
        width: 135
        height: 110
        border.color: "white"
        border.width: 0.5
        anchors.centerIn: parent
        Image{
            width: parent.width - 2
            height: parent.height - 2
            anchors.centerIn: parent
            source: model.modelData.source
        }

    }

    Rectangle{
        id: colorRect
        visible: !model.modelData.isImgSource
        width: 135
        height: 110
        border.color: "white"
        border.width: 0.5
        anchors.centerIn: parent
        color: model.modelData.source
    }

    MouseArea {
        hoverEnabled: true
        anchors.fill: parent
        onClicked: appConfig.setBackgroundSource(model.modelData)
    }
}
