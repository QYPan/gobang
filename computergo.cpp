#include "computergo.h"
#include <QDebug>

ComputerGo::ComputerGo(QObject *parent)
    : QObject(parent)
    , m_type(BLACK)
{
    connect(&thread, &CalculateThread::sendAnswer, this, &ComputerGo::sendChessPos);
}

ComputerGo::~ComputerGo(){
}


int ComputerGo::type() const{
    return m_type;
}

void ComputerGo::setType(const int newType){
    m_type = newType;
}

void ComputerGo::getChessPos(int row, int column){
    thread.requestChessPos(row, column, m_type);
}

void ComputerGo::initFirst(int row, int column){
    thread.initFirst(row, column, m_type);
}

void ComputerGo::clearChess(){
    thread.clearChess();
}
