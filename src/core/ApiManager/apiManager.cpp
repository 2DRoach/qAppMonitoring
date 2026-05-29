#include "apiManager.h"
#include "../jsonapiparser.h"
ApiManager::ApiManager(const QUrl &baseUrl, QObject *parent)
    : m_baseUrl(baseUrl), QObject(parent) {}

QString ApiManager::pathFor(Endpoint ep) const
{
    switch (ep) {
    case Endpoint::Login: return "/api/v1/token";
    case Endpoint::Dashboard: return "/api/v1/dashboard";
    case Endpoint::Processes: return "/api/v1/processes";
    case Endpoint::Kill: return "/api/v1/process";
    }
    return {};
}

void ApiManager::handleReply(QNetworkReply *reply, Endpoint expectedType) {
    if (!reply) {
        emit apiError("Null network reply", 0);
        return;
    }

    auto res = JsonApiParser::parse(reply);
    if (!res.success) {
        emit apiError(res.errorMessage, res.httpCode);
        return;
    }

    switch (expectedType) {
    case Endpoint::Kill:
        emit killCompleted(-1, true, QString{});
        break;
    case Endpoint::Login:break;
        emit loginResponseReady(res.obj);
        break;
    case Endpoint::Dashboard:
        emit dashboardReady(res.obj);
        break;
    case Endpoint::Processes:
        emit processesReady(res.array);
        break;
    }

}

