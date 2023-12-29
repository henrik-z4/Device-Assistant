#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "systeminfo.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    SystemInfo sysInfo;
    engine.rootContext()->setContextProperty("sysInfo", &sysInfo);

    const QUrl url(QStringLiteral("qrc:/content/Screen01.ui.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}