import QtQuick 2.11
import QtQuick.Controls 2.2


Button {
    id: control

    property string toolTip: ""

    ToolTip.visible: hovered && toolTip.length > 0
    ToolTip.text: toolTip

    contentItem: Text {
        font.family: "Microsoft Yahei"
        font.pixelSize: control.font.pixelSize
        text: control.text
        opacity: enabled ? 1.0 : 0.3
        color: "white"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
     implicitWidth: control.width
     implicitHeight: control.height
     opacity: enabled ? 1 : 0.3
     border.width: 0
     color: control.hovered ? "#3CC3F5" : (control.down ? "#3CC3F5" : "#00A3FF")
     radius: 2
    }
}
