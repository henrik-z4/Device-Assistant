#include <QDebug>
#include <QtSql/QSqlQuery>
#include <QtSql/QSqlError>

#include <stdexcept>
#include "database.h"

DatabaseManager::DatabaseManager() {
    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("hardware.db");
    if (!db.open()) {
        throw std::runtime_error("Ошибка при открытии базы данных: " + db.lastError().text().toStdString());
    }
    else {
        qDebug() << "База данных открыта";

        // Таблица видеокарт
        createTable("gpu", "id INTEGER PRIMARY KEY AUTOINCREMENT, brand TEXT, name TEXT, year INTEGER, speed TEXT, memory TEXT, pci_e TEXT, bitness INTEGER, cuda_cores INTEGER, fp32 TEXT, price INTEGER");
        QVariantList data_gpu;
        data_gpu << "NVIDIA" << "NVIDIA GeForce RTX 4090" << 2023 << "2250 МГц" << "24 Гб GDDR6X" << "4.0" << 384 << 16384 << "82,6 TFLOPs" << 220000;
        data_gpu << "NVIDIA" << "NVIDIA GeForce RTX 4080" << 2022 << "2205 МГц" << "16 Гб GDDR6X" << "4.0" << 256 << 9728 << "48,8 TFLOPs" << 150000;
        data_gpu << "NVIDIA" << "NVIDIA GeForce RTX 3090" << 2020 << "1695 МГц" << "24 ГБ" << "PCI-E 4.0" << 384 << 10496 << "35.6 TFLOPS" << 150000;
        insertData("gpu", data_gpu);

        // Таблица накопителей
        createTable("storage", "id INTEGER PRIMARY KEY AUTOINCREMENT, brand TEXT, type TEXT, name TEXT, year INTEGER, speed TEXT, capacity TEXT, price INTEGER");
        QVariantList data_storage;
        data_storage << "Samsung" << "SSD" << "Samsung 980 PRO" << 2021 << "7000 МБ/с" << "1 ТБ" << 20000;
        data_storage << "Samsung" << "SSD" << "Samsung 870 EVO" << 2021 << "560 МБ/с" << "1 ТБ" << 10000;
        data_storage << "Samsung" << "SSD" << "Samsung 870 QVO" << 2020 << "560 МБ/с" << "1 ТБ" << 8000;
        insertData("storage", data_storage);

        // Таблица материнских плат
        createTable("motherboard", "id INTEGER PRIMARY KEY AUTOINCREMENT, brand TEXT, name TEXT, year INTEGER, socket TEXT, form_factor TEXT, memory_slots INTEGER, memory_type TEXT, price INTEGER");
        QVariantList data_motherboard;
        data_motherboard << "ASUS" << "ASUS ROG Strix Z590-E Gaming WiFi" << 2021 << "LGA1200" << "ATX" << 4 << "DDR4" << 30000;
        data_motherboard << "ASUS" << "ASUS ROG Strix Z490-E Gaming" << 2020 << "LGA1200" << "ATX" << 4 << "DDR4" << 25000;
        data_motherboard << "ASUS" << "ASUS ROG Strix Z390-E Gaming" << 2018 << "LGA1151" << "ATX" << 4 << "DDR4" << 20000;
        insertData("motherboard", data_motherboard);

        // Таблица процессоров
        createTable("processor", "id INTEGER PRIMARY KEY AUTOINCREMENT, brand TEXT, name TEXT, year INTEGER, socket TEXT, cores INTEGER, threads INTEGER, speed TEXT, cache TEXT, price INTEGER");
        QVariantList data_processor;
        data_processor << "Intel" << "Intel Core i9-11900K" << 2021 << "LGA1200" << 8 << 16 << "3.5 ГГц" << "16 МБ" << 50000;
        data_processor << "Intel" << "Intel Core i9-10900K" << 2020 << "LGA1200" << 10 << 20 << "3.7 ГГц" << "20 МБ" << 40000;
        data_processor << "Intel" << "Intel Core i9-9900K" << 2018 << "LGA1151" << 8 << 16 << "3.6 ГГц" << "16 МБ" << 30000;
        insertData("processor", data_processor);

        // Таблица оперативной памяти
        createTable("ram", "id INTEGER PRIMARY KEY AUTOINCREMENT, brand TEXT, name TEXT, year INTEGER, speed TEXT, capacity TEXT, type TEXT, price INTEGER");
        QVariantList data_ram;
        data_ram << "HyperX" << "HyperX Fury RGB DDR4-3200" << 2021 << "3200 МГц" << "16 ГБ" << "DDR4" << 10000;
        insertData("ram", data_ram);

    }
}

DatabaseManager::~DatabaseManager() {
    db.close();
}

// Функция создания таблицы БД
void DatabaseManager::createTable(const QString& tableName, const QString& tableStructure) {
    QSqlQuery query;
    query.exec("CREATE TABLE IF NOT EXISTS " + tableName + " (" + tableStructure + ")");
}

