import QtQuick
import QtQuick.Controls
import qMonitoringApp

ApplicationWindow {
    id: window
    visible: true
    width: 400
    height: 800
    title: "Tuwunel Monitor"
    color: AppTheme.bg

    // === НАВИГАЦИОННЫЙ СТЕК ===
    StackView {
        id: stackView
        anchors.fill: parent
        Component.onCompleted: Router.stackView = stackView
        initialItem: "pages/SplashView.qml"
    }


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
