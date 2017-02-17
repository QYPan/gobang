#ifndef COMPUTERGO_H
#define COMPUTERGO_H

#include <QObject>
#include "calculatethread.h"

class ComputerGo : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int type READ type WRITE setType)
public:
    enum TYPE{BLACK = 0, WHITE = 1};
    ComputerGo(QObject *parent = 0);
    ~ComputerGo();
    Q_INVOKABLE void getChessPos(int row, int column); // 得到对方落子位置
    Q_INVOKABLE void clearChess();
    Q_INVOKABLE void initFirst(int row, int column);
    int type() const;
    void setType(const int newType);
signals:
    void sendChessPos(int row, int column); // 发出己方落子位置信号
private:
    int m_type;
    CalculateThread thread;
};

#endif
