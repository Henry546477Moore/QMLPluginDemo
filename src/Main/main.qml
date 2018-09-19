import QtQuick 2.11
import QtQuick.Controls 2.3
import QtQuick.Window 2.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import Qt.labs.platform 1.0
import "controls" as MyControls

ApplicationWindow {
    id:mainWindow
    objectName: "mainWindow"
    width: 900
    height: 640
    visible: true
    flags: Qt.FramelessWindowHint | Qt.Window

    Connections {
        target: appConfig
        onCurrentLanguageChanged: translator()
    }

    MouseArea{
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton
        property point cliCkPos: "0,0"
        onPressed: {
            cliCkPos = Qt.point(mouse.x, mouse.y)
        }
        onPositionChanged: {
            var delta = Qt.point(mouse.x - cliCkPos.x, mouse.y - cliCkPos.y)
            mainWindow.x = (mainWindow.x + delta.x)
            mainWindow.y = (mainWindow.y + delta.y)
        }
    }

    MyControls.PageTemplateBase {
        anchors.fill: parent

        headerComponent: MainWindowTitleBar {
            id:titleBar
            title: mainWindow.title
            height: 32
            Layout.fillWidth: true
        }
        contentComponent:  ContentWidget{
            id:contentWidget

            Layout.fillWidth: true
            Layout.fillHeight: true
            //color: "red"
        }
        footerComponent: MainWindowStatusBar {
            id:statusBar
            height: 32
            Layout.fillWidth: true
        }
    }


    SystemTrayIcon {
        id: myTrayIcon
        visible: true
        tooltip: mainWindow.title

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
        title = qsTr("QML Custom Window")
        myTrayIcon.showMessage(title, qsTr("Change language is %1").arg(appConfig.currentLanguage))
    }
}
