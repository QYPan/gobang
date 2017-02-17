import QtQuick 2.5

Item {
    id: chessman
    property int type: 0
    property alias rimVisiable: painter.visible // 边框

    Image {
        id: img
        anchors.fill: parent
        anchors.margins: 3
        source: {
            if (type == 0)
                return "images/blackchess.png";
            else
                return "images/whitechess.png";
        }
    }
    Canvas {
        id: painter
        anchors.fill: parent
        contextType: "2d"
        onPaint: {
            context.lineWidth = 2;
            context.strokeStyle = "#a80000";
            var startX = 0;
            var startY = 0;
            var lineLength = width / 3;
            var endX = lineLength;
            var endY = 0;
            context.beginPath();
            context.moveTo(startX, startY);
            context.lineTo(endX, endY);

            startX = 0; startY = width;
            endX = lineLength; endY = width;
            context.moveTo(startX, startY);
            context.lineTo(endX, endY);

            startX = width - lineLength; startY = 0;
            endX = width; endY = 0;
            context.moveTo(startX, startY);
            context.lineTo(endX, endY);

            startX = width - lineLength; startY = width;
            endX = width; endY = width;
            context.moveTo(startX, startY);
            context.lineTo(endX, endY);

            startX = 0; startY = 0;
            endX = 0; endY = lineLength;
            context.moveTo(startX, startY);
            context.lineTo(endX, endY);

            startX = width; startY = 0;
            endX = width; endY = lineLength;
            context.moveTo(startX, startY);
            context.lineTo(endX, endY);

            startX = 0; startY = width - lineLength;
            endX = 0; endY = width;
            context.moveTo(startX, startY);
            context.lineTo(endX, endY);

            startX = width; startY = width - lineLength;
            endX = width; endY = width;
            context.moveTo(startX, startY);
            context.lineTo(endX, endY);

            context.stroke();
        }
    }
}
