import QtQuick 2.11
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import "controls" as MyControls

MyControls.CustomWindowBase {
    id: root

    showMinBtn: false
    showMaxBtn: false

    property int closeType                 //0: close 1: minimize to tray
    property bool choiceSelf

    signal choiceAndClose
    signal cancelClose

    onClosed: cancelClose()

    contentComponent:  Item {
        id: cItem

        ColumnLayout {
            anchors.top: cItem.top
            anchors.horizontalCenter: cItem.horizontalCenter
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
                onClicked: root.cancelClose()
            }
        }

        Component.onCompleted: {
            translator()
        }

        function translator() {
            title = qsTr("When close main window")
            cbClose.text = qsTr("Exit system")
            cbMin.text = qsTr("Minimize to System Tray")
            cbChoice.text = qsTr("Choice Self")
            btnOK.text = qsTr("OK")
            btnCancel.text = qsTr("Cancel")
        }
    }
}
