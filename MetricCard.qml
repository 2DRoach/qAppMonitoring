import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root

    property string title: "CPU"
    property double loadValue: 0.0
    property string subTitle: "0 / 8 Cores"
    property color accentColor: "#4CAF50"

    // !!! 1. Сигнал для клика (чтобы не использовать MouseArea внутриDashBoard)
    signal clicked()

    implicitHeight: 130 // Чуть больше места для красоты
    implicitWidth: 180
    radius: 15 // Больше скругление = современнее

    // !!! 2. Анимация цвета фона (для смены темы)
    color: AppTheme.card
    Behavior on color { ColorAnimation { duration: 300 } }

    // !!! 3. Эффект "Вдавливания" при нажатии (Material Design style)
    property bool pressed: mouseArea.pressed
    scale: pressed ? 0.97 : 1.0
    Behavior on scale { NumberAnimation { duration: 100; easing.type: Easing.OutCubic } }

    // !!! 4. Эффект "Подъема" при наведении (Hover)
    property bool hovered: mouseArea.containsMouse
    // Тень (простая реализация без слоев, для простоты)
    border.width: hovered ? 1 : 0
    border.color: AppTheme.accent // Подсветка краев при наведении

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 18 // Чуть больше воздуха
        spacing: 10

        Text {
            text: root.title
            font.pixelSize: 14
            color: AppTheme.textSecondary
            font.weight: Font.DemiBold
            Layout.fillWidth: true
        }

        Text {
            text: Math.round(root.loadValue * 100) + "%"
            font.pixelSize: 32 // Крупнее цифры
            font.bold: true
            color: AppTheme.text
            // Анимация цвета текста при смене темы
            Behavior on color { ColorAnimation { duration: 300 } }
        }

        ProgressBar {
            id: bar
            from: 0
            to: 1
            value: root.loadValue

            Layout.fillWidth: true
            implicitHeight: 8 // Толще бар

            background: Rectangle {
                radius: 4
                color: AppTheme.surface
                // Плавная смена фона бара
                Behavior on color { ColorAnimation { duration: 300 } }
            }

            contentItem: Rectangle {
                implicitHeight: 8
                implicitWidth: bar.visualPosition * bar.width
                radius: 4
                color: root.accentColor

                // !!! 5. Анимация ширины бара (чтобы не дергался)
                // В Qt 6 ProgressBar сам анимирует value, но можно усилить
                Behavior on implicitWidth {
                    NumberAnimation { duration: 500; easing.type: Easing.OutCubic }
                }
            }
        }

        Text {
            text: root.subTitle
            font.pixelSize: 12
            color: AppTheme.textSecondary
        }
    }

    // !!! 6. Единая MouseArea для всей карточки
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true // Включаем отслеживание наведения
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked() // Генерируем сигнал
    }
}