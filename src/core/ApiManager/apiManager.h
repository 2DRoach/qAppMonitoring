#ifndef APIMANAGER_H
#define APIMANAGER_H

#include <QQueue>
#include <QObject>

#include <QUrl>
#include <QNetworkReply>
class ApiManager : public QObject {
    Q_OBJECT
public:
    enum class Endpoint { Dashboard, Processes, Kill, Login };
    Q_ENUM(Endpoint)

    explicit ApiManager(const QUrl& baseUrl, QObject* parent = nullptr);
    QString pathFor(Endpoint ep) const;
    void handleReply(QNetworkReply* reply, Endpoint expectedType);
signals:
    void dashboardReady(const QJsonObject& data);
    void processesReady(const QJsonArray& data);
    void killCompleted(int pid, bool success, const QString& reason);
    void loginResponseReady(const QJsonObject& tokenData);
    void apiError(const QString& message, int httpCode);
private:
    QUrl m_baseUrl;
};

#endif // APIMANAGER_H
