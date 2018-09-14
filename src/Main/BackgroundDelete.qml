import QtQuick 2.11

Item {
    width: 150
    height: 120
    property int borderWidth: 0

    Rectangle {
        id: imgRect
        visible: model.modelData.isImgSource
        width: 135
        height: 110
        border.color: "white"
        border.width: borderWidth
        anchors.centerIn: parent
        Image{
            width: parent.width - 2
            height: parent.height - 2
            anchors.centerIn: parent
            source: imgRect.visible ? model.modelData.source : ""
        }

    }

    Rectangle{
        id: colorRect
        visible: !model.modelData.isImgSource
        width: 135
        height: 110
        border.color: "white"
        border.width: borderWidth
        anchors.centerIn: parent
        color: colorRect.visible ? model.modelData.source : ""
    }

    MouseArea {
        hoverEnabled: true
        anchors.fill: parent
        onClicked: appConfig.setBackgroundSource(model.modelData)
        onEntered: borderWidth = 0.5
        onReleased: borderWidth = 0
        onPressed: borderWidth = 0.5
        onExited: borderWidth = 0
    }
}
