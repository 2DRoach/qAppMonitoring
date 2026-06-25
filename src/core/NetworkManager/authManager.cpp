#include "authManager.h"


AuthManager::AuthManager(QObject *parent)
    : AuthManager(QUrl("")){}

AuthManager::AuthManager(const QUrl& baseUrl, QObject* parent)
    : m_token("", "", 0), m_baseUrl(baseUrl)
    , QObject(parent), m_state(AuthState::Idle)
{}

void AuthManager::onLoginReply() {
}

void AuthManager::onTokenCheckTimout() {
}

void AuthManager::internalRelogin() {
    if (!m_login.isEmpty() && !m_password.isEmpty()) {
        qWarning() << "No credentials found for silent re-login. Forcing logout.";
        logout();
        return;
    }


}

void AuthManager::scheduleTokenCheck() {
    qint64 now = QDateTime::currentMSecsSinceEpoch();
    if (!m_token.isValid(now)) {
        m_state = AuthState::Expired;
        emit stateChanged(m_state);
        internalRelogin();
        return;
    }
}

void AuthManager::login(const QString& username, const QString& password) {


}

void AuthManager::logout() {
}
