import QtQuick 2.11
import QtQuick.Controls 2.2

Button {
    id: control

    property int fontSize: 12
    property string toolTip

    property color bgcolorHover: "#00000000"


    ToolTip.visible: hovered && toolTip.length > 0
    ToolTip.text: toolTip

    contentItem: Text {
        text: control.text
        //font: control.font
        opacity: enabled ? 1.0 : 0.3
        color: "white"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
        font.pixelSize: control.fontSize
        font.family: "FontAwesome"
    }

    background: Rectangle {
        implicitWidth: 50
        implicitHeight: 25
        opacity: enabled ? 1 : 0.3
        border.width: 0
        color: control.hovered ? bgcolorHover : "transparent"
        radius: 2
    }
}
