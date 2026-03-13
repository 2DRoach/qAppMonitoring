import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    id: root
    background: Rectangle { color: AppTheme.bg } // Используем тему

    header: ToolBar {
        background: Rectangle { color: AppTheme.surface }
        RowLayout {
            anchors.fill: parent
            ToolButton { text: "←"; onClicked: root.StackView.view.pop(); font.bold: true }
            Label { text: "Settings"; font.bold: true; color: AppTheme.text; Layout.fillWidth: true }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20

        Label { text: "Appearance"; font.bold: true; color: AppTheme.textSecondary; font.pixelSize: 14 }

        Frame {
            Layout.fillWidth: true
            background: Rectangle { color: AppTheme.card; radius: 8 }

            RowLayout {
                width: parent.width
                Label { text: "Dark Mode"; color: AppTheme.text }
                Item { Layout.fillWidth: true }
                Switch {
                    id: themeSwitch
                    checked: AppTheme.darkMode
                    onCheckedChanged: {
                        // Пишем значение в глобальный синглтон
                        AppTheme.darkMode = checked
                    }
                }
            }
        }

        Label { text: "Connection"; font.bold: true; color: AppTheme.textSecondary; font.pixelSize: 14; Layout.topMargin: 20 }

        Frame {
             Layout.fillWidth: true
             background: Rectangle { color: AppTheme.card; radius: 8 }

             ColumnLayout {
                 width: parent.width
                 spacing: 10
                 Label { text: "Server URL"; color: AppTheme.textSecondary }
                 TextField {
                     Layout.fillWidth: true
                     placeholderText: "http://..."
                     color: AppTheme.text
                     background: Rectangle { color: AppTheme.surface; radius: 4 }
                 }
                 Button {
                     text: "Test"
                     Layout.alignment: Qt.AlignRight
                     background: Rectangle { color: AppTheme.accent; radius: 4 }
                     contentItem: Text { text: parent.text; color: "white"; horizontalAlignment: Text.AlignHCenter }
                 }
             }
        }

        Item { Layout.fillHeight: true }
    }
}