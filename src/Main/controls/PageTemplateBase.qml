import QtQuick 2.11
import QtQuick.Controls 2.2

Item {
    id: root

    property alias headerHeight: headerLoader.height
    property alias footerHeight: footerLoader.height

    property Component headerComponent: null
    readonly property Item headerItem: headerLoader.item

    property Component contentComponent: null
    readonly property Item contentItem: contentLoader.item

    property Component footerComponent: null
    readonly property Item footerItem: footerLoader.item

    CommonBackground {
        anchors.fill: parent
    }

    Loader {
        id: headerLoader
        width: root.width
        height: headerComponent == null ? 0: 40
        anchors.top: root.top
        sourceComponent: headerComponent
        Binding {
            target: headerLoader.item
            property: "anchors.fill"
            value: headerLoader
        }
    }

    Loader {
        id: contentLoader
        width: root.width
        anchors.top: headerComponent == null ? root.top : headerLoader.bottom
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

}
