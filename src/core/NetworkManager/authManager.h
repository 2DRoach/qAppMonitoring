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
public:
    explicit AuthManager(const QUrl& baseUrl, QObject* parent = nullptr);
    void login(QString& username, QString& password);
    void logout();
    TokenPayLoad currentToken() const;
    AuthState state() const;
signals:
    void authenticated(const TokenPayLoad& token);
    void authFailed(const QString& error);
    void stateChanged(AuthState state);
    void tokenExpire();

public slots:
    // void onLoginReplyFinidhed();
    // void onTokenCheckTimout();
private:
    void internalRelogin();
    void shecduleTokenCheck();
    QByteArray m_savedUser;
    QByteArray m_savedPass;
    TokenPayLoad m_token;
    QDeadlineTimer m_tokenTimer;
    AuthState m_state;
};

#endif // AUTHMANAGER_H
