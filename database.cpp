#include <QDebug>
#include <QtSql/QSqlQuery>
#include <QtSql/QSqlError>

#include "database.h"

DatabaseManager::DatabaseManager() {
    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("hardware.db");
    db.open();
    if (!db.open()) {
        qDebug() << "Ошибка при открытии базы данных: " << db.lastError();
        return;
    }
    else {
        qDebug() << "База данных открыта";
        createTable();
        insertData("NVIDIA GeForce RTX 4090", 2023, "2250 МГц", "24 Гб GDDR6X", "4.0", 384, 16384, "82,6 TFLOPs", 220000);
        insertData("NVIDIA GeForce RTX 4080", 2022, "2205 МГц", "16 Гб GDDR6X", "4.0", 256, 9728, "48,8 TFLOPs", 150000);
        insertData("NVIDIA GeForce RTX 3090", 2020, "1695 МГц", "24 ГБ", "PCI-E 4.0", 384, 10496, "35.6 TFLOPS", 150000);

    }
}

DatabaseManager::~DatabaseManager() {
    db.close();
}

// Функция создания таблицы БД
void DatabaseManager::createTable() {
    QSqlQuery query;
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
}

// Функция добавления данных в таблицу БД. Может понадобиться в будущем
void DatabaseManager::insertData(const QString& name, int year, const QString& speed, const QString& memory, const QString& pci_e, int bitness, int cuda_cores, const QString& fp32, int price) {
    QSqlQuery query;
    query.prepare("INSERT INTO gpu (name, year, speed, memory, pci_e, bitness, cuda_cores, fp32, price) VALUES (:name, :year, :speed, :memory, :pci_e, :bitness, :cuda_cores, :fp32, :price)");
    query.bindValue(":name", name);
    query.bindValue(":year", year);
    query.bindValue(":speed", speed);
    query.bindValue(":memory", memory);
    query.bindValue(":pci_e", pci_e);
    query.bindValue(":bitness", bitness);
    query.bindValue(":cuda_cores", cuda_cores);
    query.bindValue(":fp32", fp32);
    query.bindValue(":price", price);
    query.exec();
}

//Функция вывода данных из таблицы БД
void DatabaseManager::printData() {
    QSqlQuery query;
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

// Функция удаления данных из таблицы БД.
void DatabaseManager::deleteData(int id) {
    QSqlQuery query;
    query.prepare("DELETE FROM gpu WHERE id = :id");
    query.bindValue(":id", id);
    query.exec();
}

// Функция обновления данных в таблице БД.
void DatabaseManager::updateData(int id, const QString& name, int year, const QString& speed, const QString& memory, const QString& pci_e, int bitness, int cuda_cores, const QString& fp32, int price) {
    QSqlQuery query;
    query.prepare("UPDATE gpu SET name = :name, year = :year, speed = :speed, memory = :memory, pci_e = :pci_e, bitness = :bitness, cuda_cores = :cuda_cores, fp32 = :fp32, price = :price WHERE id = :id");
    query.bindValue(":id", id);
    query.bindValue(":name", name);
    query.bindValue(":year", year);
    query.bindValue(":speed", speed);
    query.bindValue(":memory", memory);
    query.bindValue(":pci_e", pci_e);
    query.bindValue(":bitness", bitness);
    query.bindValue(":cuda_cores", cuda_cores);
    query.bindValue(":fp32", fp32);
    query.bindValue(":price", price);
    query.exec();
}

