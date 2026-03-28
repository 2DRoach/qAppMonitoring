// SplashView.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qMonitoringApp

Rectangle {
    id: root
    color: AppTheme.bg // Используем ваш синглтон темы

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 20

        // Логотип
        Text {
            text: "Tuwunel"
            font.pixelSize: 48
            font.bold: true
            color: AppTheme.text
            Layout.alignment: Qt.AlignHCenter
        }

        Text {
            text: "Monitoring System"
            font.pixelSize: 16
            color: AppTheme.textSecondary
            Layout.alignment: Qt.AlignHCenter
        }

        // Индикатор загрузки
        BusyIndicator {
            running: true
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: 40
            palette { highlight: AppTheme.accent }
        }
    }

    Timer {
        interval: 2000
        running: true
        onTriggered: {
            Router.replace(Router.pageAddServer)
        }
    }
}