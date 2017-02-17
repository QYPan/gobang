#include <QGuiApplication>
#include <QQmlContext>
#include <QQmlApplicationEngine>
#include "computergo.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("computer", new ComputerGo); // 定义接口实例
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
