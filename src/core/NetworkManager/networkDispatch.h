#ifndef NETWORKDISPATCH_H
#define NETWORKDISPATCH_H

#include <QObject>
#include <QUrlQuery>
#include <QNetworkReply>
#include <QNetworkAccessManager>
#include <QQmlEngine>

class NetworkDispatch : public QObject {
    Q_OBJECT
    Q_DISABLE_COPY(NetworkDispatch)
    QML_ELEMENT
public:
    bool setUrl(QUrl url);
    explicit NetworkDispatch(QObject *parent = nullptr);
    QNetworkReply* sendGet(const QString& path, const QUrlQuery& query = {}, const QString& token = {});
    QNetworkReply* sendPostForm(const QString& path, const QByteArray& formData);
private:
    void applyHeaders(QNetworkRequest& req, const QString& token);
    QNetworkAccessManager* m_manager;
    QUrl m_baseUrl;
};

#endif // NETWORKDISPATCH_H
