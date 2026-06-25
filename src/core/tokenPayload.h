#pragma once

#include <QString>
#include <QMetaType>
#include <QObject>

struct TokenPayLoad
{
    Q_GADGET
    Q_PROPERTY(QString token      READ token        CONSTANT)
    Q_PROPERTY(QString tokenType  READ tokenType    CONSTANT)
    Q_PROPERTY(qint64  expireAtSec READ expireAtSec CONSTANT)

public:
    explicit TokenPayLoad(const QString& token,
                          const QString& tokenType,
                          qint64 expireAtSec)
        : m_token(token)
        , m_tokenType(tokenType)
        , m_expireAtSec(expireAtSec) {}

    QString token() const noexcept { return m_token; }
    QString tokenType() const noexcept { return m_tokenType; }
    qint64  expireAtSec() const noexcept { return m_expireAtSec; }

    bool isValid(qint64 currentSec) const {
        return !m_token.isEmpty() && currentSec < m_expireAtSec;
    }

private:
    QString m_token;
    QString m_tokenType;
    qint64  m_expireAtSec;
};

Q_DECLARE_METATYPE(TokenPayLoad)
