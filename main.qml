import QtQuick 2.5
import QtQuick.Window 2.2
import "logic.js" as LOGIC_CAL

Window {
    id: root
    visible: true
    width: 400
    height: 680
    title: qsTr("gobang")

    property real patternDistance: Screen.height * 0.07
    property bool playerFirst: false

    Image {
        id: background
        anchors.fill: parent
        source: "images/background.png"
        fillMode: Image.PreserveAspectCrop
    }

    Rectangle {
        id: titleImage
        height: parent.height * 0.125
        anchors.top: parent.top
        anchors.topMargin: patternDistance * 0.6
        anchors.left: parent.left
        anchors.leftMargin: patternDistance * 0.25
        anchors.right: parent.right
        anchors.rightMargin: patternDistance * 0.25
        radius: 5
        border.color: "#550000"
        border.width: 2
        gradient: Gradient {
            GradientStop {position: 0.0; color: "#c88716"}
            GradientStop {position: 1.0; color: "#c8b069"}
        }
        Text {
            id: gameName
            text: qsTr("五子棋")
            color: "#550000"
            anchors.centerIn: parent
            font.pointSize: 30
        }
    }

    Item {
        id: chessboard
        width: titleImage.width
        height: width
        anchors.top: titleImage.bottom
        anchors.topMargin: patternDistance * 0.6
        anchors.horizontalCenter: parent.horizontalCenter
        Image {
            anchors.fill: parent
            source: "images/checkerboard.png"
            fillMode: Image.PreserveAspectCrop
        }
        Canvas {
            anchors.fill: parent
            contextType: "2d"
            onPaint: {
                context.lineWidth = 2;
                context.strokeStyle = "#550000";
                var startX = touchArea.cellSize / 2;
                var startY = touchArea.cellSize / 2;
                var endX = width - touchArea.cellSize / 2;
                var endY = touchArea.cellSize / 2;
                context.beginPath();
                var i;
                for(i = 0; i < touchArea.cellNumber; i++){
                    context.moveTo(startX, startY+i*touchArea.cellSize);
                    context.lineTo(endX, endY+i*touchArea.cellSize);
                }
                endY = endX;
                endX = startX;
                for(i = 0; i < touchArea.cellNumber; i++){
                    context.moveTo(startX+i*touchArea.cellSize, startY);
                    context.lineTo(endX+i*touchArea.cellSize, endY);
                }
                context.stroke();
            }
        }
        Item {
            id: touchArea
            anchors.fill: parent
            enabled: false
            property int cellNumber: 15
            property real cellSize: width / cellNumber
            property int playerType: 1
            MouseArea {
                id: touchCell
                anchors.fill: parent
                onClicked: {
                    playerSetChess(mouse.x, mouse.y);
                }
            }
        }
        MsgDialog {
            id: msgDialog
            width: parent.width * 0.5
            height: parent.height * 0.35
            anchors.centerIn: parent
            z: 20
            visible: false
            onAcceptButtonClicked: {
                msgDialogAcceptedButtonClicked();
            }
        }
    }

    Row {
        id: buttonRows
        anchors.top: chessboard.bottom
        anchors.topMargin: patternDistance * 0.6
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: patternDistance * 0.4
        ControlButton {
            id: firstOrSecondButton
            buttonText: qsTr("后手");
            buttonSize: 17
            width: root.width * 0.25
            height: width * 0.45
            onClicked: {
                firstOrSecondButtonClicked();
            }
        }
        ControlButton {
            id: startOrStopButton
            buttonText: qsTr("开始");
            buttonSize: 17
            width: root.width * 0.25
            height: width * 0.45
            onClicked: {
                startOrStopButtonClicked();
            }
        }
        ControlButton {
            id: quitButton
            buttonText: qsTr("退出");
            buttonSize: 17
            width: root.width * 0.25
            height: width * 0.45
            onClicked: {
                quitButtonClicked();
            }
        }
    }

    Connections {
        target: computer
        onSendChessPos: { // 计算机返回一个坐标
            var newX = column * touchArea.cellSize + 5;
            var newY = row * touchArea.cellSize + 5;
            computerSetChess(newX, newY);
        }
    }

    function computerSetChess(x, y){
        var pos = LOGIC_CAL.handleClicked(x, y, touchArea.playerType^1);
        if(pos != undefined){
            if(pos.length == 3){
                gameOver(pos[2]);
            }else{
                startOrStopButton.setEnabled(true);
                touchArea.enabled = true;
            }
        }
    }

    function playerSetChess(x, y){
        var pos = LOGIC_CAL.handleClicked(x, y, touchArea.playerType);
        if(pos != undefined){
            if(pos.length == 3){
                gameOver(pos[2]);
            }else{
                touchArea.enabled = false;
                startOrStopButton.setEnabled(false);
                computer.getChessPos(pos[0], pos[1]);
            }
        }
    }

    function gameOver(winner){
        if(winner){
            msgDialog.dialogText = qsTr("白方胜");
        }else{
            msgDialog.dialogText = qsTr("黑方胜");
        }
        touchArea.enabled = false;
        msgDialog.visible = true;
        startOrStopButton.setEnabled(false);
    }

    function msgDialogAcceptedButtonClicked(){
        msgDialog.visible = false;
        startOrStopButton.setEnabled(true);
    }

    function firstOrSecondButtonClicked(){
        if(firstOrSecondButton.buttonText === qsTr("后手")){
            playerFirst = true;
            firstOrSecondButton.buttonText = qsTr("先手");
        }else{
            playerFirst = false;
            firstOrSecondButton.buttonText = qsTr("后手");
        }
    }

    function startOrStopButtonClicked(){
        if(startOrStopButton.buttonText === qsTr("开始")){
            firstOrSecondButton.setEnabled(false);
            startOrStopButton.buttonText = qsTr("重来");
            LOGIC_CAL.init(playerFirst);
            if(!playerFirst){
                computer.initFirst(Math.floor(touchArea.cellNumber/2),
                    Math.floor(touchArea.cellNumber/2));
            }
            touchArea.enabled = true;
        }else{
            LOGIC_CAL.clearChessmans();
            computer.clearChess();
            touchArea.enabled = false;
            firstOrSecondButton.setEnabled(true);
            startOrStopButton.buttonText = qsTr("开始");
        }
    }

    function quitButtonClicked(){
        Qt.quit();
    }
}
