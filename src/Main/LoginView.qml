import QtQuick 2.11
import QtQuick.Controls 2.3
import QtQuick.Window 2.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtQuick.Dialogs 1.2
import com.henrymoore 1.0
import Qt.labs.platform 1.0
import "controls" as MyControls

ApplicationWindow {
    id:loginView
    width: 400
    height: 300
    visible: true
    flags: Qt.FramelessWindowHint | Qt.Window

    SystemConfigInfo{
        id: appConfig
        onCurrentLanguageChanged: translator()
    }

    Rectangle {
        id: bgRect
        anchors.fill: parent
        visible: !appConfig.isUseBackgroundImg
        color: bgRect.visible ? appConfig.backgroundSource : ""
    }

    Image {
        id: image
        anchors.fill: parent
        source: appConfig.isUseBackgroundImg ? appConfig.backgroundSource : ""
        fillMode: Image.PreserveAspectCrop
        visible: false
    }

    Rectangle {
        id: mask
        color: "transparent"
        anchors.fill: parent
        Rectangle {
           anchors.fill: parent
           radius: 1
           color: "black"
        }
        visible: false
    }

    OpacityMask {
        id: imgMask
        anchors.fill: image
        source: image
        maskSource: mask
        visible: appConfig.isUseBackgroundImg
    }

    MouseArea{
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton
        property point cliCkPos: "0,0"
        onPressed: {
            cliCkPos = Qt.point(mouse.x, mouse.y)
        }
        onPositionChanged: {
            var delta = Qt.point(mouse.x - cliCkPos.x, mouse.y - cliCkPos.y)
            loginView.x = (loginView.x + delta.x)
            loginView.y = (loginView.y + delta.y)
        }
    }

    MyControls.CommonTitleBar {
        id: titleBar
        width: parent.width
        height: 32
        showMinBtn: false
        showMaxBtn: false

        onClosed: Qt.quit()
    }

    Rectangle {
        id: contentBackground
        anchors.top: titleBar.bottom
        width: parent.width
        height: parent.height - titleBar.height
        color: "white"
        opacity: 0.6
    }

    Label {
        id: lblTitle
        font.bold: true
        font.pixelSize: 26
        height: 40
        color: "white"
        anchors.top: titleBar.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: 20
    }

    TextField {
        id: txtUserName
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: lblTitle.bottom
        font.pixelSize: 14
        color: "#00a5f7"
        width: 250
        height: 30
    }

    TextField {
        id: txtPwd
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: txtUserName.bottom
        echoMode: TextInput.Password
        font.pixelSize: 14
        color: "#00a5f7"
        width: 250
        height: 30
        anchors.topMargin: 10
    }

    CheckBox {
        id: cbRemberPwd
        anchors.top: txtPwd.bottom
        anchors.left: parent.left
        anchors.leftMargin: 70
        anchors.rightMargin: 10
        anchors.topMargin: 15
    }

    CheckBox {
        id: cbAutoLogin
        anchors.top: txtPwd.bottom
        anchors.left: cbRemberPwd.right
        anchors.topMargin: 15
    }

    MyControls.CommonButton {
        id: btnLogin
        width: 250
        height: 30
        anchors.top: cbRemberPwd.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: {
            messageDialog.title = qsTr("Prompt")
            messageDialog.text = qsTr("Password invalid!")
            messageDialog.open()
            console.debug("dd")
        }
    }

    MessageDialog {
          id: messageDialog
          onAccepted: {
              messageDialog.close()
          }
          Component.onCompleted: visible = true
      }

    function translator() {
        titleBar.title = appConfig.appTitle
        lblTitle.text = qsTr("Welcome")
        txtUserName.placeholderText = qsTr("User Name")
        txtPwd.placeholderText = qsTr("Password")
        cbRemberPwd.text = qsTr("Rember password")
        cbAutoLogin.text = qsTr("Auto login")
        btnLogin.text = qsTr("Safe login")
        btnLogin.toolTip = qsTr("Click to safe login system")
    }
}
