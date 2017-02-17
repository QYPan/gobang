import QtQuick 2.0

Item {
    id: root
    property alias dialogText: msgText.text
    signal acceptButtonClicked()

    Rectangle {
        id: background
        anchors.fill: parent
        border.color: "#b8c89a"
        border.width: 2
        radius: 5
        //opacity: 0.5
        gradient: Gradient {
            GradientStop {position: 0.0; color: "#c5c814"}
            GradientStop {position: 1.0; color: "#c8a871"}
        }
    }

    Item {
        id: msg
        width: parent.width
        height: parent.height / 2
        Text {
            id: msgText
            color: "#55007f"
            font.pointSize: 25
            anchors.centerIn: parent
        }
    }

    Item {
        width: parent.width
        height: parent.height / 2
        anchors.top: msg.bottom
        ControlButton {
            id: acceptButton
            width: parent.width * 0.45
            height: width * 0.4
            buttonText: qsTr("确定")
            buttonSize: 15
            anchors.centerIn: parent
            onClicked: {
                acceptButtonClicked();
            }
        }
    }
}
