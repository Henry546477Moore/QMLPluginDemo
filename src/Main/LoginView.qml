import QtQuick 2.11
import QtQuick.Controls 2.2
import QtQuick.Window 2.3
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtQuick.Dialogs 1.2
import com.henrymoore 1.0
import Qt.labs.platform 1.0
import "controls" as MyControls

ApplicationWindow {
    id:loginView
    width: 600
    height: 500
    visible: true
    color: "transparent"
    flags: Qt.FramelessWindowHint | Qt.Window

    SystemConfigInfo{
        id: appConfig
    }


    Image {
        id: image
        anchors.fill: parent
        source: "qrc:/images/loginbg.png"
        fillMode: Image.PreserveAspectCrop
        visible: true
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



    Item {
        id: contentItem
        anchors.fill: parent

        MyControls.FontButton {
            id:closeBtn
            anchors.top: parent.top
            anchors.right: parent.right

            width: 40
            height: 25

            text: "\uf2d4"
            bgcolorHover: "red"

            onClicked: loginView.close()
        }


        Label {
            id: lblTitleTop
            font.bold: true
            font.pixelSize: 26
            height: 40
            color: "black"
            anchors.top: parent.top
            anchors.topMargin: 40
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Label {
            id: lblTitleLeft
            font.bold: true
            font.pixelSize: 26
            height: 40
            color: "black"
            text: loginView.title
            anchors.left: parent.left
            anchors.leftMargin: 40
            anchors.top: parent.top
            anchors.topMargin: 110
        }

        TextField {
            id: txtUserName
            anchors.right: contentItem.right
            anchors.rightMargin: 100
            anchors.top: lblTitleTop.bottom
            anchors.topMargin: 35
            font.pixelSize: 14
            color: "#00a5f7"
            width: 250
            height: 40
            focus: true
        }

        TextField {
            id: txtPwd
            anchors.right: contentItem.right
            anchors.rightMargin: 100
            anchors.top: txtUserName.bottom
            anchors.topMargin: 20
            echoMode: TextInput.Password
            font.pixelSize: 14
            color: "#00a5f7"
            width: 250
            height: 40
        }

        Loader {
            id: myLoader
        }

        MyControls.CommonButton {
            id: btnLogin
            width: 250
            height: 40
            anchors.top: txtPwd.bottom
            anchors.topMargin: 20
            anchors.right: contentItem.right
            anchors.rightMargin: 100
            font.pixelSize: 17
            onClicked: {
                contentItem.invalidUser()
            }
        }

        Keys.onPressed: {
            if(event.key == Qt.Key_Enter
               || event.key == Qt.Key_Return) {
                contentItem.invalidUser()
                event.accepted = true
            }
        }

        Keys.onEscapePressed: Qt.quit()

        MyControls.MyMessageBox {
            id: msgDlg
        }

        Component.onCompleted: {
            txtUserName.focus = true
            translator()
        }

        function translator() {
            lblTitleTop.text = title = appConfig.appTitle
            lblTitleLeft.text = qsTr("Welcome")
            txtUserName.placeholderText = qsTr("User Name")
            txtPwd.placeholderText = qsTr("Password")
            btnLogin.text = qsTr("Safe login")
        }

        function invalidUser() {
            if(appConfig.invalidUser(txtUserName.text, txtPwd.text)) {
                console.debug("invalid user ok")
                myLoader.source = "main.qml"
                loginView.visible = false
            }
            else {
                msgDlg.tipText = qsTr("Please input right user name and password!")
                msgDlg.openMsg()
            }
        }
    }
}
