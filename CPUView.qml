// CPUView.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qMonitoringApp

Page {
    id: root
    property var stackView

    // background: Rectangle { color: AppTheme.bg }

    header: ToolBar {
        background: Rectangle { color: AppTheme.surface }
        RowLayout {
            anchors.fill: parent
            ToolButton {
                text: "←"
                onClicked: StackView.view.pop()
                contentItem: Label {
                    text: parent.text
                    font.pixelSize: 20
                    color: AppTheme.text
                }
            }
            Label {
                text: "🖥️ Процессор"
                font.pixelSize: 18
                font.bold: true
                color: AppTheme.text
            }
            Item { Layout.fillWidth: true }
        }
    }

    ScrollView {
        anchors.fill: parent
        contentWidth: availableWidth

        ColumnLayout {
            width: parent.width
            anchors.margins: 20
            spacing: 20

            // === Основная статистика ===
            RowLayout {
                Layout.fillWidth: true
                spacing: 15

                // Общая загрузка
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 120
                    color: AppTheme.card
                    radius: 10
                    clip: true

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 15
                        spacing: 5

                        Label {
                            text: "Общая загрузка"
                            color: AppTheme.textSecondary
                            font.pixelSize: 12
                        }
                        Label {
                            text: "45%"
                            color: AppTheme.text
                            font.pixelSize: 28
                            font.bold: true
                        }
                        ProgressBar {
                            Layout.fillWidth: true
                            value: 0.45
                            background: Rectangle {
                                color: AppTheme.surface
                                radius: 5
                            }
                            contentItem: Rectangle {
                                implicitWidth: 100
                                color: "#4CAF50"
                                radius: 5
                                width: parent.width * parent.parent.value
                            }
                        }
                    }
                }

                // Температура
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 120
                    color: AppTheme.card
                    radius: 10

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 15
                        spacing: 5

                        Label {
                            text: "Температура"
                            color: AppTheme.textSecondary
                            font.pixelSize: 12
                        }
                        Label {
                            text: "62°C"
                            color: "#FF9800"
                            font.pixelSize: 28
                            font.bold: true
                        }
                        Label {
                            text: "Норма"
                            color: AppTheme.textSecondary
                            font.pixelSize: 11
                        }
                    }
                }
            }

            // === Ядра ===
            Label {
                text: "📈 Загрузка по ядрам"
                color: AppTheme.text
                font.pixelSize: 16
                font.bold: true
            }

            Repeater {
                model: 4
                Rectangle {
                    Layout.fillWidth: true
                    height: 50
                    color: AppTheme.card
                    radius: 8

                    RowLayout {
                        anchors.fill: parent
                        anchors.leftMargin: 15
                        anchors.rightMargin: 15
                        spacing: 15

                        Label {
                            text: "Ядро " + (index + 1)
                            color: AppTheme.text
                            font.pixelSize: 14
                        }
                        Item { Layout.fillWidth: true }
                        ProgressBar {
                            Layout.preferredWidth: 100
                            value: [0.55, 0.32, 0.78, 0.21][index]
                            background: Rectangle {
                                color: AppTheme.surface
                                radius: 4
                            }
                            contentItem: Rectangle {
                                color: "#4CAF50"
                                radius: 4
                                width: parent.width * parent.parent.value
                            }
                        }
                        Label {
                            text: Math.round([0.55, 0.32, 0.78, 0.21][index] * 100) + "%"
                            color: AppTheme.text
                            font.pixelSize: 14
                            width: 45
                            horizontalAlignment: Text.AlignRight
                        }
                    }
                }
            }

            // === Топ процессов ===
            Label {
                text: "🔝 Топ-5 процессов по CPU"
                color: AppTheme.text
                font.pixelSize: 16
                font.bold: true
                Layout.topMargin: 10
            }

            Repeater {
                model: [
                    { name: "chrome", cpu: 12.5, pid: 1234 },
                    { name: "python3", cpu: 8.3, pid: 5678 },
                    { name: "docker", cpu: 5.1, pid: 9012 },
                    { name: "systemd", cpu: 2.4, pid: 1 },
                    { name: "sshd", cpu: 0.8, pid: 3456 }
                ]

                Rectangle {
                    Layout.fillWidth: true
                    height: 55
                    color: index % 2 === 0 ? AppTheme.card : AppTheme.surface
                    radius: 8

                    RowLayout {
                        anchors.fill: parent
                        anchors.leftMargin: 15
                        anchors.rightMargin: 15
                        spacing: 10

                        Label {
                            text: index + 1
                            color: AppTheme.textSecondary
                            font.pixelSize: 14
                            width: 25
                        }
                        Label {
                            text: modelData.name
                            color: AppTheme.text
                            font.pixelSize: 14
                            Layout.fillWidth: true
                        }
                        Label {
                            text: "PID " + modelData.pid
                            color: AppTheme.textSecondary
                            font.pixelSize: 11
                        }
                        Label {
                            text: modelData.cpu.toFixed(1) + "%"
                            color: "#4CAF50"
                            font.pixelSize: 14
                            font.bold: true
                            width: 55
                            horizontalAlignment: Text.AlignRight
                        }
                    }
                }
            }

            // === Кнопка системного монитора ===
            Button {
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                text: "📊 Открыть системный монитор"
                background: Rectangle {
                    color: parent.pressed ? AppTheme.surface : AppTheme.accent
                    radius: 10
                }
                contentItem: Label {
                    text: parent.text
                    color: "#FFFFFF"
                    font.pixelSize: 16
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: {
                    // Здесь вызов внешнего мониторинга
                    console.log("Открываем системный монитор...")
                }
            }

            Item { Layout.fillHeight: true }
        }
    }
}