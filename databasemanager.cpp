/* Данный код лицензирован GNU General Public Licence v3.0
Автор: Мурадян Генрик
По всем вопросам обращайтесь: muradyango@student.bmstu.ru */

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

    QSqlDatabase db = QSqlDatabase::addDatabase("QPSQL");
    db.setHostName("localhost");
    db.setDatabaseName("database");
    db.setUserName("user1");
    db.setPassword("password");

    if (!db.open()) {
        qDebug() << "Не удалось подключиться к базе данных";
    }


}

databasemanager::~databasemanager() {
    QSqlDatabase::database().close();
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
