import QtQuick 2.11
import QtQuick.Controls 2.3
import QtQuick.Window 2.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import Qt.labs.platform 1.0

ApplicationWindow {
    id:mainWindow
    objectName: "mainWindow"
    width: 900
    height: 640
    visible: true
    flags: Qt.FramelessWindowHint | Qt.Window

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
        id: bgImgMask
        anchors.fill: image
        source: image
        maskSource: mask
        visible: appConfig.isUseBackgroundImg
    }

    ResizeWidget {
        z: 1
        enableSize: 8
        anchors.fill: parent
        //color: "transparent"
        ColumnLayout {
            id:mainLayout
            anchors.fill: parent
            spacing: 0
            //title bar
            MainWindowTitleBar {
                id:titleBar
                title: mainWindow.title
                height: 32
                Layout.fillWidth: true
            }
            //center content area
            ContentWidget{
                id:contentWidget

                Layout.fillWidth: true
                Layout.fillHeight: true
                //color: "red"
            }
            //status bar
            MainWindowStatusBar {
                id:statusBar
                height: 32
                Layout.fillWidth: true
            }
        }
    }

    SystemTrayIcon {
        id: myTrayIcon
        visible: true

        iconSource: "qrc:/images/logo.ico"

        onActivated: {
            mainWindow.show()
            mainWindow.raise()
            mainWindow.requestActivate()
        }

        menu: Menu {
            MenuItem {
                text: qsTr("Quit")
                onTriggered: Qt.quit()
            }
        }
    }

    Component.onCompleted: {
        translator()
    }

    function translator() {
        myTrayIcon.tooltip = title = qsTr("QML Custom Window")
        myTrayIcon.showMessage(title, qsTr("Change language"))
    }
}
