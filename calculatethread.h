#ifndef CALCULATETHREAD_H
#define CALCULATETHREAD_H

#include <QThread>
#include <QMutex>
#include <QWaitCondition>
#include "calculate.h"

class CalculateThread : public QThread
{
    Q_OBJECT
public:
    CalculateThread(QObject *parent = 0);
    ~CalculateThread();
    void requestChessPos(int row, int column, int type);
    void run();
    void initFirst(int row, int column, int type);
    void clearChess();
signals:
    void sendAnswer(int row, int column);
private:
    bool quit;
    int m_type;
    int oppRow, oppColumn;
    int vis[MAPSIZE+5][MAPSIZE+5];
    QMutex mutex;
    QWaitCondition cond;
};

#endif // CALCULATETHREAD_H
