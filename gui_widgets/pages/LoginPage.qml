// LoginPage.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    id: root
    background: Rectangle { color: AppTheme.bg }

    // === ЗАГЛУШКА ДЛЯ ТЕСТИРОВАНИЯ (Удалите при подключении C++) ===
    QtObject {
        id: fakeAuthManager
        property bool isLoggingIn: false
        signal loginSuccess()
        signal loginFailed(string error)

        function login(user, pass) {
            isLoggingIn = true
            loginTimer.start()
        }

        // Таймер для имитации сетевой задержки

    }
    Timer {
        id: loginTimer
        interval: 1500
        onTriggered: {
            fakeAuthManager.isLoggingIn = false
            // Тестовый логин: admin / 123
            if (usernameInput.text === "admin" && passwordInput.text === "123") {
                console.log("Mock: Login OK")
                fakeAuthManager.loginSuccess()
            } else {
                console.log("Mock: Login Failed")
                fakeAuthManager.loginFailed("Неверный логин или пароль")
            }
        }
    }

    // В реальном проекте используйте настоящий синглтон:
    // property var authManager: AuthManager

    // Используем заглушку для примера
    property var authManager: fakeAuthManager

    // === КОНЕЦ ЗАГЛУШКИ ===

    ColumnLayout {
        anchors.centerIn: parent
        width: Math.min(parent.width * 0.85, 400)
        spacing: AppTheme.spacingM

        // Логотип / Заголовок
        Label {
            text: "qMonitoring"
            font: AppTheme.fontH1
            color: AppTheme.accent
            Layout.alignment: Qt.AlignHCenter
            Layout.bottomMargin: AppTheme.spacingXL
        }

        Label {
            text: "Вход на: " + "Server 1" // Можно привязать к ServerManager
            font: AppTheme.fontCaption
            color: AppTheme.textSecondary
            Layout.alignment: Qt.AlignHCenter
        }

        // Поле логина
        TextField {
            id: usernameInput
            placeholderText: "Логин"
            Layout.fillWidth: true
            text: "admin"
            leftPadding: AppTheme.spacingM
            topPadding: AppTheme.spacingS
            bottomPadding: AppTheme.spacingS

            color: AppTheme.text
            placeholderTextColor: AppTheme.textSecondary
            font: AppTheme.fontBody

            background: Rectangle {
                color: AppTheme.surface
                radius: AppTheme.radiusMedium
                border.color: usernameInput.activeFocus ? AppTheme.accent : AppTheme.border
                border.width: usernameInput.activeFocus ? 2 : 1
            }
        }

        // Поле пароля
        TextField {
            id: passwordInput
            placeholderText: "Пароль"
            echoMode: TextInput.Password
            Layout.fillWidth: true
            text: "123" // Для теста
            leftPadding: AppTheme.spacingM
            topPadding: AppTheme.spacingS
            bottomPadding: AppTheme.spacingS

            color: AppTheme.text
            placeholderTextColor: AppTheme.textSecondary
            font: AppTheme.fontBody

            background: Rectangle {
                color: AppTheme.surface
                radius: AppTheme.radiusMedium
                border.color: passwordInput.activeFocus ? AppTheme.accent : AppTheme.border
                border.width: passwordInput.activeFocus ? 2 : 1
            }
        }

        // Текст ошибки
        Label {
            id: errorLabel
            Layout.fillWidth: true
            text: ""
            color: AppTheme.danger
            font: AppTheme.fontCaption
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
            Layout.topMargin: AppTheme.spacingXS

            // Анимация появления
            opacity: text === "" ? 0 : 1
            Behavior on opacity { NumberAnimation { duration: AppTheme.durationShort } }
        }

        // Кнопка входа
        Button {
            id: loginBtn
            text: authManager.isLoggingIn ? "" : "Войти"
            Layout.fillWidth: true
            Layout.topMargin: AppTheme.spacingS
            enabled: !authManager.isLoggingIn
            implicitHeight: AppTheme.touchHeight

            // Индикатор загрузки внутри кнопки
            BusyIndicator {
                anchors.centerIn: parent
                running: authManager.isLoggingIn
                visible: running
                // Маленький размер для кнопки
                implicitWidth: 24
                implicitHeight: 24
            }

            background: Rectangle {
                color: loginBtn.down ? AppTheme.accentPressed : AppTheme.accent
                radius: AppTheme.radiusMedium
                // Плавная смена цвета
                Behavior on color { ColorAnimation { duration: AppTheme.durationShort } }
            }

            contentItem: Text {
                text: loginBtn.text
                font: AppTheme.fontBody
                color: "white" // Белый текст на акцентной кнопке
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            onClicked: {
                errorLabel.text = "" // Сброс ошибки
                authManager.login(usernameInput.text, passwordInput.text)
            }
        }
    }

    // === Обработка логики ===

    // Анимация "тряски" при ошибке
    SequentialAnimation {
        id: shakeAnimation
        loops: 2
        NumberAnimation { target: root.contentItem; property: "x"; to: 10; duration: 50; easing.type: Easing.OutQuad }
        NumberAnimation { target: root.contentItem; property: "x"; to: -10; duration: 100; easing.type: Easing.OutQuad }
        NumberAnimation { target: root.contentItem; property: "x"; to: 0; duration: 50; easing.type: Easing.OutQuad }
    }

    Connections {
        target: authManager

        function onLoginSuccess() {
            // Переход на главный экран через ваш Router
            Router.goToMain()
        }

        function onLoginFailed(error) {
            errorLabel.text = error
            shakeAnimation.start() // Трясем форму при ошибке
        }
    }
}