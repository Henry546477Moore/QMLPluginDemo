import QtQuick 2.11
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import com.henrymoore 1.0

Item {
    id: root
    signal closed

    width: 600
    height: 400
    Image {
        id: image
        anchors.fill: parent
        source: "qrc:/images/head_bg_3.jpg"
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
        anchors.fill: image
        source: image
        maskSource: mask
    }

    ColumnLayout {
        CommonTitleBar {
            id: titleBar
            anchors.top: parent.top
            width: root.width
            height: 32
            showMinBtn: false
            showMaxBtn: false

            title: qsTr("System background manager")

            onClosed: root.closed()
        }
        Item {
            id: content
            anchors.top: titleBar.bottom
            anchors.bottom: root.bottom

            Rectangle{
                color: mySystemIO.currentBackgroundSource
                width: root.width
                height: root.height - titleBar.height
            }
        }
    }


    SystemConfigIO{
        id: mySystemIO
    }
}
