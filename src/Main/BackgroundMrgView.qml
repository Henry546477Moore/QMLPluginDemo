import QtQuick 2.11
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import "controls" as MyControls

Item {
    id: root
    signal closed

    width: 600
    height: 500

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

    ColumnLayout {

        MyControls.CommonTitleBar {
            id: titleBar
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
            width: root.width
            height: root.height - titleBar.height

            Rectangle {
                id: contentBackground
                anchors.fill: parent
                color: "white"
                opacity: appConfig.backgroundOpacity
            }

            MyControls.ImageButton {
                id: addImg
                height: 35


                picHover: "qrc:/images/addimg_32x32.png"
                picNormal: "qrc:/images/addimg_32x32.png"
                picPressed: "qrc:/images/addimg_32x32.png"

                onClicked: fileDialog.open()
            }
            MyControls.ImageButton {
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
                anchors.top: addColor.bottom
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
                id: contentView
                anchors.top: sliderBgOpacity.bottom
                height: parent.height - sliderBgOpacity.height - addColor.height - myPage.height - 5
                clip: true
                ColumnLayout {
                    Flow {
                        id: flow
                        width: root.width
                        Repeater {
                            id:lstColors
                            delegate: BackgroundDelete {}
                        }
                    }
                }
            }

            MyControls.PagerControl {
                id: myPage
                anchors.top: contentView.bottom
                height: 35
                mTotalCount: 105
                onPageChanged: queryBackgroundSource()
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

    Component.onCompleted: {
        var totalCount = appConfig.listSources.length;
        myPage.pageSize = 12
        myPage.pageSizeVisible = false
        myPage.mTotalCount = totalCount
        myPage.updatePageInfo()
        queryBackgroundSource()
    }

    function queryBackgroundSource() {
        var totalCount = appConfig.listSources.length
        var pageSize = myPage.pageSize
        if(pageSize < 1) {
            pageSize = 100
        }
        var pageCount = (totalCount + pageSize - 1) / pageSize
        var pageIndex = myPage.pageIndex
        if(pageIndex < 0){
            pageIndex = 0
        }
        else if(pageIndex >= pageCount) {
            pageIndex = pageCount - 1
        }
        var start = pageIndex * pageSize
        var end = start + pageSize
        if(end > totalCount) {
            end = totalCount
        }
        lstColors.model = appConfig.listSources.slice(start, end)
        flow.width = root.width
    }
}
