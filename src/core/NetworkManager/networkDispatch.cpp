#include "networkDispatch.h"


bool NetworkDispatch::setUrl(QUrl url) {
    if (!url.isValid()) {
        qWarning() << "Incorrect URL";
        return false;
    }
    return true;
}

NetworkDispatch::NetworkDispatch(QObject *parent) {
    m_manager = new QNetworkAccessManager(this);
}

QNetworkReply* NetworkDispatch::sendGet(const QString &path, const QUrlQuery& query, const QString& token) {
    QNetworkRequest request(m_baseUrl.resolved(QUrl(path)));
    applyHeaders(request, token);
    if (!query.isEmpty()) {
        QUrl url = request.url();
        url.setQuery(query);
        request.setUrl(url);
    }
    return m_manager->get(request);
}

QNetworkReply* NetworkDispatch::sendPostForm(const QString &path, const QByteArray &formData) {
    QNetworkRequest request(m_baseUrl.resolved(QUrl(path)));
    applyHeaders(request, formData);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/x-www-form-urlencoded");
    QNetworkReply* reply = m_manager->post(request, formData);
    return reply;
}

void NetworkDispatch::applyHeaders(QNetworkRequest &req, const QString &token) {
    if (!token.isEmpty()) {
        req.setRawHeader("Authorization", "Bearer " + token.toUtf8());
    }
    req.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    req.setRawHeader("Accept", "application/json");
}
