import QtQuick 2.11
import QtQuick.Window 2.3
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Item {
    id: root
    anchors.centerIn: parent
    property alias tipText: msg.text
    property string backGroundColor: "white"
    property Item parentItem : Rectangle {}

    width: {
        if(msg.implicitWidth < 100 || msg.implicitWidth == 100)
            return 100;
        else
            return msg.implicitWidth > 300 ? 300 + 24 : (msg.implicitWidth + 24);
    }
    height: msg.implicitHeight + 24 + 100

    Dialog {
        id: dialog
        width: root.width
        height: root.height
        modal: true
        background: Rectangle {
            color: backGroundColor
            anchors.fill: parent
            radius: 5
        }
        header: Rectangle {
            width: dialog.width
            height: 50
            border.color: backGroundColor
            radius: 5
            Image {
                width: 40
                height: 40
                anchors.centerIn: parent
                source: "qrc:/images/warning.png"
            }
        }
        contentItem: Rectangle {
            border.color: backGroundColor
            color: backGroundColor
            Text {
                anchors.fill: parent
                anchors.centerIn: parent
                font.family: "Microsoft Yahei"
                color: "gray"
                text: tipText
                wrapMode: Text.WordWrap
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter

            }
        }
        footer: Rectangle {
            width: msg.width
            height: 50
            border.color: backGroundColor
            color: backGroundColor
            radius: 5
            Button {
                anchors.centerIn: parent
                width: 80
                height: 30
                background: Rectangle {
                    anchors.centerIn: parent
                    width: 80
                    height: 30
                    radius: 5
                    border.color: "#0f748b"
                    border.width: 2
                    color: backGroundColor
                    Text {
                        anchors.centerIn: parent
                        font.family: "Microsoft Yahei"
                        font.bold: true
                        color: "#0f748b"
                        text: "OK"
                    }
                }
                onClicked: {
                    dialog.close();
                }
            }
        }
    }

    Text {
        id: msg
        visible: false
        width: 300
        wrapMode: Text.WordWrap
        font.family: "Microsoft Yahei"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    function openMsg() {
        root.x = (parent.width - dialog.width) * 0.5
        root.y = (parent.height - dialog.height) * 0.5
        dialog.open();
    }
}
