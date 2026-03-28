pragma Singleton
import QtQuick 2.15
import QtQuick.Controls 2.15
QtObject {
    id: router

    // Ссылка на глобальный StackView из Main.qml
    property StackView stackView

    // Карта экранов (чтобы не писать пути руками)
    readonly property string pageSplash: "Splash"
    readonly property string pageAddServer: "AddServer"
    readonly property string pageLogin: "Login"
    readonly property string pageDashboard: "Dashboard"
    readonly property string pageCPU: "CPU"
    readonly property string pageGPU: "GPU"
    readonly property string pageRAM: "RAM"
    readonly property string pageNetwork: "Network"
    readonly property string pageStorage: "Storage"
    readonly property string pageSettings: "Settings"

    readonly property var pagesMap: ({
        "Splash": "SplashView.qml",
        "AddServer": "AddServerPage.qml",
        "Login": "LoginPage.qml",
        "Dashboard": "DashBoardPage.qml",
        "CPU": "CPUView.qml",
        "GPU": "GPUView.qml",
        "RAM": "RAMView.qml",
        "Network": "NetworkView.qml",
        "Storage": "StorageManager.qml",
        "Settings": "SettingsPage.qml"
    })

    // === Функции навигации ===

    function resolveRoute(routeName){
        if (!pagesMap[routeName]) {
            console.log("ROUTER ERROR: Unknown route ->", routeName)
            return ""
        }
        return pagesMap[routeName]
    }

    function push(page, properties) {
        if (!stackView) return

        var url = resolveRoute(page)
        if (url)
            stackView.push(url, properties || {})
    }

    function pop() {
        if (stackView) stackView.pop()
    }

    function replace(page, properties) {
        if (!stackView) return

        var url = resolveRoute(page)
        if (url)
            stackView.replace(url, properties || {})
    }

    function goToMain() {
        if (!stackView) return
            stackView.pop(null)
            stackView.replace(resolveRoute(pageDashboard)) // Используем свойство pageDashboard
    }
}