// Функция добавления данных в таблицу БД
void DatabaseManager::insertData(const QString& tableName, const QVariantList& data) {
    QSqlQuery query;
    QString strF = "INSERT INTO %1 VALUES(";
    QString strV = "";
    for (int i = 0; i < data.size(); i++) {
        strV += "?,";
    }
    strV = strV.left(strV.length() - 1);
    strV += ")";
    strF = strF.arg(tableName);
    strF += strV;
    query.prepare(strF);

    foreach (const QVariant& v, data) {
        query.addBindValue(v);
    }

    if(!query.exec()) {
        qDebug() << "Непредвиденная ошибка при отправке данных в " << tableName << ": " << query.lastError().text();
    }
}

// Функция вывода данных из таблиц БД
void DatabaseManager::printData(const QString& tableName) {
    QStringList validTableNames = {"Storage", "Motherboard", "Processor", "RAM", "GPU"};

    if (!validTableNames.contains(tableName)) {
        qDebug() << "Недопустимое имя таблицы: " << tableName << ". Зафиксирована попытка SQL-инъекции.";
        return;
    }

    QSqlQuery query;
    query.prepare("SELECT * FROM " + tableName);

    if (!query.exec()) {
        qDebug() << "Ошибка при выполнении запроса: " << query.lastError().text();
        return;
    }

    while (query.next()) {
        if (tableName == "Storage") {
            qDebug() << "id: " << query.value(0).toInt() << " "
                << "brand: " << query.value(1).toString() << " "
                << "type: " << query.value(2).toString() << " "
                << "name: " << query.value(3).toString() << " "
                << "year: " << query.value(4).toInt() << " "
                << "speed: " << query.value(5).toString() << " "
                << "capacity: " << query.value(6).toString() << " "
                << "price: " << query.value(7).toInt();
        }
        else if (tableName == "Motherboard") {
            qDebug() << "id: " << query.value(0).toInt() << " "
                << "brand: " << query.value(1).toString() << " "
                << "name: " << query.value(2).toString() << " "
                << "year: " << query.value(3).toInt() << " "
                << "socket: " << query.value(4).toString() << " "
                << "form_factor: " << query.value(5).toString() << " "
                << "memory_slots: " << query.value(6).toInt() << " "
                << "memory_type: " << query.value(7).toString() << " "
                << "price: " << query.value(8).toInt();
        }
        else if (tableName == "Processor") {
            qDebug() << "id: " << query.value(0).toInt() << " "
                << "brand: " << query.value(1).toString() << " "
                << "name: " << query.value(2).toString() << " "
                << "year: " << query.value(3).toInt() << " "
                << "socket: " << query.value(4).toString() << " "
                << "cores: " << query.value(5).toInt() << " "
                << "threads: " << query.value(6).toInt() << " "
                << "speed: " << query.value(7).toString() << " "
                << "cache: " << query.value(8).toString() << " "
                << "price: " << query.value(9).toInt();
        }
        else if (tableName == "RAM") {
            qDebug() << "id: " << query.value(0).toInt() << " "
                << "brand: " << query.value(1).toString() << " "
                << "name: " << query.value(2).toString() << " "
                << "year: " << query.value(3).toInt() << " "
                << "speed: " << query.value(4).toString() << " "
                << "capacity: " << query.value(5).toString() << " "
                << "type: " << query.value(6).toString() << " "
                << "price: " << query.value(7).toInt();
        }
        else if (tableName == "GPU") {
            qDebug() << "id: " << query.value(0).toInt() << " "
                << "brand: " << query.value(1).toString() << " "
                << "name: " << query.value(2).toString() << " "
                << "year: " << query.value(3).toInt() << " "
                << "speed: " << query.value(4).toString() << " "
                << "memory: " << query.value(5).toString() << " "
                << "pci_e: " << query.value(6).toString() << " "
                << "bitness: " << query.value(7).toInt() << " "
                << "cuda_cores: " << query.value(8).toInt() << " "
                << "fp32: " << query.value(9).toString() << " "
                << "price: " << query.value(10).toInt();
        }
    }
}

// Функция удаления данных из таблицы БД
void DatabaseManager::deleteData(const QString& tableName, int id) {
    QStringList validTableNames = {"Storage", "Motherboard", "Processor", "RAM", "GPU"};
    if (!validTableNames.contains(tableName)) {
        qDebug() << "Недопустимое имя таблицы: " << tableName << ". Зафиксирована попытка SQL-инъекции.";
        return;
    }
    QSqlQuery query;
    query.prepare("DELETE FROM " + tableName + " WHERE id = :id");
    query.bindValue(":id", id);
    query.exec();
}

// Функция обновления данных в таблице БД
void DatabaseManager::updateData(const QString& tableName, int id, const QMap<QString, QVariant>& data) {
    QStringList validTableNames = {"Storage", "Motherboard", "Processor", "RAM", "GPU"};
    if (!validTableNames.contains(tableName)) {
        qDebug() << "Недопустимое имя таблицы: " << tableName << ". Зафиксирована попытка SQL-инъекции.";
        return;
    }

    QStringList columns;
    for (auto it = data.begin(); it != data.end(); ++it) {
        columns.append(it.key() + " = :" + it.key());
    }

    QSqlQuery query;
    query.prepare("UPDATE " + tableName + " SET " + columns.join(", ") + " WHERE id = :id");
    query.bindValue(":id", id);

    for (auto it = data.begin(); it != data.end(); ++it) {
        query.bindValue(":" + it.key(), it.value());
    }

    if (!query.exec()) {
        qDebug() << "Ошибка при обновлении данных: " << query.lastError().text();
    }
}