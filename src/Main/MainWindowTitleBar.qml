import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.3
import QtQuick.Layouts 1.3

Rectangle {
    id:root
    //radius: 10
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
        id:loginBtn
        anchors.right: loginTip.left

        picNormal: "qrc:/images/loginu_normal"
        picHover: "qrc:/images/loginu_hover"
        picPressed: "qrc:/images/loginu_pressed"

        onClicked: root.loginUndoFun()
    }

    Text {
        id: loginTip
        anchors.right: skinBtn.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: -20
        anchors.rightMargin: 10
        text: qsTr("请登录")
        color: "white"
    }

    ImageButton {
        id:skinBtn
        anchors.right: settingBtn.left

        picNormal: "qrc:/images/skin_normal.png"
        picHover: "qrc:/images/skin_hover.png"
        picPressed: "qrc:/images/skin_pressed.png"

        onClicked: skinPopup.open()
    }
    ImageButton {
        id:settingBtn
        anchors.right: minBtn.left

        picNormal: "qrc:/images/menu_normal"
        picHover: "qrc:/images/menu_hover"
        picPressed: "qrc:/images/menu_pressed"
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


    Popup
        {
            id:skinPopup
            width: 600
            height: 400
            x:(mainWindow.width-width) / 2
            y:(mainWindow.height-height) / 2
            opacity: 0.8
            modal: true
            focus: true
            closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

            BackgroundMrg {
                onClosed: skinPopup.close()
            }
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

    function loginUndoFun(){
        if(isLogin)
        {
            loginTip.text = qsTr("Admin")
            loginBtn.picHover = "qrc:/images/logout_hover16x16.png"
            loginBtn.picNormal = "qrc:/images/logout_normal16x16.png"
            loginBtn.picPressed = "qrc:/images/logout_pressed16x16.png"
        }
        else
        {
            loginTip.text = qsTr("请“登录")
            loginBtn.picHover = "qrc:/images/loginu_hover.png"
            loginBtn.picNormal = "qrc:/images/loginu_normal.png"
            loginBtn.picPressed = "qrc:/images/loginu_pressed.png"
        }
        isLogin = !isLogin
    }
}

