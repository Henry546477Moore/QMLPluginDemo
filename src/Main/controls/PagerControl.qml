import QtQuick 2.11
import QtQuick.Controls 2.2

Item {
    id: root
    property int mTotalCount: 0
    property int pageIndex: 0
    property int pageSize: 100
    property int pageCount: 0
    property alias pageSizeVisible: cbPageSize.visible

    signal pageChanged

    Label {
        id: pagerInfo
        anchors.left: root.left
        anchors.leftMargin: 20
        anchors.verticalCenter: parent.verticalCenter
    }
    ComboBox {
        id: cbPageSize
        anchors.left: pagerInfo.right
        anchors.leftMargin: 5
        anchors.verticalCenter: parent.verticalCenter
        model: [10, 30, 50, 100, 200, 300, 500]
        onCurrentIndexChanged: {
            pageSize = currentText
            updatePageInfo()
            pageChanged()
        }
    }

    CommonButton {
        id: btnFirst
        anchors.left: cbPageSize.visible? cbPageSize.right : pagerInfo.right
        anchors.leftMargin: 5
        width: 50
        text: "<<"
        toolTip: qsTr("Jump to first page")
        onClicked: {
            pageIndex = 0
            updatePageInfo()
            pageChanged()
        }
    }
    CommonButton {
        id: btnPre
        anchors.left: btnFirst.right
        anchors.leftMargin: 5
        width: 50
        text: "<"
        toolTip: qsTr("Jump to previous page")
        onClicked: {
            --pageIndex
            updatePageInfo()
            pageChanged()
        }
    }
    TextInput {
        id: txtPageIndex
        anchors.left: btnPre.right
        anchors.leftMargin: 5
        anchors.verticalCenter: parent.verticalCenter
    }
    Text {
        id: txtTotalPageCount
        anchors.left: txtPageIndex.right
        anchors.leftMargin: 5
        anchors.verticalCenter: parent.verticalCenter
    }

    CommonButton {
        id: btnNext
        anchors.left: txtTotalPageCount.right
        anchors.leftMargin: 5
        width: 50
        text: ">"
        toolTip: qsTr("Jump to next page")
        onClicked: {
            ++pageIndex
            updatePageInfo()
            pageChanged()
        }
    }
    CommonButton {
        id: btnLast
        anchors.left: btnNext.right
        anchors.leftMargin: 5
        width: 50
        text: ">>"
        toolTip: qsTr("Jump to last page")
        onClicked: {
            pageIndex = pageCount - 1
            updatePageInfo()
            pageChanged()
        }
    }

    Component.onCompleted: {
        updatePageInfo()
        translator()
    }

    function updatePageInfo(){
        if(mTotalCount < 0){
            mTotalCount = 0
        }
        if(pageSize < 1) {
            pageSize = 100
        }
        pageCount = (mTotalCount + pageSize - 1) / pageSize
        if(pageIndex < 0){
            pageIndex = 0
        }
        else if(pageIndex >= pageCount) {
            pageIndex = pageCount - 1
        }
        var start = pageIndex * pageSize
        var end = start + pageSize
        if(end > mTotalCount) {
            end = mTotalCount
        }

        pagerInfo.text = qsTr("Query Result: %1-%2/%3").arg(start).arg(end).arg(mTotalCount)
        txtPageIndex.text = pageIndex + 1
        txtTotalPageCount.text = qsTr("/%1").arg(pageCount)

        btnFirst.enabled = pageIndex > 0
        btnPre.enabled = pageIndex > 0
        txtPageIndex.enabled = pageCount > 1
        btnNext.enabled = pageIndex < pageCount - 1
        btnLast.enabled = pageIndex < pageCount - 1
    }
    function getTotalCount() {
        return mTotalCount;
    }

    function translator() {
    }
}
