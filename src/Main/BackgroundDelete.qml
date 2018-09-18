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
            width: parent.width
            height: parent.height
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

    Rectangle {
        id: rect
        width: 135
        height: 110
        color: "#00000000"
        anchors.centerIn: parent
    }

    MouseArea {
        hoverEnabled: true
        anchors.fill: parent
        onClicked: appConfig.setBackgroundSource(model.modelData)
        onEntered: rect.color = "#33000000"
//        onReleased: borderWidth = 0
//        onPressed: borderWidth = 0.5
        onExited: rect.color = "#00000000"
    }
}
