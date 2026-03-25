// AppTheme.qml
pragma Singleton
import QtQuick

QtObject {
    id: theme
    property bool darkMode: true
    signal themeChanged()
    onDarkModeChanged: themeChanged()

    // === Colors ===
    readonly property color bg: darkMode ? "#121212" : "#F5F5F5"
    readonly property color surface: darkMode ? "#1e1e1e" : "#FFFFFF"
    readonly property color card: darkMode ? "#2c313a" : "#E0E0E0"

    readonly property color text: darkMode ? "#FFFFFF" : "#000000"
    readonly property color textSecondary: darkMode ? "#A0A0A0" : "#666666"

    readonly property color accent: "#4CAF50"
    readonly property color danger: "#F44336"
    readonly property color warning: "#FF9800"

    readonly property color accentPressed: Qt.darker(accent, 1.15)
    readonly property color surfacePressed: darkMode ? Qt.lighter(surface, 1.05) : Qt.darker(surface, 1.05)
    readonly property color border: darkMode ? "#333333" : "#CCCCCC"

    // === TextStyle ===

    readonly property int fontBaseSize: Qt.application.font.pixelSize

    property font fontH1: Qt.font({ family: Qt.application.font.family, pixelSize: fontBaseSize * 2.0, bold: true })
    property font fontH2: Qt.font({ family: Qt.application.font.family, pixelSize: fontBaseSize * 1.5, bold: true })
    property font fontBody: Qt.font({ family: Qt.application.font.family, pixelSize: fontBaseSize })
    property font fontCaption: Qt.font({ family: Qt.application.font.family, pixelSize: fontBaseSize * 0.85, weight: Font.Light })

    // === 3. РАЗМЕРЫ И ОТСТУПЫ (Material Design based) ===
    readonly property int spacingXS: 8
    readonly property int spacingS: 12
    readonly property int spacingM: 16
    readonly property int spacingL: 24
    readonly property int spacingXL: 32

    readonly property int radiusSmall: 4
    readonly property int radiusMedium: 8
    readonly property int radiusLarge: 12

    readonly property int touchHeight: 48

    // === 4. Animations ===
    readonly property int durationShort: 150
    readonly property int durationLong: 300
}