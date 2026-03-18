// RAMView.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qMonitoringApp

Page {
    id: root
    property var stackView

    background: Rectangle { color: AppTheme.bg }

    header: ToolBar {
        background: Rectangle { color: AppTheme.surface }
        RowLayout {
            anchors.fill: parent
            ToolButton {
                text: "←"
                onClicked: root.StackView.view.pop()
                contentItem: Label { text: parent.text; font.pixelSize: 20; color: AppTheme.text }
            }
            Label {
                text: "🧠 Оперативная память"
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
            Rectangle {
                Layout.fillWidth: true
                height: 150
                color: AppTheme.card
                radius: 10

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 10

                    RowLayout {
                        Layout.fillWidth: true
                        Label {
                            text: "Использовано"
                            color: AppTheme.textSecondary
                        }
                        Item { Layout.fillWidth: true }
                        Label {
                            text: "6.5 GB"
                            color: AppTheme.text
                            font.pixelSize: 24
                            font.bold: true
                        }
                    }

                    RowLayout {
                        Layout.fillWidth: true
                        Label {
                            text: "Всего"
                            color: AppTheme.textSecondary
                        }
                        Item { Layout.fillWidth: true }
                        Label {
                            text: "8.0 GB"
                            color: AppTheme.text
                            font.pixelSize: 24
                        }
                    }

                    ProgressBar {
                        Layout.fillWidth: true
                        value: 0.82
                        background: Rectangle { color: AppTheme.surface; radius: 5 }
                        contentItem: Rectangle { color: "#2196F3"; radius: 5; width: parent.width * parent.parent.value }
                    }

                    Label {
                        text: "82% занято"
                        color: "#FF9800"
                        font.pixelSize: 14
                        font.bold: true
                    }
                }
            }

            // === Swap ===
            Label {
                text: "💾 Swap"
                color: AppTheme.text
                font.pixelSize: 16
                font.bold: true
            }

            Rectangle {
                Layout.fillWidth: true
                height: 60
                color: AppTheme.card
                radius: 8

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 15
                    Label { text: "Использовано"; color: AppTheme.textSecondary }
                    Item { Layout.fillWidth: true }
                    Label { text: "0.5 / 2.0 GB (25%)"; color: AppTheme.text; font.bold: true }
                }
            }

            // === Топ процессов по RAM ===
            Label {
                text: "🔝 Топ-5 процессов по RAM"
                color: AppTheme.text
                font.pixelSize: 16
                font.bold: true
                Layout.topMargin: 10
            }

            Repeater {
                model: [
                    { name: "chrome", ram: 1250, pid: 1234 },
                    { name: "code", ram: 890, pid: 5678 },
                    { name: "docker", ram: 520, pid: 9012 },
                    { name: "python3", ram: 340, pid: 3456 },
                    { name: "systemd", ram: 120, pid: 1 }
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

                        Label { text: index + 1; color: AppTheme.textSecondary; width: 25 }
                        Label { text: modelData.name; color: AppTheme.text; Layout.fillWidth: true }
                        Label { text: "PID " + modelData.pid; color: AppTheme.textSecondary; font.pixelSize: 11 }
                        Label { text: modelData.ram + " MB"; color: "#2196F3"; font.pixelSize: 14; font.bold: true; width: 70; horizontalAlignment: Text.AlignRight }
                    }
                }
            }

            // === Кнопка системного монитора ===
            Button {
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                text: "📊 Открыть системный монитор"
                background: Rectangle { color: parent.pressed ? AppTheme.surface : "#2196F3"; radius: 10 }
                contentItem: Label { text: parent.text; color: "#FFFFFF"; font.pixelSize: 16; font.bold: true; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
                onClicked: console.log("Открываем системный монитор...")
            }

            Item { Layout.fillHeight: true }
        }
    }
}