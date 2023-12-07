#ifndef DATABASE_H
#define DATABASE_H

#include <QtSql/QSqlDatabase>

class DatabaseManager {
public:
    DatabaseManager();
    ~DatabaseManager();
    void createTable();
    void insertData(const QString& name, const QString& description);
    void printData();

private:
    QSqlDatabase db;
};

#endif // DATABASE_H