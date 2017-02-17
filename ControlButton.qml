import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

Button {
    property string buttonText
    property int buttonSize
    property color buttonTextColor: "#550000"

    Text {
        id: buttonName
        anchors.centerIn: parent
        text: buttonText
        font.pointSize: buttonSize
        color: buttonTextColor
    }

    style: ButtonStyle {
        background: Rectangle {
            implicitHeight: control.height
            implicitWidth: control.width
            radius: 2
            border.width: control.pressed ? 3 : 2
            border.color: (control.hovered ||  control.pressed)
                          ? "#b8d88a" : "#b8c89a"
            gradient: Gradient {
                GradientStop {position: 0.0; color: "#c88716"}
                GradientStop {position: 1.0; color: "#c8b069"}
            }
        }
    }

    function setEnabled(flag){
        enabled = flag;
        buttonTextColor = flag ? "#550000" : "#747474";
    }
}
