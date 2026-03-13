import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    id: root
    background: Rectangle { color: AppTheme.bg }

    header: ToolBar {
        background: Rectangle { color: AppTheme.surface }
        RowLayout {
            ToolButton { text: "←"; onClicked: stackView.pop(); font.bold: true }
            Label { text: "Storage Manager"; font.bold: true; color: AppTheme.text; Layout.fillWidth: true }
        }
    }

    ScrollView {
        anchors.fill: parent
        clip: true

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 15
            spacing: 20

            // === Блок SMART ===
            Label { text: "S.M.A.R.T. Status"; font.bold: true; color: AppTheme.text }

            Frame {
                Layout.fillWidth: true
                background: Rectangle { color: AppTheme.card; radius: 8 }

                ColumnLayout {
                    width: parent.width
                    spacing: 10

                    RowLayout {
                        Text { text: "Drive: /dev/sda"; color: AppTheme.text; font.bold: true }
                        Item { Layout.fillWidth: true }
                        Rectangle { width: 10; height: 10; radius: 5; color: AppTheme.accent } // Green dot
                        Text { text: "PASSED"; color: AppTheme.accent }
                    }

                    Text { text: "Temperature: 35°C"; color: AppTheme.textSecondary }
                    Text { text: "Power On Hours: 8760 h"; color: AppTheme.textSecondary }
                    Text { text: "Reallocated Sectors: 0"; color: AppTheme.textSecondary }
                }
            }

            // === Блок Бекапа ===
            Label { text: "Backup Management"; font.bold: true; color: AppTheme.text; Layout.topMargin: 10 }

            Frame {
                Layout.fillWidth: true
                background: Rectangle { color: AppTheme.card; radius: 8 }

                ColumnLayout {
                    width: parent.width
                    spacing: 15

                    Text { text: "External Device: SanDisk Ultra (32GB)"; color: AppTheme.text }

                    Button {
                        Layout.fillWidth: true
                        text: "Create Backup Now"
                        background: Rectangle { color: AppTheme.accent; radius: 5 }
                        contentItem: Text {
                            text: parent.text; color: "white";
                            horizontalAlignment: Text.AlignHCenter
                            font.bold: true
                        }
                        onClicked: console.log("Start Backup...")
                    }

                    ProgressBar {
                        Layout.fillWidth: true
                        value: 0.0 // Менять значение при бекапе
                        indeterminate: false
                        visible: false // Показывать только во время процесса
                    }
                }
            }

            Item { Layout.fillHeight: true }
        }
    }
}