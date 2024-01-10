#include "gpu_db_model.h"
#include "databasemanager.h"

gpu_db_model::gpu_db_model(QObject *parent) : QSqlQueryModel(parent), dbManager(new databasemanager()) {
    this->updateModel();
}

void gpu_db_model::updateModel() {
    this->setQuery(dbManager->queryData());
}

gpu_db_model::~gpu_db_model() {
    delete dbManager;
}