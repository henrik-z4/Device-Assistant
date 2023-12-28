#ifndef DATABASE_H
#define DATABASE_H

#include <QtSql/QSqlDatabase>
#include <QMap>

class DatabaseManager {
public:
    DatabaseManager();
    ~DatabaseManager();
    void printData(const QString& tableName);
    void deleteData(const QString& tableName, int id);
    void updateData(const QString& tableName, int id, const QMap<QString, QVariant>& data);

private:
    QSqlDatabase db;
};

#endif // DATABASE_H