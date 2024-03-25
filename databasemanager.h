#ifndef DATABASEMANAGER_H
#define DATABASEMANAGER_H

#include <QSqlQuery>

class databasemanager {
public:
    databasemanager();
    ~databasemanager();
    QSqlQuery queryData();
};

#endif // DATABASEMANAGER_H
