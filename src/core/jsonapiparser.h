#ifndef JSONAPIPARSER_H
#define JSONAPIPARSER_H

#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QString>
class JsonApiParser
{

public:
    explicit JsonApiParser(QObject *parent = nullptr);
    struct JRes {
        bool success = false;
        int httpCode = 0;
        QString errorMessage;
        QJsonObject obj; // dashboard, token, single error
        QJsonArray array;
    };
    static JRes parse(QNetworkReply* reply);

private:
    static JRes handleNetworkError(QNetworkReply* reply);
    static JRes handleHttpError(int statusCode, const QByteArray& body);
    static JRes handleSuccess(QNetworkReply* reply, const QByteArray& body);
    static QString extractDetail(const QJsonDocument& doc);
};

#endif // JSONAPIPARSER_H
