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

    contentComponent:  Item {
        id: cItem

        MyControls.CommonButton {
            id: addImg
            height: 32
            anchors.left: cItem.left
            anchors.top: cItem.top
            anchors.leftMargin: 5
            anchors.topMargin: 5

            text: qsTr("Add New Image")
            toolTip: qsTr("Add new image as system background source")

            onClicked: fileDialog.open()
        }
        MyControls.CommonButton {
            id: addColor
            height: 32
            anchors.left: addImg.right
            anchors.top: addImg.top
            anchors.leftMargin: 20

            text: qsTr("Add New Color")
            toolTip: qsTr("Add new color as system background source")

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

        ScrollView {
            id: contentView
            anchors.top: sliderBgOpacity.bottom
            height: cItem.height - sliderBgOpacity.height - addColor.height - myPage.height - 5
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
}
