import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qMonitoringApp
Page {
    id: root
    property var stackView
    background: Rectangle { color: AppTheme.bg } // Матовый черный фон
    implicitWidth: 0
    implicitHeight: 0

    header: ToolBar {
        background: Rectangle { color: AppTheme.surface }
        RowLayout {
            anchors.fill: parent
            Label {
                text: "Tuwunel Admin"
                font.pixelSize: 20
                font.bold: true
                color: AppTheme.text
                leftPadding: 20
            }
            Item { Layout.fillWidth: true } // Spacer
            ToolButton { text: "⚙️"; onClicked: root.stackView.push("SettingsPage.qml") }
        }
    }

    ScrollView {
        id: scrollView
        anchors.fill: parent
        clip: true
        contentWidth: availableWidth

        ColumnLayout {
            width: scrollView.width
            anchors.margins: 20
            spacing: 20

            // === СЕКЦИЯ: Нагрузка ===
            Label {
                text: "System Load"
                font.pixelSize: 16
                color: AppTheme.textSecondary
                font.bold: true
            }

            // GridLayout сам растянет карточки, если место позволит
            // На телефоне будет 1 колонка, на планшете 2 или 3
            GridLayout {
                columns: 2
                Layout.fillWidth: true
                rowSpacing: 15
                columnSpacing: 15

                MetricCard {
                    title: "CPU"
                    loadValue: 0.45
                    subTitle: "2.4 GHz"
                    accentColor: "#4CAF50"
                    Layout.fillWidth: true

                    // Подключаемся к сигналу clicked
                    onClicked: root.stackView.push("ProcessView.qml")
                }


                MetricCard {
                    title: "RAM"
                    loadValue: 0.82
                    subTitle: "6.5 / 8 GB"
                    accentColor: "#2196F3"
                    Layout.fillWidth: true
                    onClicked: root.stackView.push("ProcessView.qml")
                }

                MetricCard {
                    title: "GPU (ENC)"
                    loadValue: 0.10
                    subTitle: "Idle"
                    accentColor: "#9C27B0" // Фиолетовый для GPU
                    Layout.fillWidth: true
                    visible: true // Можно скрывать, если нет GPU
                    onClicked: root.stackView.push("ProcessView.qml")
                }

                MetricCard {
                    title: "Network I/O"
                    loadValue: 0.30 // Условная нагрузка канала
                    subTitle: "30 Mbit/s"
                    accentColor: "#FF9800"
                    Layout.fillWidth: true
                    onClicked: root.stackView.push("ProcessView.qml")
                }


            }

            // === СЕКЦИЯ: Диски ===
            Label {
                text: "Storage Health"
                font.pixelSize: 16
                color: "#888"
                font.bold: true
                Layout.topMargin: 20
            }

            ColumnLayout {
                spacing: 5
                Layout.fillWidth: true

                //Mock список дисков
                DiskDelegate {
                    mountPoint: "/ (System)"
                    usedSpace: 0.45
                    totalSpace: "256 GB"
                    healthStatus: "Healthy"
                    Layout.fillWidth: true
                    // onClicked: root.stackView.push("StorageManagerPage.qml")

                }

                DiskDelegate {
                    mountPoint: "/var/lib/matrix (Data)"
                    usedSpace: 0.92
                    totalSpace: "1 TB"
                    healthStatus: "Warning" // Почти полный диск
                    Layout.fillWidth: true
                    // onClicked: root.stackView.push("StorageManagerPage.qml")
                }
            }

            Item { Layout.fillHeight: true } // Push content up
        }
    }
}