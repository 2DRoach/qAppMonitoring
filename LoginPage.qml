// LoginPage.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
// import com.tuwunel.auth 1.0

Page {
    id: root
    background: Rectangle { color: AppTheme.bg }

    ColumnLayout {
        anchors.centerIn: parent
        width: parent.width * 0.8
        spacing: 15

        Label {
            // Показываем имя сервера из C++
            text: "Вход на: " + (ServerManager.currentServerName || "Сервер")
            font.pixelSize: 14
            color: AppTheme.textSecondary
            Layout.alignment: Qt.AlignHCenter
        }

        TextField {
            id: usernameInput
            placeholderText: "Логин"
            Layout.fillWidth: true
            text: "admin" // По умолчанию
            // Стилизация...
        }

        TextField {
            id: passwordInput
            placeholderText: "Пароль"
            echoMode: TextInput.Password
            Layout.fillWidth: true
            // Стилизация...
        }

        Button {
            id: loginBtn
            text: "Войти"
            Layout.fillWidth: true
            enabled: !AuthManager.isLoggingIn

            background: Rectangle {
                color: loginBtn.enabled ? AppTheme.accent : AppTheme.card
                radius: 10
            }

            onClicked: {
                // AuthManager.login(usernameInput.text, passwordInput.text);
            }
        }
    }

    // Обработка результата
    Connections {
        target: AuthManager
        function onLoginFailed(error) {
            // Показать тост или покрасить поля в красный
            console.log("Login failed:", error);
        }
    }
}