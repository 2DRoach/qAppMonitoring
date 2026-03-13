// NetworkPage.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qMonitoringApp

Page {
    id: root
    property var stackView

    title: "Сеть"
    background: Rectangle { color: AppTheme.bg }

    header: ToolBar {
        background: Rectangle { color: AppTheme.surface }
        RowLayout {
            anchors.fill: parent
            ToolButton {
                text: "←"
                font.pixelSize: 20
                color: AppTheme.text
                onClicked: stackView.pop()
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
        anchors.fill: parent
        clip: true

        ColumnLayout {
            width: parent.width
            anchors.margins: 20
            spacing: 20

            // === Статистика ===
            GridLayout {
                columns: 2
                Layout.fillWidth: true
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
            }

            ListView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                spacing: 8
                model: ListModel {
                    ListElement { name: "eth0"; ip: "192.168.1.100"; status: "active"; }
                    ListElement { name: "wlan0"; ip: "192.168.1.105"; status: "active"; }
                    ListElement { name: "docker0"; ip: "172.17.0.1"; status: "active"; }
                }

                delegate: Rectangle {
                    width: parent.width
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

            Item { Layout.fillHeight: true }
        }
    }
}