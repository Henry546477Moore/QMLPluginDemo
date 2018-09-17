import QtQuick 2.11
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import "controls" as MyControls

Item {
    id: root
    property int closeType                 //0: close 1: minimize to tray
    property bool choiceByMySelf
    property bool remberMyChoice
    signal closed

    width: 200
    height: 150

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


    RadioButton {
        id: cbClose
        anchors.top: lblTitle.bottom
        anchors.horizontalCenter: parent.left
        checked: closeType == 0
    }

    RadioButton {
        id: cbMin
        anchors.top: cbClose.bottom
        anchors.horizontalCenter: parent.left
        checked: closeType == 1
    }

    CheckBox {
        id: cbPromptClose
        anchors.top: cbMin.bottom
        anchors.horizontalCenter: parent.left
        checked: choiceByMySelf
    }

    CheckBox {
        id: cbRember
        anchors.top: cbPromptClose.bottom
        anchors.horizontalCenter: parent.left
        checked: remberMyChoice
    }


    MyControls.CommonButton {
        id: btnOK
        width: 250
        height: 30
        anchors.top: cbRember.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.left

        onClicked: {
            if(cbClose.checked) {
                closeType = 0
            }
            else if(cbMin.checked) {
                closeType = 1
            }
            if(cbPromptClose.checked) {
                choiceByMySelf = true
            }
            if(cbRember.checked) {
                remberMyChoice = true
            }

            root.closed()
        }
    }

    Component.onCompleted: {

        translator()
    }

    function translator() {
        titleBar.title = qsTr("Close choice")
        cbClose.text = qsTr("Exit system")
        cbMin.text = qsTr("Minimize to System Tray")
        cbPromptClose.text = qsTr("Let me choose when closing.")
        cbRember.text = qsTr("Remember my choice.")
        btnLogin.text = qsTr("OK")
        btnLogin.toolTip = qsTr("Confirm closing operation")
    }
}
