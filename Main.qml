// Main.qml
import QtQuick
import QtQuick.Controls

ApplicationWindow {
    id: window
    visible: true
    width: 400
    height: 800
    title: "Tuwunel Admin Dashboard"

    color: AppTheme.bg

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: DashBoardPage {
            stackView: stackView
        }
    }
}