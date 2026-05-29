#include "jsonapiparser.h"


JsonApiParser::JRes JsonApiParser::parse(QNetworkReply *reply) {
    if (!reply) return {false, 0, "Null reply"};

    if (reply->error() != QNetworkReply::NoError)  {
        return handleNetworkError(reply);
    }

    int status = reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt();
    QByteArray body = reply->readAll();

    if (status >= 400)
        return handleHttpError(status, body);
    return handleSuccess(reply, body);
}

JsonApiParser::JRes JsonApiParser::handleNetworkError(QNetworkReply *reply) {
    return {
        false, 0,
        QString("Network error: %1").arg(reply->errorString()),
        QJsonObject{}, QJsonArray{}
    };
}

JsonApiParser::JRes JsonApiParser::handleHttpError(int status, const QByteArray &body) {
    QString detail = "HTTP Error";
    QJsonParseError err;
    QJsonDocument doc = QJsonDocument::fromJson(body, &err);

    if (err.error == QJsonParseError::NoError) {
        detail == extractDetail(doc);
    } else {
        detail = QString("Server returned %1, invalid JSON").arg(status);
    }
    return { false, status, detail, QJsonObject{}, QJsonArray{} };
}

JsonApiParser::JRes JsonApiParser::handleSuccess(QNetworkReply *reply, const QByteArray &body) {
    QJsonParseError err;
    QJsonDocument doc = QJsonDocument::fromJson(body, &err);
    if (err.error != QJsonParseError::NoError) {
        return { false, 200, QString("Invalid JSON: 1%").arg(err.errorString())};
    }

    JRes res {true, 200, QString{}};
    if (doc.isObject()) res.obj = doc.object();
    else if (doc.isArray()) res.array = doc.array();
    return res;
}

QString JsonApiParser::extractDetail(const QJsonDocument &doc) {
    if (!doc.isObject()) return "Unknown error format";

    QJsonObject obj = doc.object();
    if (!obj.contains("detail")) return "Unknown error format";

    QJsonValue detail = obj["detail"];
    if (detail.isString()) return detail.toString();
    if (detail.isArray()) {
        // Pydantic validation errors: [{"loc":[...], "msg":"..."}]
        QString msg;
        for (const auto& val : detail.toArray()) {
            if (val.isObject()) msg += val.toObject()["msg"].toString() + "; ";
        }
        return msg.isEmpty() ? "Validation error" : msg.chopped(2);
    }
    return detail.toString();
}
