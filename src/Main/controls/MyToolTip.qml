import QtQuick 2.11
import QtQuick.Controls 2.3

ToolTip {
    id: control
    text: qsTr("A descriptive tool tip of what the button does")

    contentItem: Text {
        text: control.text
        font: control.font
        color: "#21be2b"
    }

    background: Rectangle {
        border.color: "#21be2b"
    }
}
