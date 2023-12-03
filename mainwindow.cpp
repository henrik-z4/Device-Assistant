#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QSysInfo>
#include <QDebug>
#include "gpuinfo.h"

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent), ui(new Ui::MainWindow) {
    ui->setupUi(this);
    // Получение информации о характеристиках PC
    QString osInfo = "Операционная система: " + QSysInfo::prettyProductName();
    QString cpuInfo = "Архитектура: " + QSysInfo::currentCpuArchitecture();
    QString ramInfo = "Оперативная память: " + QString::number(QSysInfo::availableVirtualMemory() / (1024 * 1024)) + " Мегабайт";

    // Вывод характеристик в консоль (в будущем в GUI)
    qDebug() << osInfo;
    qDebug() << cpuInfo;
    qDebug() << ramInfo;

    getGpuInfo(); //Тест функции получения названия видеокарты
}

MainWindow::~MainWindow() {
    delete ui;
}
