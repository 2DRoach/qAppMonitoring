#ifndef NETWORKDISPATCH_H
#define NETWORKDISPATCH_H

#include <QObject>
#include <QUrlQuery>
#include <QNetworkReply>
#include <QNetworkAccessManager>
#include <QQmlEngine>

class NetworkDispatch : public QObject {
    Q_OBJECT
    QML_ELEMENT
public:
    bool setUrl(QUrl url);
    explicit NetworkDispatch(QObject *parent = nullptr);
    NetworkDispatch(const NetworkDispatch&) = delete;
    NetworkDispatch& operator=(const NetworkDispatch&) = delete;

    NetworkDispatch(NetworkDispatch&&) = delete;
    NetworkDispatch& operator=(NetworkDispatch&&) = delete;

    QNetworkReply* sendPostForm(const QString& path, const QByteArray& formData);
    QNetworkReply* sendGet(const QString& path, const QUrlQuery& query = {}, const QString& token = {});
private:
    void applyHeaders(QNetworkRequest& req, const QString& token);
    QNetworkAccessManager* m_manager;
    QUrl m_baseUrl;
};

#endif // NETWORKDISPATCH_H
