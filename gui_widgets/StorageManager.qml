import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qMonitoringApp // Добавлен импорт

Page {
    id: root
    background: Rectangle { color: AppTheme.bg }

    header: ToolBar {
        background: Rectangle { color: AppTheme.surface }
        RowLayout {
            anchors.fill: parent
            ToolButton {
                text: "←"
                font.pixelSize: 20
                onClicked: root.StackView.view.pop()
                contentItem: Label {
                    text: parent.text
                    font.pixelSize: parent.font.pixelSize
                    color: AppTheme.text
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
            Label {
                text: "Storage Manager"
                font.pixelSize: 18
                font.bold: true
                color: AppTheme.text
                Layout.fillWidth: true
            }
        }
    }

    ScrollView {
        id: scrollView
        anchors.fill: parent
        clip: true

        ColumnLayout {
            // Привязка ширины к ScrollView
            width: scrollView.availableWidth - 40
            x: 20
            spacing: 20

            // === Блок SMART ===
            Label {
                text: "S.M.A.R.T. Status"
                font.bold: true
                font.pixelSize: 16
                color: AppTheme.text
            }

            // Карточка SMART
            Rectangle {
                Layout.fillWidth: true
                color: AppTheme.card
                radius: 12

                // ИСПРАВЛЕНИЕ ВЫСОТЫ: ColumnLayout не закреплен якорями,
                // а просто занимает место. Rectangle подстраивается под него.
                ColumnLayout {
                    id: smartLayout
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.margins: 15
                    spacing: 10

                    RowLayout {
                        Layout.fillWidth: true
                        Label {
                            text: "Drive: /dev/sda"
                            color: AppTheme.text
                            font.bold: true
                            font.pixelSize: 15
                        }
                        Item { Layout.fillWidth: true }
                        Rectangle {
                            width: 10; height: 10; radius: 5
                            color: AppTheme.accent
                        }
                        Label {
                            text: "PASSED"
                            color: AppTheme.accent
                            font.bold: true
                        }
                    }

                    // Используем Label вместо Text для поддержки темы
                    Label { text: "Temperature: 35°C"; color: AppTheme.textSecondary }
                    Label { text: "Power On Hours: 8760 h"; color: AppTheme.textSecondary }
                    Label { text: "Reallocated Sectors: 0"; color: AppTheme.textSecondary }
                }

                // Растягиваем фон под контент
                height: smartLayout.implicitHeight + 30
            }

            // === Блок Бекапа ===
            Label {
                text: "Backup Management"
                font.bold: true
                font.pixelSize: 16
                color: AppTheme.text
                Layout.topMargin: 10
            }

            // Карточка Бекапа
            Rectangle {
                Layout.fillWidth: true
                color: AppTheme.card
                radius: 12

                ColumnLayout {
                    id: backupLayout
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.margins: 15
                    spacing: 15

                    RowLayout {
                        spacing: 10
                        Label { text: "💾"; font.pixelSize: 20 }
                        Label {
                            text: "External Device: SanDisk Ultra (32GB)"
                            color: AppTheme.text
                            font.pixelSize: 14
                            Layout.fillWidth: true
                            wrapMode: Text.Wrap // Перенос текста, если длинный
                        }
                    }

                    Button {
                        Layout.fillWidth: true
                        text: "Create Backup Now"
                        background: Rectangle {
                            color: parent.pressed ? Qt.darker(AppTheme.accent) : AppTheme.accent
                            radius: 8
                        }
                        contentItem: Label {
                            text: parent.text
                            color: "#FFFFFF"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.bold: true
                        }
                        onClicked: console.log("Start Backup...")
                    }

                    ProgressBar {
                        Layout.fillWidth: true
                        value: 0.0
                        visible: value > 0 // Показываем только если есть прогресс
                        background: Rectangle { color: AppTheme.surface; radius: 4 }
                        contentItem: Rectangle {
                            implicitHeight: 6
                            color: AppTheme.accent
                            radius: 4
                            width: parent.visualPosition * parent.width
                        }
                    }
                }

                // Растягиваем фон под контент
                height: backupLayout.implicitHeight + 30
            }

            // Распорка снизу
            Item { Layout.fillHeight: true }
        }
    }
}