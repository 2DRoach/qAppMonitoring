import QtQuick
import QtQuick.Controls


ApplicationWindow {
    id: window
    visible: true
    width: 400
    height: 800
    title: "Tuwunel Monitor"
    color: AppTheme.bg // AppTheme тоже берется из модуля qMonitoringApp

    // === НАВИГАЦИОННЫЙ СТЕК ===
    StackView {
        id: stackView
        anchors.fill: parent

        // Регистрируем стек в Роутере при запуске
        Component.onCompleted: Router.stackView = stackView

        // Начальный экран
        // initialItem: "SplashView.qml"
        initialItem: "SplashView.qml"
    }

    // === ГЛОБАЛЬНЫЙ КОНТЕКСТ ДЛЯ МОКОВ ===
    // Внимание: этот объект виден только внутри Main.qml.
    // Если вы хотите использовать mockData в Dashboard, лучше вынести их в отдельный Singleton.
    QtObject {
        id: mockData

        property var dashboard: ({
            cpu_load: 45,
            cpu_freq: 2400,
            ram_load: 62,
            ram_used: 4.9,
            ram_total: 8.0
        })

        property var serverInfo: ({
            name: "Тестовый Сервер",
            url: "http://192.168.1.50:8000"
        })

        property var processList: [
            { pid: 101, name: "python3", cpu: 12.5, memory: 1.2 },
            { pid: 102, name: "nginx", cpu: 0.5, memory: 0.4 },
            { pid: 103, name: "postgres", cpu: 5.2, memory: 3.1 }
        ]
    }
}