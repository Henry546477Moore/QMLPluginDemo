import QtQuick 2.11
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Item {
    width: 150
    height: 120

    Rectangle{
        id: colorRect
        width: 135
        height: 110
        border.color: "white"
        border.width: 0.5
        anchors.centerIn: parent
        color: model.modelData

        MouseArea {
            hoverEnabled: true
            anchors.fill: parent
            onClicked: appConfig.setBackgroundSource(false, model.modelData)
        }
    }
}
