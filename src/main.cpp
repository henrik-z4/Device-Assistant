// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDir>
#include <QWindow>

#include "app_environment.h"
#include "import_qml_components_plugins.h"
#include "import_qml_plugins.h"
#include "../systeminfo.h"
#include "../gpt.h"
#include "../databasemanager.h"
#include "../gpu_db_model.h"


int main(int argc, char *argv[])
{
    set_qt_environment();
    QGuiApplication app(argc, argv);
    app.setWindowIcon(QIcon(":/assets/icons/DeviceAssistant.jpg"));


    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/assets/icons/DeviceAssistant.jpg")));


    engine.rootContext()->setContextProperty("applicationDirPath", QDir::toNativeSeparators(QCoreApplication::applicationDirPath()));

    systeminfo sysInfo;
    engine.rootContext()->setContextProperty("sysInfo", &sysInfo);

    GPT gpt;
    engine.rootContext()->setContextProperty("gpt", &gpt);
    qmlRegisterType<GPT>("GPT", 1, 0, "GPT");

    databasemanager dbManager;
    dbManager.loadDataFromFile();
    dbManager.queryData();

    gpu_db_model gpuModel;
    engine.rootContext()->setContextProperty("gpuModel", &gpuModel);

    const QUrl url(u"qrc:/qt/qml/Main/main.qml"_qs);
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);

    engine.addImportPath(QCoreApplication::applicationDirPath() + "/qml");
    engine.addImportPath(":/");

    engine.load(url);

    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    return app.exec();
}
