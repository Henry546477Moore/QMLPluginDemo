import QtQuick 2.11
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import "controls" as MyControls

Rectangle
{
    id: tabwidget
    color: "transparent"


    function currentChanged(curIndex)
    {
        content.contentCurrentChanged(curIndex);
    }

    ColumnLayout{
        id:columnContent
        anchors.fill: parent
        spacing: 0

        RowLayout
        {
            id: toolbar
            spacing: 10
            anchors.fill: parent
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.topMargin: 0

            property int current: 0
            onCurrentChanged:setCurrentToolBtn()
            Layout.maximumHeight: 70

            function setCurrentToolBtn()
            {
                for(var i = 0; i < toolbar.children.length; i++)
                {
                    toolbar.children[i].state = (toolbar.current == i ? 'checked' : 'leave')
                }
                tabwidget.currentChanged(toolbar.current)
            }

            MyControls.ToolBtn
            {
                index:0
                state:"checked"     //第一个是按下状态，默认显示第一个界面
                picSrc: "qrc:/images/ico_Examine.png"
                btnText:"电脑体检"
                onClicked:toolbar.current=btnIndex
            }
            MyControls.ToolBtn
            {
                index:1
                picSrc: "qrc:/images/ico_dsmain.png"
                btnText:"木马查杀"
                onClicked:toolbar.current=btnIndex
            }
            MyControls.ToolBtn
            {
                index:2
                picSrc: "qrc:/images/ico_SysRepair.png"
                btnText:"系统修复"
                onClicked:toolbar.current=btnIndex
            }
            MyControls.ToolBtn
            {
                index:3
                picSrc: "qrc:/images/ico_TraceCleaner.png"
                btnText:"电脑清理"
                onClicked:toolbar.current=btnIndex
            }
            MyControls.ToolBtn
            {
                index:4
                picSrc: "qrc:/images/ico_SpeedupOpt.png"
                btnText:"优化加速"
                onClicked:toolbar.current=btnIndex
            }
            MyControls.ToolBtn
            {
                index:5
                picSrc: "qrc:/images/ico_expert.png"
                btnText:"电脑专家"
                onClicked:toolbar.current=btnIndex
            }
            MyControls.ToolBtn
            {
                index:6
                picSrc: "qrc:/images/ico_diannaomenzhen.png"
                btnText:"电脑门诊"
                onClicked:toolbar.current=btnIndex
            }
            MyControls.ToolBtn
            {
                index:7
                picSrc: "qrc:/images/ico_softmgr.png"
                btnText:"软件管家"
                onClicked:toolbar.current=btnIndex
            }
            Image
            {
                id: logo

                anchors.right: parent.right
                source: "qrc:/images/logo.png"
            }
        }

        RowLayout {
            spacing: 0
            Layout.fillHeight: true

            Rectangle
            {
                id:content
                color:"white"
                Layout.fillWidth: true
                Layout.fillHeight: true

                property int current: 0

                function contentCurrentChanged(curIndex)
                {
                    content.children[curIndex].x=width
                    content.children[curIndex].state='active'
                    content.children[current].state='hide'
                    current = curIndex
                }

                MainWidget
                {
                    state:"active"
                    Rectangle
                    {
                        anchors.fill: parent
                        anchors.margins: 0  //控制与父边框的间距
                        color:"#FFC0C0C0"
                        Text
                        {
                            font.pointSize: 20
                            font.family: "微软雅黑"
                            color:"#FFFFFF"
                            anchors.centerIn: parent
                            text:"终于找到借口趁着醉意上心头"
                        }
                    }
                }
                MainWidget
                {
                    Rectangle
                    {
                        anchors.fill: parent
                        anchors.margins: 0
                        color:"#FFC0C0C0"
                        Text
                        {
                            font.pointSize: 20
                            font.family: "微软雅黑"
                            color:"#FFFFFF"
                            anchors.centerIn: parent
                            text:"表达我所有感受"
                        }
                    }
                }
                MainWidget
                {
                    Rectangle
                    {
                        anchors.fill: parent
                        anchors.margins: 0
                        color:"#FFC0C0C0"
                        Text
                        {
                            font.pointSize: 20
                            font.family: "微软雅黑"
                            color:"#FFFFFF"
                            anchors.centerIn: parent
                            text:"寂寞渐浓沉默留在舞池角落"
                        }
                    }
                }
                MainWidget
                {
                    Rectangle
                    {
                        anchors.fill: parent
                        anchors.margins: 0
                        color:"#FFC0C0C0"
                        Text
                        {
                            font.pointSize: 20
                            font.family: "微软雅黑"
                            color:"#FFFFFF"
                            anchors.centerIn: parent
                            text:"你说的太少或太多"
                        }
                    }
                }
                MainWidget
                {
                    Rectangle
                    {
                        anchors.fill: parent
                        anchors.margins: 0
                        color:"#FFC0C0C0"
                        Text
                        {
                            font.pointSize: 20
                            font.family: "微软雅黑"
                            color:"#FFFFFF"
                            anchors.centerIn: parent
                            text:"都会让人更惶恐"
                        }
                    }
                }
                MainWidget
                {
                    Rectangle
                    {
                        anchors.fill: parent
                        anchors.margins: 0
                        color:"#FFC0C0C0"
                        Text
                        {
                            font.pointSize: 20
                            font.family: "微软雅黑"
                            color:"#FFFFFF"
                            anchors.centerIn: parent
                            text:"谁任由谁放纵谁会先让出自由"
                        }
                    }
                }
                MainWidget
                {
                    Rectangle
                    {
                        anchors.fill: parent
                        anchors.margins: 0
                        color:"#FFC0C0C0"
                        Text
                        {
                            font.pointSize: 20
                            font.family: "微软雅黑"
                            color:"#FFFFFF"
                            anchors.centerIn: parent
                            text:"最后一定总是我"
                        }
                    }
                }
                MainWidget
                {
                    Rectangle
                    {
                        anchors.fill: parent
                        anchors.margins: 0
                        color:"#FFC0C0C0"
                        Text
                        {
                            font.pointSize: 20
                            font.family: "微软雅黑"
                            color:"#FFFFFF"
                            anchors.centerIn: parent
                            text:"我嫉妒你的爱气势如虹"
                        }
                    }
                }
            }

            Rectangle {
                id:rightRectange
                color:"#ffffff"
                Layout.fillHeight: true
                Layout.preferredWidth: 200

                ColumnLayout {
                    id:rightColumnLayout

                    anchors.fill: parent
                    spacing: 0

                    Rectangle {
                        id:rightTopContent

                        Layout.preferredWidth: 200
                        Layout.preferredHeight: 200

                        color:"#ffffff"
                        GridLayout {
                            id:gridLayout
                            anchors.fill: parent
                            rows: 2
                            columns: 3
                            rowSpacing: 20
                            columnSpacing: 20
                            anchors.margins: 20

                            MyControls.LabelBtn
                            {
                                width: 20
                                height:20
                                picSrc: "qrc:/images/fireproof.png"
                                text:"木马防火墙"
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                            }
                            MyControls.LabelBtn
                            {
                                width: 20
                                height:20
                                picSrc: "qrc:/images/triggerman.png"
                                text:"360保镖"
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                            }
                            MyControls.LabelBtn
                            {
                                width: 20
                                height:20
                                picSrc: "qrc:/images/net_shop.png"
                                text:"网购先赔"
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                            }
                            MyControls.LabelBtn
                            {
                                width: 20
                                height:20
                                picSrc: "qrc:/images/fireproof.png"
                                text:"木马防火墙"
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                            }
                            MyControls.LabelBtn
                            {
                                width: 20
                                height:20
                                picSrc: "qrc:/images/triggerman.png"
                                text:"360保镖"
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                            }
                            MyControls.LabelBtn
                            {
                                width: 20
                                height:20
                                picSrc: "qrc:/images/net_shop.png"
                                text:"网购先赔"
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                            }
                        }
                    }

                    //中间直线
                    Rectangle{
                       width:200
                       height:1
                       color:"#9AC0CD"
                    }

                    Rectangle {
                        id:middleRectange
                        color:"#ffffff"
                        Layout.preferredWidth: 200
                        Layout.preferredHeight: 32

                        RowLayout {
                            id: middleLayout
                            anchors.fill: parent

                            Text {
                                id:middleText
                                text:"功能大全"
                                color: "green"
                                font.pointSize: 9
                                font.family: "微软雅黑"

                                Layout.preferredWidth: 50

                                anchors.left: parent.left
                                anchors.leftMargin: 5
                            }

                            MyControls.ToolBtn {
                                id:middleBtn
                                btnText:"更多"
                                Layout.preferredWidth: 32
                                Layout.preferredHeight: 20

                                anchors.right: parent.right
                                anchors.rightMargin: 5

                                //必须包含  import QtQuick.Controls.Styles 1.4
//                                style: ButtonStyle {
//                                    background: Rectangle {
//                                        implicitWidth: 100
//                                        implicitHeight: 25
//                                        //border.width: control.activeFocus ? 2 : 1
//                                        border.color: "#888"
//                                        radius: 4
//                                        color: "transparent"
//                                        border.width: 0  //用于去除边框
//                                        gradient: Gradient {
//                                            GradientStop { position: 0 ; color: control.pressed ? "#ccc" : "#eee" }
//                                            GradientStop { position: 1 ; color: control.pressed ? "#aaa" : "#ccc" }
//                                        }
//                                    }
//                                }
                            }
                        }
                    }

                    Rectangle {
                        id:rightBottomContent
                        color:"#ffffff"

                        Layout.fillHeight: true
                        Layout.preferredWidth: 200

                        GridLayout {
                            id:gridBottomLayout
                            anchors.fill: parent
                            rows:3
                            columns: 3
                            rowSpacing: 20
                            columnSpacing: 20
                            anchors.margins: 30

                            MyControls.LabelBtn
                            {
                                picSrc: "qrc:/images/jingling.png"
                                text:"健康精灵"
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                            }
                            MyControls.LabelBtn
                            {
                                picSrc: "qrc:/images/upan.png"
                                text:"U盘鉴定器"
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                            }
                            MyControls.LabelBtn
                            {
                                picSrc: "qrc:/images/zhuomian.png"
                                text:"安全桌面"
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                            }
                            MyControls.LabelBtn
                            {
                                picSrc: "qrc:/images/youxi.png"
                                text:"游戏盒子"
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                            }
                            MyControls.LabelBtn
                            {
                                picSrc: "qrc:/images/shouji.png"
                                text:"手机助手"
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                            }
                            MyControls.LabelBtn
                            {
                                picSrc: "qrc:/images/ludashi.png"
                                text:"鲁大师"
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                            }
                            MyControls.LabelBtn
                            {
                                picSrc: "qrc:/images/ruanjian.png"
                                text:"360小助手"
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                            }
                            MyControls.LabelBtn
                            {
                                picSrc: "qrc:/images/zhuangji.png"
                                text:"一键装机"
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                            }
                            MyControls.LabelBtn
                            {
                                picSrc: "qrc:/images/weishi.png"
                                text:"手机卫士"
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                            }
                        }
                    }
                }
            }
        }
    }
}

