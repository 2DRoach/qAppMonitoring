import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    property string title: "CPU"
    property double loadValue: 0.0
    property string subTitle: "0 / 8 Cores"
    property color accentColor: "#4CAF50"

    // Сигнал для клика (чистая архитектура)
    signal clicked()

    implicitHeight: 130
    implicitWidth: 180
    radius: 16 // Более сильное скругление

    // === ДИНАМИКА ===

    // 1. Цвет фона с анимацией (плавная смена темы)
    color: AppTheme.card
    Behavior on color { ColorAnimation { duration: 300 } }

    // 2. Тень (эффект поднятия)
    layer.enabled: true
    // В QML простую тень можно сделать через border, но лучше так:
    Rectangle {
        anchors.fill: parent
        anchors.margins: -2
        z: -1
        radius: parent.radius + 2
        color: "transparent"
        border.color: AppTheme.darkMode ? "#333" : "#ccc"
        border.width: 1
        opacity: 0.5
    }

    // 3. Реакция на нажатие (как кнопка)
    property bool isPressed: mouseArea.pressed
    scale: isPressed ? 0.96 : 1.0
    Behavior on scale { NumberAnimation { duration: 100; easing.type: Easing.OutCubic } }

    // 4. Подсветка при наведении
    property bool isHovered: mouseArea.containsMouse
    border.width: isHovered ? 2 : 0
    border.color: AppTheme.accent
    Behavior on border.width { NumberAnimation { duration: 150 } }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 18
        spacing: 8

        Text {
            text: root.title
            font.pixelSize: 13
            font.weight: Font.DemiBold
            color: AppTheme.textSecondary
        }

        Text {
            text: Math.round(root.loadValue * 100) + "%"
            font.pixelSize: 32
            font.bold: true
            color: AppTheme.text
        }

        ProgressBar {
            id: bar
            from: 0; to: 1; value: root.loadValue
            Layout.fillWidth: true
            implicitHeight: 6

            background: Rectangle {
                radius: 3
                color: AppTheme.surface
            }
            contentItem: Rectangle {
                implicitHeight: 6
                width: bar.visualPosition * bar.width
                radius: 3
                color: root.accentColor
                // Анимация ширины бара
                Behavior on width { NumberAnimation { duration: 300; easing.type: Easing.OutCubic } }
            }
        }

        Text {
            text: root.subTitle
            font.pixelSize: 12
            color: AppTheme.textSecondary
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true // Включаем наведение мыши
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }
}