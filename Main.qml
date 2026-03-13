// Main.qml
import QtQuick
import QtQuick.Controls

ApplicationWindow {
    id: window
    visible: true
    width: 400
    height: 800
    title: "Tuwunel Admin Dashboard"

    // Цветовая схема глобально
    palette.window: AppTheme.bg
    palette.windowText: AppTheme.text
    palette.base: AppTheme.surface
    palette.alternateBase: AppTheme.card
    palette.text: AppTheme.text
    palette.button: AppTheme.card
    palette.buttonText: AppTheme.text
    palette.highlight: AppTheme.accent
    palette.highlightedText: "white"
    // ЕДИНСТВЕННЫЙ контейнер навигации
    StackView {
        id: stackView
        anchors.fill: parent  // Исправлена опечатка parrent -> parent

        // Загружаем начальную страницу
        initialItem: DashBoardPage {
            stackView: stackView
        }
    }
}