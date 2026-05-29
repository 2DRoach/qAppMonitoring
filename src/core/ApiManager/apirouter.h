#ifndef APIROUTER_H
#define APIROUTER_H

#include <QObject>
#include <QUrl>
class ApiRouter : public QObject
{
    Q_OBJECT
    QUrl m_base;
public:
    explicit ApiRouter(QUrl, QObject *parent = nullptr);
    enum class Endpoint { Dashboard, Processes, Kill, Login };

    struct RequestConfig { QUrl url; QString method; };
    RequestConfig resolve(Endpoint endpoint) {
        switch (endpoint) {
            case Endpoint::Login: return {m_base.resolved(QUrl("/api/v1/token")), "post"};
            case Endpoint::Dashboard: return {m_base.resolved(QUrl("/api/v1/dashboard")), "get"};
            case Endpoint::Processes: return {m_base.resolved(QUrl("/api/v1/processes")), "get"};
            case Endpoint::Kill: return {m_base.resolved(QUrl("/api/v1/processes")), "post"};
        }
        return {m_base, "GET"};
    }
};
#endif // APIROUTER_H
