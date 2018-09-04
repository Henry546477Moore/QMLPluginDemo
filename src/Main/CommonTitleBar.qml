import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.3
import QtQuick.Layouts 1.3

Rectangle {
    id:root
    property bool  isMax: false     //标题栏最大化(还原)
    property string title: "自定义窗体"   //标题栏
    color: "transparent"
    property bool isLogin: true

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

    ImageButton {
            id:minBtn
            anchors.right: maxBtn.left

            picHover: "qrc:/images/min_hover.png"
            picNormal: "qrc:/images/min_normal.png"
            picPressed: "qrc:/images/min_pressed.png"

            onClicked: mainWindow.showMinimized()
        }


    ImageButton {
        id:maxBtn
        anchors.topMargin: 14
        anchors.right: closeBtn.left
        anchors.rightMargin: 2
        anchors.verticalCenter: parent.verticalCenter
        width: 27
        height: 22

        picHover: "qrc:/images/max_hover.png"
        picNormal: "qrc:/images/max_normal.png"
        picPressed: "qrc:/images/max_pressed.png"

        onClicked: root.maxUndoFun()
    }

    ImageButton {
        id:closeBtn
        anchors.right: parent.right
        anchors.rightMargin: 2

        picHover: "qrc:/images/close_hover.png"
        picNormal: "qrc:/images/close_normal.png"
        picPressed: "qrc:/images/close_pressed.png"

        onClicked: Qt.quit()
    }

    //最大化(还原)
    function maxUndoFun(){
        if(isMax)
        {
            mainWindow.showNormal()

            maxBtn.picHover = "qrc:/images/max_hover.png"
            maxBtn.picNormal = "qrc:/images/max_normal.png"
            maxBtn.picPressed = "qrc:/images/max_pressed.png"
        }
        else
        {
            mainWindow.showMaximized()

            maxBtn.picHover = "qrc:/images/restore_hover.png"
            maxBtn.picNormal = "qrc:/images/restore_normal.png"
            maxBtn.picPressed = "qrc:/images/restore_pressed.png"
        }
        isMax = !isMax
    }
}

