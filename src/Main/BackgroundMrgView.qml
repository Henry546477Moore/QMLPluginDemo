import QtQuick 2.11
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Item {
    id: root
    signal closed

    width: 600
    height: 400

    Rectangle {
        anchors.fill: parent
        visible: !appConfig.isUseBackgroundImg
        color: appConfig.backgroundSource
    }

    Image {
        id: image
        anchors.fill: parent
        source: appConfig.backgroundSource
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
        visible: appConfig.isUseBackgroundImg
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

            Rectangle {
                id: contentBackground
                width: root.width
                height: root.height - titleBar.height
                //anchors.top: titleBar.bottom
                color: "white"
                opacity: appConfig.backgroundOpacity
            }

            ImageButton {
                id: addImg
                height: 35


                picHover: "qrc:/images/addimg_32x32.png"
                picNormal: "qrc:/images/addimg_32x32.png"
                picPressed: "qrc:/images/addimg_32x32.png"

                onClicked: fileDialog.open()
            }
            ImageButton {
                id: addColor
                height: 35
                anchors.left: addImg.right


                picHover: "qrc:/images/addcolor_32x32.png"
                picNormal: "qrc:/images/addcolor_32x32.png"
                picPressed: "qrc:/images/addcolor_32x32.png"

                onClicked: colorDialog.open()
            }

            Slider {
                id: sliderBgOpacity
                width: root.width - 20
                anchors.top: addImg.bottom
                anchors.horizontalCenter: root.horizontalCenter
                height: 30
                stepSize: 0.1
                value: appConfig.backgroundOpacity
                onValueChanged: appConfig.setBackgroundOpacity(value)
            }
            Component {
                id: m_Slider
                Rectangle
                {
                    implicitHeight:8
                    color:"gray"
                    radius:8
                }
            }
            Component  {
                id: m_Handle
                Rectangle{
                    anchors.centerIn: parent;
                    color:control.pressed ? "white":"lightgray";
                    border.color: "gray";
                    border.width: 2;
                    width: 34;
                    height: 34;
                    radius: 12;

                }
            }

            ScrollView {
                anchors.top: sliderBgOpacity.bottom
                height: root.height - titleBar.height - sliderBgOpacity.height - addColor.height - 5
                clip: true
                ColumnLayout {
                    Flow {
                        width: root.width
                        Repeater {
                            id:lstColors
                            model :appConfig.listBackgroundColors
                            delegate: BackgroundColorDelegate {}
                        }
                    }
                    Flow {
                        width: root.width
                        Repeater {
                            id:lstImages
                            model :appConfig.listBackgroundImgs
                            delegate: BackgroundImageDelete {}
                        }
                    }
                }
            }
        }
    }


    FileDialog {
        id: fileDialog
        title: qsTr("Choice the image as system background image source")
        nameFilters: [
        "Image Files (*.jpg *.png *.gif *.bmp *.ico)"
        ]
        onAccepted: appConfig.addBackgroundSource(true, fileUrl)
    }

    ColorDialog {
        id: colorDialog
        title: qsTr("Choice the color as system background color source")
        color: "#aaaaaa"
        onAccepted: appConfig.addBackgroundSource(false, color)
    }
}
