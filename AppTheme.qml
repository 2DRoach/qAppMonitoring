// AppTheme.qml
pragma Singleton
import QtQuick

QtObject {
    // === РАССКОММЕНТИРОВАТЬ ЭТУ СТРОКУ ===
    property bool darkMode: true

    // === Colors ===
    // Background
    readonly property color bg: darkMode ? "#121212" : "#F5F5F5"
    readonly property color surface: darkMode ? "#1e1e1e" : "#FFFFFF"
    readonly property color card: darkMode ? "#2c313a" : "#E0E0E0"

    // Text
    readonly property color text: darkMode ? "#FFFFFF" : "#000000"
    readonly property color textSecondary: darkMode ? "#A0A0A0" : "#666666"

    // Accent
    readonly property color accent: "#4CAF50"
    readonly property color danger: "#F44336"
    readonly property color warning: "#FF9800"
}