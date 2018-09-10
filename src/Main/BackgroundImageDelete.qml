import QtQuick 2.11

Item {
    width: 150
    height: 120

    Rectangle {
        width: 140
        height: 110
        border.color: "white"
        border.width: 0.5
        Image{
            width: parent.width - 2
            height: parent.height - 2
            anchors.centerIn: parent
            source: model.modelData
        }

        MouseArea {
            hoverEnabled: true
            anchors.fill: parent
            onClicked: appConfig.setBackgroundSource(true, model.modelData)
        }
    }
}
