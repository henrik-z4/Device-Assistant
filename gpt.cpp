#include "gpt.h"
#include <QProcess>

QString GPT::getResponse(const QString &prompt) {
    // Получение ответа от GPT модели на основе заданного промпта
    QString response = get_response_from_gpt(prompt);
    emit responseReceived(response);
    return response;
}

QString GPT::get_response_from_gpt(const QString &prompt) {
    // Запуск процесса Python для вызова обертки и передачи промпта
    QProcess process;
    process.start("python", QStringList() << "wrapper.py" << prompt);
    process.waitForFinished();
    return process.readAllStandardOutput();
}
