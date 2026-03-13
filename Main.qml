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
    palette.window: "#121212"
    palette.windowText: "white"
    palette.base: "#1e1e1e"
    palette.alternateBase: "#2c313a"
    palette.text: "white"
    palette.button: "#32373e"
    palette.buttonText: "white"
    palette.highlight: "#4CAF50"
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