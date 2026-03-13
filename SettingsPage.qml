import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "." // Нужно для доступа к AppTheme, если он в той же папке

Page {
    id: root
    background: Rectangle { color: AppTheme.bg }

    header: ToolBar {
        background: Rectangle { color: AppTheme.surface }
        RowLayout {
            anchors.fill: parent
            ToolButton { text: "←"; onClicked: root.StackView.view.pop() }
            Label { text: "Settings"; font.bold: true; color: AppTheme.text; Layout.fillWidth: true }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20

        // 1. Переключатель темы
        Label { text: "Appearance"; font.bold: true; color: AppTheme.text; font.pixelSize: 16 }

        Frame {
            Layout.fillWidth: true
            background: Rectangle { color: AppTheme.card; radius: 8 }

            RowLayout {
                width: parent.width
                Label { text: "Dark Mode"; color: AppTheme.text }
                Item { Layout.fillWidth: true }
                Switch {
                    checked: AppTheme.darkMode
                    onCheckedChanged: AppTheme.darkMode = checked
                }
            }
        }

        // 2. Настройки подключения
        Label { text: "Connection"; font.bold: true; color: AppTheme.text; font.pixelSize: 16; Layout.topMargin: 20 }

        Frame {
            Layout.fillWidth: true
            background: Rectangle { color: AppTheme.card; radius: 8 }

            ColumnLayout {
                width: parent.width
                spacing: 10

                Label { text: "Server URL (Agent API)"; color: AppTheme.textSecondary }
                TextField {
                    id: urlInput
                    Layout.fillWidth: true
                    placeholderText: "http://192.168.1.100:8080"
                    text: "http://localhost:8080" // Mock
                    color: AppTheme.text
                    background: Rectangle {
                        color: AppTheme.surface
                        radius: 4
                        border.color: "#444"
                    }
                }

                Button {
                    text: "Test Connection"
                    Layout.alignment: Qt.AlignRight
                    onClicked: console.log("Pinging " + urlInput.text)
                }
            }
        }

        Item { Layout.fillHeight: true }
    }
}