import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root

    // Интерфейс для C++ модели или ручной настройки
    property string title: "CPU"
    property double loadValue: 0.0 // 0.0 ... 1.0
    property string subTitle: "0 / 8 Cores"
    property color accentColor: "#4CAF50" // Зеленый, синий и т.д.

    implicitHeight: 120
    implicitWidth: 180
    radius: 12
    color: AppTheme.card

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 15
        spacing: 8

        // Заголовок
        Text {
            text: root.title
            font.pixelSize: 14
            color: AppTheme.textSecondary
            font.weight: Font.DemiBold
            Layout.fillWidth: true
        }

        // Значение (Большими цифрами)
        Text {
            text: Math.round(root.loadValue * 100) + "%"
            font.pixelSize: 28
            font.bold: true
            color: AppTheme.text
        }

        // Прогресс бар
        ProgressBar {
            id: bar
            from: 0
            to: 1
            value: root.loadValue

            Layout.fillWidth: true
            implicitHeight: 6

            // Кастомный стиль бара (Backed + Content)
            background: Rectangle {
                radius: 3
                color: AppTheme.surface
            }

            contentItem: Rectangle {
                implicitHeight: 6
                implicitWidth: bar.visualPosition * bar.width
                radius: 3
                color: root.accentColor
            }
        }

        // Доп. инфо (например, температура)
        Text {
            text: root.subTitle
            font.pixelSize: 12
            color: AppTheme.textSecondary
        }
    }
}