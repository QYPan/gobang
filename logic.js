var chess = null;
var BUFSIZE = 0;
var component = null;
var prePos = null;

function init(playerFirst){
    BUFSIZE = touchArea.cellNumber;
    var i, j;
    if(chess == null){
        chess = new Array(BUFSIZE);
        for(i = 0; i < BUFSIZE; i++){
            chess[i] = new Array(BUFSIZE);
        }
    }
    if(playerFirst == false){ // 黑棋优先(即电脑优先)
        createChessman(Math.floor(BUFSIZE/2), Math.floor(BUFSIZE/2), 0);
    }
}

function createChessman(column, row, type) {
    if (component == null)
        component = Qt.createComponent("Chessman.qml");

    if (component.status == Component.Ready) {
        var dynamicObject = component.createObject(touchArea);
        if (dynamicObject == null) {
            console.log("error creating chessman");
            console.log(component.errorString());
            return false;
        }
        dynamicObject.type = type;
        dynamicObject.rimVisiable = true;
        dynamicObject.x = column * touchArea.cellSize;
        dynamicObject.y = row * touchArea.cellSize;
        dynamicObject.width = touchArea.cellSize;
        dynamicObject.height = touchArea.cellSize;
        chess[row][column] = dynamicObject;
        if(prePos){
            prePos.rimVisiable = false;
        }
        prePos = dynamicObject;
    } else {
        console.log("error loading chessman component");
        console.log(component.errorString());
        return false;
    }
    return true;
}

function clearChessmans(){
    var i, j;
    for(i = 0; i < BUFSIZE; i++){
        for(j = 0; j < BUFSIZE; j++){
            if(chess[i][j]){
                chess[i][j].destroy();
                chess[i][j] = null;
            }
        }
    }
}

function isWin(row, column, chessType){
    var value1 = together(row, column, chessType, 0, 1); // 横向
    var value2 = together(row, column, chessType, 1, 0); // 竖向
    var value3 = together(row, column, chessType, 1, -1); // 主对角线（右上到左下）
    var value4 = together(row, column, chessType, 1, 1); // 副对角线
    if(value1 >= 5 || value2 >= 5 || value3 >= 5 || value4 >= 5)
        return true;
    return false;
}

function together(row, column, chessType, d1, d2){
    var i = row - d1;
    var j = column - d2;
    var count = 1;
    while(judgeEdge(i, j) && chess[i][j] != undefined && chess[i][j].type == chessType){
        count++;
        i -= d1;
        j -= d2;
    }
    i = row + d1;
    j = column + d2;
    while(judgeEdge(i, j) && chess[i][j] != undefined && chess[i][j].type == chessType){
        count++;
        i += d1;
        j += d2;
    }
    return count;
}

function judgeEdge(row, column){
    if(row < 0 || row >= BUFSIZE || column < 0 || column >= BUFSIZE)
        return false;
    return true;
}

function handleClicked(xPos, yPos, chessType){
    var column = Math.floor(xPos / touchArea.cellSize);
    var row = Math.floor(yPos / touchArea.cellSize);
    if(judgeEdge(row, column) == false)
        return;
    if(chess[row][column] == null){
        createChessman(column, row, chessType);
        var pos = [row, column];
        if(isWin(row, column, chessType)){
            pos.push(chessType);
        }
        return pos;
    }
    return;
}
