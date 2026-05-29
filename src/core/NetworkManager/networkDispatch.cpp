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

// NetworkDispatch::NetworkDispatch(const QUrl& baseUrl, QObject *parent) {
//     m_manager = new QNetworkAccessManager(this);
// }

QNetworkReply* NetworkDispatch::sendGet(const QString &path, const QUrlQuery& query, const QString& token) {
    QUrl url = m_baseUrl.resolved(QUrl(path));
    if (!query.isEmpty()) url.setQuery(query);
    QNetworkRequest req(url);
    return m_manager->get(req);
}

QNetworkReply* NetworkDispatch::sendPostForm(const QString &path, const QByteArray &formData) {
    QUrl url = m_baseUrl.resolved(QUrl(path));
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/x-www-form-urlencoded");
    QNetworkReply* reply = m_manager->post(request, formData);
    return reply;
}


