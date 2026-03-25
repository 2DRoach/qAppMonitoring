// Main.qml
import QtQuick
import QtQuick.Controls

ApplicationWindow {
    id: window
    visible: true
    width: 400
    height: 800
    title: "Tuwunel Monitor"

    // Глобальная тема (как мы обсуждали)
    color: AppTheme.bg

    // === НАВИГАЦИОННЫЙ СТЕК ===
    // Это главный контейнер, который показывает экраны один поверх другого
    StackView {
        id: stackView
        anchors.fill: parent

        // Экран, который покажется при запуске
        initialItem: SplashView {
            // ВРЕМЕННАЯ ЛОГИКА ДЛЯ ТЕСТИРОВАНИЯ GUI:
            // Таймер срабатывает через 2 секунды и меняет экран.
            // Позже мы заменим это на сигнал от C++.

            Timer {
                interval: 2000
                running: true
                onTriggered: {
                    // Для теста можем переключать экраны вручную:
                    stackView.replace("AddServerPage.qml")
                    // stackView.replace("LoginPage.qml")
                    // stackView.replace("DashBoardPage.qml")
                }
            }
        }
    }

    // === ГЛОБАЛЬНЫЙ КОНТЕКСТ ДЛЯ МОКОВ ===
    // Чтобы виджеты работали без C++, передадим им фейковые данные прямо здесь.
    // Потом мы перенесем эти данные в C++ модели.

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

        // Имитация списка процессов
        property var processList: [
            { pid: 101, name: "python3", cpu: 12.5, memory: 1.2 },
            { pid: 102, name: "nginx", cpu: 0.5, memory: 0.4 },
            { pid: 103, name: "postgres", cpu: 5.2, memory: 3.1 }
        ]
    }
}