import QtQuick 2.11
import QtQuick.Controls 2.3
import QtQuick.Window 2.3
import QtQuick.Layouts 1.3
import "controls" as MyControls

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

    MyControls.ImageButton {
        id:loginBtn
        anchors.right: loginTip.left

        picNormal: "qrc:/images/loginu_normal.png"
        picHover: "qrc:/images/loginu_hover.png"
        picPressed: "qrc:/images/loginu_pressed.png"

        onClicked: root.loginUndoFun()
    }

    Text {
        id: loginTip
        anchors.right: skinBtn.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: -20
        anchors.rightMargin: 10
        text: qsTr("Please login")
        color: "white"
    }

    MyControls.ImageButton {
        id:skinBtn
        anchors.right: settingBtn.left

        picNormal: "qrc:/images/skin_normal.png"
        picHover: "qrc:/images/skin_hover.png"
        picPressed: "qrc:/images/skin_pressed.png"

        onClicked: skinPopup.open()
    }
    MyControls.ImageButton {
        id:settingBtn
        anchors.right: minBtn.left

        picNormal: "qrc:/images/menu_normal.png"
        picHover: "qrc:/images/menu_hover.png"
        picPressed: "qrc:/images/menu_pressed.png"

        onClicked: settingMenu.popup()
    }


    MyControls.FontButton {
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


    MyControls.FontButton {
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

    MyControls.FontButton {
        id:closeBtn
        anchors.right: parent.right
        anchors.rightMargin: 2

        width: 32
        height: 32

        text: "\uf2d4"
        bgcolorNormal: "transparent"
        bgcolorHover: "red"
        bgcolorPressed: "red"

        onClicked: {
            mainWindow.showMinimized()
            mainWindow.hide()
            myTrayIcon.showMessage(title, qsTr("Click here to show main window!"))
        }
    }

    Menu {
        id: settingMenu

        Action {
            text: qsTr("English")
            checkable: true
            checked: "en_US" == appConfig.currentLanguage
            onTriggered: appConfig.setCurrentLanguage("en_US")
        }
        Action {
            text: qsTr("Chinese")
            checkable: true
            checked: "zh_CN" == appConfig.currentLanguage
            onTriggered: appConfig.setCurrentLanguage("zh_CN")
        }

        topPadding: 2
        bottomPadding: 2

        delegate: MenuItem {
            id: menuItem
            implicitWidth: 120
            implicitHeight: 30

            arrow: Canvas {
                x: parent.width - width
                implicitWidth: 30
                implicitHeight: 30
                visible: menuItem.subMenu
                onPaint: {
                    var ctx = getContext("2d")
                    ctx.fillStyle = menuItem.highlighted ? "#ffffff" : "#21be2b"
                    ctx.moveTo(10, 10)
                    ctx.lineTo(width - 10, height / 2)
                    ctx.lineTo(10, height - 10)
                    ctx.closePath()
                    ctx.fill()
                }
            }

            indicator: Item {
                implicitWidth: 30
                implicitHeight: 30
                Rectangle {
                    width: 20
                    height: 20
                    anchors.centerIn: parent
                    visible: menuItem.checkable
                    border.color: "#21be2b"
                    radius: 3
                    Rectangle {
                        width: 10
                        height: 10
                        anchors.centerIn: parent
                        visible: menuItem.checked
                        color: "#21be2b"
                        radius: 2
                    }
                }
            }

            contentItem: Text {
                leftPadding: menuItem.indicator.width
                rightPadding: menuItem.arrow.width
                text: menuItem.text
                font: menuItem.font
                opacity: enabled ? 1.0 : 0.3
                color: menuItem.highlighted ? "#ffffff" : "#21be2b"
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                implicitWidth: 120
                implicitHeight: 30
                opacity: enabled ? 1 : 0.3
                color: menuItem.highlighted ? "#21be2b" : "transparent"
            }
        }

        background: Rectangle {
            implicitWidth: 120
            implicitHeight: 30
            color: "#ffffff"
            border.color: "#21be2b"
            radius: 2
        }
    }

    Popup
        {
            id:skinPopup
            contentWidth: bgMrg.implicitWidth
            contentHeight: bgMrg.implicitHeight
            x:(mainWindow.width - bgMrg.width) / 2
            y:(mainWindow.height - bgMrg.height) / 2
            opacity: 0.8
            modal: true
            focus: true
            closePolicy: Popup.NoAutoClose

            BackgroundMrgView {
                id: bgMrg
                onClosed: skinPopup.close()
            }
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
            loginTip.text = qsTr("Please login")
            loginBtn.picHover = "qrc:/images/loginu_hover.png"
            loginBtn.picNormal = "qrc:/images/loginu_normal.png"
            loginBtn.picPressed = "qrc:/images/loginu_pressed.png"
        }
        isLogin = !isLogin
    }
}

