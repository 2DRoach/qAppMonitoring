// AddServerPage.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
// import com.tuwunel.core 1.0

Page {
    id: root
    background: Rectangle { color: AppTheme.bg }

    property bool isChecking: false

    Flickable {
        id: flickable
        anchors.fill: parent

        // ВАЖНО: Область контента должна быть ограничена
        contentWidth: width
        // Высота контента = высота колонки + отступы сверху/снизу
        contentHeight: columnLayout.implicitHeight + 100

        // Глобальный "тухлик" для снятия фокуса при клике на пустоту
        MouseArea {
            anchors.fill: parent
            onClicked: root.focus = true // Убираем фокус с TextField
        }

        // === ВАШ КОНТЕНТ ДОЛЖЕН БЫТЬ ЗДЕСЬ (ВНУТРИ FLICKABLE) ===
        ColumnLayout {
            id: columnLayout

            // Привязываем к границам Flickable
            anchors.top: parent.top
            anchors.topMargin: 100 // Отступ сверху
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 30
            anchors.rightMargin: 30
            spacing: 20

            Label {
                text: "Добавить сервер"
                font.pixelSize: 24
                font.bold: true
                color: AppTheme.text
                Layout.alignment: Qt.AlignHCenter
            }

            Label {
                text: "Введите адрес и имя для нового подключения"
                color: AppTheme.textSecondary
                Layout.alignment: Qt.AlignHCenter
                wrapMode: Text.WordWrap
                Layout.fillWidth: true
            }

            TextField {
                id: nameInput
                placeholderText: "Имя (например: Мой Сервер)"
                Layout.fillWidth: true

                background: Rectangle {
                    color: AppTheme.surface
                    radius: 8
                    border.color: nameInput.activeFocus ? AppTheme.accent : "transparent"
                }
                color: AppTheme.text
            }

            TextField {
                id: urlInput
                placeholderText: "Адрес (например: 192.168.1.5:8000)"
                Layout.fillWidth: true
                text: "http://"
                background: Rectangle {
                    color: AppTheme.surface
                    radius: 8
                    border.color: urlInput.activeFocus ? AppTheme.accent : "transparent"
                }
                color: AppTheme.text
            }

            Button {
                text: root.isChecking ? "Проверка..." : "Добавить"
                Layout.fillWidth: true
                enabled: !root.isChecking && nameInput.text !== "" && urlInput.text !== ""

                background: Rectangle {
                    color: parent.enabled ? AppTheme.accent : AppTheme.textSecondary
                    radius: 10
                }
                contentItem: Text {
                    text: parent.text
                    color: "white"
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: {
                    root.isChecking = true;
                    // Логика будет позже
                    console.log("Add server clicked")
                }
            }

            // Распорка снизу, чтобы можно было прокрутить контент выше клавиатуры
            Item {
                Layout.preferredHeight: 100
            }
        }
    } // <--- Flickable закрывается ЗДЕСЬ, после всего контента

    // Connections должен быть внутри Page, но снаружи Flickable (или внутри - не важно, он просто слушает)
    // Но так как ServerManager закомментирован, этот блок вызовет ошибку.
    // Лучше его пока тоже закомментировать.
    /*
    Connections {
        target: ServerManager
        function onServerAdded(success, message) {
            root.isChecking = false;
            if (!success) {
                console.warn("Error adding server:", message);
            }
        }
    }
    */
}