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

    // Добавление базы данных
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("hardware.db");
    db.open();
    if (!db.open()) {
        qDebug() << "Ошибка при открытии базы данных: " << db.lastError();
        return;
    }
    else {
        qDebug() << "База данных открыта";
    }

    QSqlQuery query;

    // Создание таблицы
    query.exec("CREATE TABLE IF NOT EXISTS gpu ("        
    "id INTEGER PRIMARY KEY AUTOINCREMENT, "
           "name TEXT, "
           "year INTEGER, "
           "speed TEXT, "
           "memory TEXT, "
           "pci_e TEXT, "
           "bitness INTEGER, "
           "cuda_cores INTEGER, "
           "fp32 TEXT, "
           "price INTEGER)");

    // Добавление записей
    query.exec("INSERT INTO gpu (name, year, speed, memory, pci_e, bitness, cuda_cores, fp32, price) "
           "VALUES ('NVIDIA GeForce RTX 4090', '2023', '2250 МГц', '24 Гб GDDR6X', '4.0', 384, 16384, '82,6 TFLOPs', 220000)");
    query.exec("INSERT INTO gpu (name, year, speed, memory, pci_e, bitness, cuda_cores, fp32, price) "
           "VALUES ('NVIDIA GeForce RTX 4080', '2022', '2205 МГц', '16 Гб GDDR6X', '4.0', 256, 9728, '48,8 TFLOPs', 150000)");
    query.exec("INSERT INTO gpu (name, year, speed, memory, pci_e, bitness, cuda_cores, fp32, price) "
            "VALUES ('NVIDIA GeForce RTX 3090', '2020',  '1695 МГц', '24 ГБ', 'PCI-E 4.0', 384, 10496, '35.6 TFLOPS', 150000)");
    
    // Вывод таблицы
    query.exec("SELECT * FROM gpu");
    while (query.next()) {
        int id = query.value(0).toInt();
        QString name = query.value(1).toString();
        int year = query.value(2).toInt();
        QString speed = query.value(3).toString();
        QString memory = query.value(4).toString();
        QString pci_e = query.value(5).toString();
        int bitness = query.value(6).toInt();
        int cuda_cores = query.value(7).toInt();
        QString fp32 = query.value(8).toString();
        int price = query.value(9).toInt();
        qDebug() << id << name << year << speed << memory << pci_e << bitness << cuda_cores << fp32 << price;
    }


}

MainWindow::~MainWindow()
{
    delete ui;
}
