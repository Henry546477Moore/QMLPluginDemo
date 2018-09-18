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
    property bool remberMyChoice

    signal choiceAndClose
    signal cancelClose

    width: 250
    height: 250

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

    MyControls.CommonTitleBar {
        id: titleBar
        width: root.width
        height: 32
        showMinBtn: false
        showMaxBtn: false

        onClosed: root.cancelClose()
    }

    Rectangle {
        id: contentBackground
        anchors.top: titleBar.bottom
        width: root.width
        height: root.height - titleBar.height
        color: "white"
        opacity: 0.6
    }

    ColumnLayout {
        anchors.horizontalCenter: root.horizontalCenter
        anchors.top: titleBar.bottom
        anchors.topMargin: 10

        RadioButton {
            id: cbMin
            checked: closeType == 1
        }

        RadioButton {
            id: cbClose
            checked: closeType == 0
        }

        CheckBox {
            id: cbRember
            checked: remberMyChoice
        }


        MyControls.CommonButton {
            id: btnOK
            width: 250
            height: 30
            anchors.topMargin: 10

            onClicked: {
                if(cbClose.checked) {
                    closeType = 0
                }
                else if(cbMin.checked) {
                    closeType = 1
                }
                if(cbRember.checked) {
                    remberMyChoice = true
                }

                root.choiceAndClose()
            }
        }
    }

    Component.onCompleted: {
        translator()
    }

    function translator() {
        titleBar.title = qsTr("When close main window")
        cbClose.text = qsTr("Exit system")
        cbMin.text = qsTr("Minimize to System Tray")
        cbRember.text = qsTr("Remember my choice.")
        btnOK.text = qsTr("OK")
        btnOK.toolTip = qsTr("Confirm closing operation")
    }
}
