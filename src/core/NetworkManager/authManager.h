#ifndef AUTHMANAGER_H
#define AUTHMANAGER_H

#include <QObject>
#include <QQmlEngine>
#include <QDeadlineTimer>
#include "../tokenPayload.h"

enum class AuthState {Idle, Logging, Aunthenticated, Expired};

class AuthManager : public QObject {
    Q_OBJECT
    Q_DISABLE_COPY_MOVE(AuthManager)
    QML_ELEMENT
    QML_SINGLETON
public:
    explicit AuthManager(QObject* parent = nullptr);
    explicit AuthManager(const QUrl& baseUrl, QObject* parent = nullptr);
    void login(const QString& username, const QString& password);
    void logout();

    TokenPayLoad currentToken() const {
        return m_token;
    }
    AuthState state() const {
        return m_state;
    }
signals:
    void authenticated(const TokenPayLoad& token);
    void authFailed(const QString& error);
    void stateChanged(AuthState state);
    void tokenExpire();

public slots:
    void onLoginReply();
    void onTokenCheckTimout();
private:
    void internalRelogin();
    void scheduleTokenCheck();
    QByteArray m_savedUser;
    QByteArray m_savedPass;
    TokenPayLoad m_token;
    QDeadlineTimer m_tokenTimer;
    AuthState m_state;
    QString m_login;
    QString m_password;
    QUrl m_baseUrl;

};

template<typename>
constexpr auto AuthManager::qt_create_metaobjectdata() {
}
#endif // AUTHMANAGER_H
