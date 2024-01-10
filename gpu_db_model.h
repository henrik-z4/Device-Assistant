#ifndef GPU_DB_MODEL_H
#define GPU_DB_MODEL_H

#include <QSqlQueryModel>

class databasemanager;

class gpu_db_model : public QSqlQueryModel
{
    Q_OBJECT
public:
    explicit gpu_db_model(QObject *parent = nullptr);
    ~gpu_db_model();

private:
    databasemanager *dbManager;
    void updateModel();
};

#endif // GPU_DB_MODEL_H