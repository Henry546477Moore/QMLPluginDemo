import QtQuick 2.11
import QtQuick.Controls 2.2


Button {
    id: control

    property string toolTip: ""

    ToolTip.visible: hovered
    ToolTip.text: toolTip

    contentItem: Text {
     text: control.text
     font: control.font
     opacity: enabled ? 1.0 : 0.3
     color: "white"
     horizontalAlignment: Text.AlignHCenter
     verticalAlignment: Text.AlignVCenter
     elide: Text.ElideRight
    }

    background: Rectangle {
     implicitWidth: 50
     implicitHeight: 25
     opacity: enabled ? 1 : 0.3
     //border.color: control.down ? "#17a81a" : "#21be2b"
     border.width: 1
     color: control.hovered ? "#3CC3F5" : (control.down ? "#3CC3F5" : "#00A3FF")
     radius: 2
    }
}
