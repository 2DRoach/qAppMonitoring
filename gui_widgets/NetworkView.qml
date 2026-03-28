// NetworkPage.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qMonitoringApp

Page {
    id: root
    title: "Сеть"
    background: Rectangle { color: AppTheme.bg }

    header: ToolBar {
        background: Rectangle { color: AppTheme.surface }
        RowLayout {
            anchors.fill: parent
            ToolButton {
                text: "←"
                font.pixelSize: 20
                // ИСПРАВЛЕНО: Используем StackView.view
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
        id: scrollView // ID нужен для привязки ширины
        anchors.fill: parent
        clip: true
        ScrollBar.horizontal.policy: ScrollBar.AsNeeded

        // ИСПРАВЛЕНО: Обернули всё в один ColumnLayout
        ColumnLayout {
            // Привязка ширины к ScrollView, чтобы контент растягивался
            width: scrollView.availableWidth - 40
            x: 20 // Отступ слева
            spacing: 20

            // === Статистика ===
            GridLayout {
                Layout.fillWidth: true
                columns: 2
                rowSpacing: 15
                columnSpacing: 15

                Rectangle {
                    Layout.fillWidth: true
                    height: 100
                    color: AppTheme.card
                    radius: 12
                    clip: true

                    Column {
                        anchors.centerIn: parent
                        spacing: 5
                        Label {
                            text: "📤 Отправка"
                            color: AppTheme.textSecondary
                            font.pixelSize: 12
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        Label {
                            text: "1.2 GB"
                            color: "#4CAF50"
                            font.pixelSize: 24
                            font.bold: true
                        }
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    height: 100
                    color: AppTheme.card
                    radius: 12
                    clip: true

                    Column {
                        anchors.centerIn: parent
                        spacing: 5
                        Label {
                            text: "📥 Получение"
                            color: AppTheme.textSecondary
                            font.pixelSize: 12
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        Label {
                            text: "8.5 GB"
                            color: "#2196F3"
                            font.pixelSize: 24
                            font.bold: true
                        }
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    height: 100
                    color: AppTheme.card
                    radius: 12
                    clip: true

                    Column {
                        anchors.centerIn: parent
                        spacing: 5
                        Label {
                            text: "⬆️ Скорость отправки"
                            color: AppTheme.textSecondary
                            font.pixelSize: 12
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        Label {
                            text: "5.2 Mbit/s"
                            color: AppTheme.text
                            font.pixelSize: 20
                            font.bold: true
                        }
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    height: 100
                    color: AppTheme.card
                    radius: 12
                    clip: true

                    Column {
                        anchors.centerIn: parent
                        spacing: 5
                        Label {
                            text: "⬇️ Скорость получения"
                            color: AppTheme.textSecondary
                            font.pixelSize: 12
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        Label {
                            text: "25.8 Mbit/s"
                            color: AppTheme.text
                            font.pixelSize: 20
                            font.bold: true
                        }
                    }
                }
            }

            // === Интерфейсы ===
            Label {
                text: "Сетевые интерфейсы"
                color: AppTheme.textSecondary
                font.pixelSize: 14
                font.bold: true
                Layout.topMargin: 10
            }

            // ИСПРАВЛЕНО: Заменили ListView на Column + Repeater
            // Это убирает конфликт прокрутки и позволяет элементам растягиваться
            Column {
                Layout.fillWidth: true
                spacing: 8

                Repeater {
                    model: ListModel {
                        ListElement { name: "eth0"; ip: "192.168.1.100"; status: "active"; }
                        ListElement { name: "wlan0"; ip: "192.168.1.105"; status: "active"; }
                        ListElement { name: "docker0"; ip: "172.17.0.1"; status: "active"; }
                    }

                    delegate: Rectangle {
                        width: parent.width // Растягивается на всю ширину
                        height: 70
                        color: AppTheme.card
                        radius: 8
                        clip: true

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 15
                            spacing: 15

                            Label {
                                text: model.name
                                color: AppTheme.text
                                font.pixelSize: 16
                                font.bold: true
                                Layout.fillWidth: true
                            }

                            Label {
                                text: model.ip
                                color: AppTheme.textSecondary
                                font.pixelSize: 12
                            }

                            Rectangle {
                                width: 10
                                height: 10
                                radius: 5
                                color: model.status === "active" ? "#4CAF50" : "#F44336"
                            }
                        }
                    }
                }
            }

            // Распорка снизу
            Item { Layout.fillHeight: true }
        }
    }
}