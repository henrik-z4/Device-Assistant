#ifndef DATABASE_H
#define DATABASE_H

#include <QtSql/QSqlDatabase>

class DatabaseManager {
public:
    DatabaseManager();
    ~DatabaseManager();
    void createTable();
    void insertData(const QString& name, int year, const QString& speed, const QString& memory, const QString& pci_e, int bitness, int cuda_cores, const QString& fp32, int price);
    void printData();

private:
    QSqlDatabase db;
};

#endif // DATABASE_H