import QtQuick 2.11
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0

Item {
    id: root

    property bool  isMax: false
    property alias showMinBtn: minBtn.visible
    property alias showMaxBtn: maxBtn.visible
    property string title: ""

    property alias headerHeight: titleItem.height
    property alias footerHeight: footerLoader.height

    property Component contentComponent: null
    readonly property Item contentItem: contentLoader.item

    property Component footerComponent: null
    readonly property Item footerItem: footerLoader.item

    signal minimized
    signal maximizad(bool maxStatus)
    signal closed

    CommonBackground {
        anchors.fill: parent
    }

    Rectangle {
        id: contentBackground
        anchors.top: titleItem.bottom
        width: parent.width
        height: parent.height - titleItem.height
        color: "white"
        opacity: 0.6
    }

    Item {
        id: titleItem
        width: root.width
        height: 40

        Text {
            id: cusTitle
            anchors.left: titleItem.left
            anchors.leftMargin: 15
            anchors.verticalCenter: titleItem.verticalCenter
            color: "white"
            font.pixelSize: 18
            font.bold: true

            text: root.title
        }

        FontButton {
            id:minBtn
            anchors.right: maxBtn.left

            width: 32
            height: 32

            text: "\uf2d1"
            bgcolorHover: "#aaa"

            onClicked: root.minimized()
        }


        FontButton {
            id:maxBtn
            anchors.topMargin: 14
            anchors.right: closeBtn.left
            anchors.rightMargin: 2
            anchors.verticalCenter: titleItem.verticalCenter
            width: 32
            height: 32

            text: "\uf2d0"
            bgcolorHover: "#aaa"

            onClicked: root.maxUndoFun()
        }

        FontButton {
            id:closeBtn
            anchors.right: titleItem.right
            anchors.rightMargin: 2
            anchors.verticalCenter:  titleItem.verticalCenter

            width: 32
            height: 32

            text: "\uf2d4"
            bgcolorHover: "red"

            onClicked: root.closed()
        }

    }
    Loader {
        id: contentLoader
        width: root.width
        anchors.top: titleItem.bottom
        anchors.bottom: footerComponent == null ? root.bottom : footerLoader.top
        sourceComponent: contentComponent
        Binding {
            target: contentLoader.item
            property: "anchors.fill"
            value: contentLoader
        }
    }

    Loader {
        id: footerLoader
        width: root.width
        height: footerComponent == null ? 0 : 40
        anchors.bottom: root.bottom
        sourceComponent: footerComponent
        Binding {
            target: footerLoader.item
            property: "anchors.fill"
            value: footerLoader
        }
    }

    //最大化(还原)
    function maxUndoFun(){
        if(isMax)
        {
            maxBtn.text = "\uf2d0"
            maxBtn.toolTip = qsTr("Maximization")
        }
        else
        {
            maxBtn.text = "\uf2d2"
            maxBtn.toolTip = qsTr("Restore")
        }
        isMax = !isMax
        root.maximizad(isMax)
    }


    Component.onCompleted: {

        translator()
    }

    function translator() {
        minBtn.toolTip = qsTr("Minimize")
        maxBtn.toolTip = qsTr("Maximization")
        closeBtn.toolTip = qsTr("Close")
    }
}
