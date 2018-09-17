import QtQuick 2.9
import QtQuick.Controls 2.2

Rectangle {
    id: fontButton

    property string text: ""
    property int fontSize: 12
    property string toolTip
    property color backgroundColor: "#00000000"
    property color bgcolorNormal: "#00000000"
    property color bgcolorHover: "#00000000"
    property color bgcolorPressed: "#00000000"

    signal clicked

    color: fontButton.backgroundColor
    state: "normal"

    ToolTip.visible: hovered
    ToolTip.text: toolTip

    Text {
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        text: fontButton.text
        font.pixelSize: fontButton.fontSize
        color: "white"
        font.family: "FontAwesome"
    }

    MouseArea {
        hoverEnabled: true
        anchors.fill: parent
        onEntered: fontButton.state = (fontButton.state == "pressed" ? "pressed" : "hover")
        onExited: fontButton.state = (fontButton.state == "pressed" ? "pressed" : "normal")
        onPressed: fontButton.state = "pressed"
        onReleased: {
            fontButton.state = "normal"
            fontButton.clicked()
        }
    }

    states:
    [
        State {
            name: "hover"
            PropertyChanges {
                target: fontButton
                backgroundColor: bgcolorHover
            }
        },
        State {
            name: "normal"
            PropertyChanges {
                target: fontButton
                backgroundColor: bgcolorNormal
            }
        },
        State {
            name: "pressed"
            PropertyChanges {
                target: fontButton
                backgroundColor: bgcolorPressed
            }
        }
    ]
}
