import QtQuick 2.11
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import "controls" as MyControls

Item {
    id: root
    property int closeType
    property bool choiceSelf
    signal choiceAndClose
    signal cancelAndClose

    width: 300
    height: 240

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

        onClosed: root.cancelAndClose()
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

        RadioButton {
            id: cbChoice
            checked: choiceSelf
        }


        MyControls.CommonButton {
            id: btnOK
            width: 70
            height: 30
            anchors.leftMargin: 20
            anchors.topMargin: 20

            onClicked: {
                if(cbClose.checked || cbMin.checked) {
                    choiceSelf = false
                    closeType = cbClose.checked ? 0 : 1
                }
                else {
                    choiceSelf = true
                }

                root.choiceAndClose()
            }
        }

        MyControls.CommonButton {
            id: btnCancel
            anchors.left: btnOK.right
            anchors.leftMargin: 20
            anchors.top: btnOK.top
            width: 70
            height: 30
            onClicked: root.cancelAndClose()
        }
    }

    Component.onCompleted: {
        translator()
    }

    function translator() {
        titleBar.title = qsTr("When close main window")
        cbClose.text = qsTr("Exit system")
        cbMin.text = qsTr("Minimize to System Tray")
        cbChoice.text = qsTr("Choice Self")
        btnOK.text = qsTr("OK")
        btnCancel.text = qsTr("Cancel")
    }
}
