import QtQuick 2.11
import QtQuick.Controls 2.2
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
    width: 300
    height: 230
    visible: true
    flags: Qt.FramelessWindowHint | Qt.Window

    SystemConfigInfo{
        id: appConfig
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

    MyControls.CustomWindowBase {
        anchors.fill: parent
        title: loginView.title
        showMinBtn: false
        showMaxBtn: false
        onClosed: Qt.quit()

        contentComponent:  Item {
            id: contentItem

            Label {
                id: lblTitle
                font.bold: true
                font.pixelSize: 26
                height: 40
                color: "white"
                anchors.horizontalCenter: contentItem.horizontalCenter
                anchors.top: contentItem.top
                anchors.topMargin: 20
            }

            TextField {
                id: txtUserName
                anchors.horizontalCenter: contentItem.horizontalCenter
                anchors.top: lblTitle.bottom
                font.pixelSize: 14
                color: "#00a5f7"
                width: 250
                height: 30
                focus: true
            }

            TextField {
                id: txtPwd
                anchors.horizontalCenter: contentItem.horizontalCenter
                anchors.top: txtUserName.bottom
                echoMode: TextInput.Password
                font.pixelSize: 14
                color: "#00a5f7"
                width: 250
                height: 30
                anchors.topMargin: 10
            }

            Loader {
                id: myLoader
            }

            MyControls.CommonButton {
                id: btnLogin
                width: 250
                height: 35
                anchors.top: txtPwd.bottom
                anchors.topMargin: 15
                anchors.horizontalCenter: contentItem.horizontalCenter
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
                title = appConfig.appTitle
                lblTitle.text = qsTr("Welcome")
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
}
