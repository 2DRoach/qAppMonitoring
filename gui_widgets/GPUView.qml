// GPUInfoPage.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
// import qMonitoringApp

Page {
    id: root
    property var stackView

    title: "Информация о GPU"
    background: Rectangle { color: AppTheme.bg }

    header: ToolBar {
        background: Rectangle { color: AppTheme.surface }
        RowLayout {
            anchors.fill: parent
            ToolButton {
                text: "←"
                font.pixelSize: 20
                onClicked: Router.pop()
                contentItem: Label {
                    text: parent.text
                    font.pixelSize: parent.font.pixelSize
                    color: AppTheme.text
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
            Label {
                text: root.title
                font.pixelSize: 18
                font.bold: true
                color: AppTheme.text
            }
        }
    }

    ScrollView {
        id: scrollView // ВАЖНО: Даем ID ScrollView
        anchors.fill: parent
        clip: true
        // Запрещаем горизонтальный скролл, так как контент подстроится под ширину
        ScrollBar.horizontal.policy: ScrollBar.AsNeeded

        GridLayout {
            // ИСПРАВЛЕНИЕ СЖАТИЯ: Ширина привязана к ширине ScrollView минус отступы
            width: scrollView.availableWidth - 40
            x: 20 // Отступ слева
            columns: 2
            rowSpacing: 15
            columnSpacing: 15

            // === Карточка: Адаптеры ===
            Rectangle {
                Layout.fillWidth: true
                height: 120
                color: AppTheme.card
                radius: 12
                clip: true

                Column {
                    anchors.centerIn: parent
                    spacing: 10
                    Label { text: "🎮 GPU Адаптеры"; color: AppTheme.textSecondary; font.pixelSize: 14; horizontalAlignment: Text.AlignHCenter }
                    Label { text: "1"; color: AppTheme.accent; font.pixelSize: 36; font.bold: true; horizontalAlignment: Text.AlignHCenter }
                    Label { text: "NVIDIA GeForce RTX 3060"; color: AppTheme.text; font.pixelSize: 12; horizontalAlignment: Text.AlignHCenter }
                }
            }

            // === Карточка: Температура ===
            Rectangle {
                Layout.fillWidth: true
                height: 120
                color: AppTheme.card
                radius: 12
                clip: true

                Column {
                    anchors.centerIn: parent
                    spacing: 10
                    Label { text: "🌡️ Температура"; color: AppTheme.textSecondary; font.pixelSize: 14; horizontalAlignment: Text.AlignHCenter }
                    Label { text: "42°C"; color: "#4CAF50"; font.pixelSize: 36; font.bold: true; horizontalAlignment: Text.AlignHCenter }
                    Label { text: "Норма (макс: 83°C)"; color: AppTheme.textSecondary; font.pixelSize: 11; horizontalAlignment: Text.AlignHCenter }
                }
            }

            // === Карточка: Драйвер ===
            Rectangle {
                Layout.fillWidth: true
                Layout.columnSpan: 2
                height: 100
                color: AppTheme.card
                radius: 12
                clip: true

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 15

                    Label { text: "🔧"; font.pixelSize: 32 }
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 5
                        Label { text: "Драйвер"; color: AppTheme.textSecondary; font.pixelSize: 12 }
                        Label { text: "NVIDIA 535.104.05"; color: AppTheme.text; font.pixelSize: 14; font.bold: true }
                        Label { text: "CUDA 12.2"; color: AppTheme.textSecondary; font.pixelSize: 11 }
                    }
                }
            }

            // === Карточка: Память GPU ===
            Rectangle {
                Layout.fillWidth: true
                Layout.columnSpan: 2
                height: 100
                color: AppTheme.card
                radius: 12
                clip: true

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 15

                    Label { text: "💾"; font.pixelSize: 32 }
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 5
                        Label { text: "VRAM"; color: AppTheme.textSecondary; font.pixelSize: 12 }
                        Label { text: "4.2 / 12 GB"; color: AppTheme.text; font.pixelSize: 14; font.bold: true }

                        ProgressBar {
                            Layout.fillWidth: true
                            value: 0.35
                            background: Rectangle { color: AppTheme.surface; radius: 4 }
                            contentItem: Rectangle {
                                implicitHeight: 6
                                color: "#9C27B0"
                                radius: 4
                                width: parent.width * parent.value
                            }
                        }
                    }
                }
            }

            // === Кнопки действий (на всю ширину) ===
            Button {
                text: "📊 Открыть мониторинг GPU"
                Layout.fillWidth: true
                Layout.columnSpan: 2 // Занимает 2 колонки
                background: Rectangle { color: parent.pressed ? AppTheme.card : AppTheme.accent; radius: 8 }
                contentItem: Label { text: parent.text; color: "#FFFFFF"; horizontalAlignment: Text.AlignHCenter; font.bold: true }
                onClicked: console.log("Открыть GPU мониторинг")
            }

            Button {
                text: "🔄 Обновить данные"
                Layout.fillWidth: true
                Layout.columnSpan: 2 // Занимает 2 колонки
                background: Rectangle {
                    color: parent.pressed ? AppTheme.card : AppTheme.surface
                    radius: 8
                    border.color: AppTheme.textSecondary
                    border.width: 1
                }
                contentItem: Label { text: parent.text; color: AppTheme.text; horizontalAlignment: Text.AlignHCenter }
                onClicked: console.log("Обновить данные GPU")
            }

            // Распорка снизу
            Item { Layout.fillHeight: true; Layout.columnSpan: 2 }
        }
    }
}