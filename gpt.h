#ifndef GPT_H
#define GPT_H

#include <QObject>
#include <QString>

class GPT : public QObject {
    Q_OBJECT

public:
    explicit GPT(QObject *parent = nullptr);

    Q_INVOKABLE QString getResponse(const QString &prompt);

signals:
    void responseReceived(const QString &response);

private:
    QString get_response_from_gpt(const QString &prompt);
};

#endif // GPT_H
