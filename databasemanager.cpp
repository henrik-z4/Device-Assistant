#include "databasemanager.h"
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlError>
#include <QFile>
#include <QTextStream>
#include <QStringDecoder>
#include <QDir>
#include <QRegularExpression>

databasemanager::databasemanager() {
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    QDir dir(QDir::currentPath() + "/data");
    if (!dir.exists()) {
        dir.mkpath(".");
    }
    QString dbPath = dir.absolutePath() + "/gpu_database.db";
    qDebug() << "Database path:" << dbPath;
    db.setDatabaseName(dbPath);
    if (db.open()) {
        qDebug() << "Database opened successfully";
        QSqlQuery query;
        if (!query.exec("CREATE TABLE IF NOT EXISTS gpu (name TEXT, price REAL)")) {
            qDebug() << "Error creating table:" << query.lastError();
            return;
        }
    } else {
        qDebug() << "Error opening database:" << db.lastError();
        return;
    }
}

databasemanager::~databasemanager() {
    QSqlDatabase::database().close();
}

void databasemanager::loadDataFromFile() {
    QSqlQuery checkQuery;
    checkQuery.prepare("SELECT COUNT(*) FROM gpu");
    if (checkQuery.exec() && checkQuery.next() && checkQuery.value(0).toInt() > 0) {
        return;
    }

    QFile file("tools/Parser/gpu_parsed.txt");
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qDebug() << file.errorString();
        return;
    }

    QTextStream in(&file);
    static QRegularExpression rx("(\\d+)"); // Make the QRegularExpression object static

    while (!in.atEnd()) {
        QString line = in.readLine();
        QStringList fields = line.split("||");

        if (fields.size() >= 2) {
            QString gpuName = fields[0].trimmed().remove(0, 6);
            QString priceString = fields[1].trimmed();
            qDebug() << "Price string:" << priceString;

            QRegularExpressionMatch match = rx.match(priceString);
            QStringList list;

            while (match.hasMatch()) {
                list << match.captured(1);
                match = rx.match(priceString, match.capturedEnd(1));
            }

            double price = list.join("").toDouble();

            insertData(gpuName, price);
        }
    }
}

void databasemanager::insertData(const QString &gpuName, double price) {
    qDebug() << "Inserting data:" << gpuName << price;
    QSqlQuery query;
    query.prepare("INSERT INTO gpu (name, price) VALUES (?, ?)");
    query.addBindValue(gpuName);
    query.addBindValue(price);
    if (!query.exec()) {
        qDebug() << "Error inserting data:" << query.lastError();
    }
}

QSqlQuery databasemanager::queryData() {
    qDebug() << "Querying data";
    QSqlQuery query;
    query.prepare("SELECT * FROM gpu");
    if (!query.exec()) {
        qDebug() << "Error querying data:" << query.lastError();
    }

    while (query.next()) {
        QString name = query.value("name").toString();
        double price = query.value("price").toDouble();
        qDebug() << "Name:" << name << ", Price:" << price;
    }

    return query;
}