#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QSysInfo>
#include <QDebug>

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent), ui(new Ui::MainWindow) {
    ui->setupUi(this);
    // Получение информации о характеристиках ПК
    QString osInfo = "Операционная система: " + QSysInfo::prettyProductName();
    QString cpuInfo = "Архитектура: " + QSysInfo::currentCpuArchitecture();
    QString ramInfo = "Оперативная память: " + QString::number(QSysInfo::availableVirtualMemory() / (1024 * 1024)) + " Мегабайт";

    // Вывод характеристик в консоль (в будущем в GUI)
    qDebug() << osInfo;
    qDebug() << cpuInfo;
    qDebug() << ramInfo;
}

MainWindow::~MainWindow() {
    delete ui;
}
