#ifndef DATABASEMANAGER_H
#define DATABASEMANAGER_H

#include <QSqlQuery>

class databasemanager {
public:
    databasemanager();
    ~databasemanager();
    void insertData(const QString &gpuName, double price);
    void loadDataFromFile();
    QSqlQuery queryData();
};

#endif // DATABASEMANAGER_H