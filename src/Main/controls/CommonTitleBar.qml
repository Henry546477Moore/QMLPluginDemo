import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.3
import QtQuick.Layouts 1.3

Rectangle {
    id:root
    property bool  isMax: false
    property alias showMinBtn: minBtn.visible
    property alias showMaxBtn: maxBtn.visible
    property string title: ""
    color: "transparent"

    signal closed

    Text {
        id: cusTitle
        anchors.left: parent.left
        anchors.leftMargin: 15
        anchors.verticalCenter: parent.verticalCenter
        color: "white"
        font.pixelSize: 18
        font.bold: true

        text: root.title
    }

    FontButton {
            id:minBtn
            anchors.right: maxBtn.left

            width: 32
            height: 32

            text: "\uf2d1"
            bgcolorNormal: "transparent"
            bgcolorHover: "#aaa"
            bgcolorPressed: "#aaa"

            onClicked: mainWindow.showMinimized()
        }


    FontButton {
        id:maxBtn
        anchors.topMargin: 14
        anchors.right: closeBtn.left
        anchors.rightMargin: 2
        anchors.verticalCenter: parent.verticalCenter
        width: 32
        height: 32

        text: "\uf2d0"
        bgcolorNormal: "transparent"
        bgcolorHover: "#aaa"
        bgcolorPressed: "#aaa"

        onClicked: root.maxUndoFun()
    }

    FontButton {
        id:closeBtn
        anchors.right: parent.right
        anchors.rightMargin: 2

        width: 32
        height: 32

        text: "\uf2d4"
        bgcolorNormal: "transparent"
        bgcolorHover: "red"
        bgcolorPressed: "red"

        onClicked: root.closed()
    }

    //最大化(还原)
    function maxUndoFun(){
        if(isMax)
        {
            mainWindow.showNormal()

            maxBtn.text = "\uf2d2"
        }
        else
        {
            mainWindow.showMaximized()

            maxBtn.text = "\uf2d0"
        }
        isMax = !isMax
    }
}
