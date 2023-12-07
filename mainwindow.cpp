#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QSysInfo>
#include <QDebug>
#include <QtSql/QSqlDatabase>
#include <QtSql/QSqlQuery>

#include "systeminfo.h"

MainWindow::MainWindow(QWidget* parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    // Получение информации о характеристиках ПК
    QString osInfo = "Операционная система: " + QSysInfo::prettyProductName();
    QString cpuInfo = "Архитектура: " + QSysInfo::currentCpuArchitecture();
    QString ramInfo = "Оперативная память: " + QString::number(QSysInfo::availableVirtualMemory() / (1024 * 1024)) + " Мегабайт";

    // Вывод характеристик в консоль (в будущем в GUI)
    qDebug() << osInfo;
    qDebug() << cpuInfo;
    qDebug() << ramInfo;

    getGpuInfo(); //Тест функции получения названия видеокарты
    getStorageInfo(); //Тест функции получения информации о накопителе
    getMotherboardInfo(); //Тест функции получения информации о материнской плате
    getProcessorInfo(); //Тест функции получения информации о процессоре

    
    DatabaseManager dbManager;
    // Вывод таблицы БД
    dbManager.printData("gpu");
    dbManager.printData("storage");
    dbManager.printData("motherboard");
    dbManager.printData("processor");
    dbManager.printData("ram");
    
}

MainWindow::~MainWindow()
{
    delete ui;
}
