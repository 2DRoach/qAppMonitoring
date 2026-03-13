// ProcessView.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    id: root

    // ← ОБЯЗАТЕЛЬНО объявляем свойства!
    property var stackView
    property string processType: "all"

    title: {
        if (processType === "cpu") return "Процессы (CPU)"
        if (processType === "ram") return "Процессы (RAM)"
        return "Системный монитор"
    }

    background: Rectangle { color: AppTheme.bg }

    header: ToolBar {
        background: Rectangle { color: AppTheme.surface }
        RowLayout {
            anchors.fill: parent
            ToolButton {
                text: "←"
                font.pixelSize: 20
                onClicked: {
                    if (stackView) {
                        stackView.pop()  // ← Теперь работает!
                    }
                }
                contentItem: Text {
                    text: parent.text
                    font.pixelSize: parent.font.pixelSize
                    color: AppTheme.text
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
            Label {
                text: root.title
                font.pixelSize: 18
                font.bold: true
                color: AppTheme.text
                elide: Text.ElideRight
                Layout.fillWidth: true
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        // === Сводка ===
        RowLayout {
            Layout.fillWidth: true
            spacing: 15

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 80
                color: AppTheme.card
                radius: 8
                clip: true

                Column {
                    anchors.centerIn: parent
                    spacing: 5
                    Label {
                        text: processType === "cpu" ? "CPU Load" :
                              processType === "ram" ? "RAM Used" : "Total Load"
                        color: AppTheme.textSecondary
                        font.pixelSize: 12
                    }
                    Label {
                        text: processType === "cpu" ? "45%" :
                              processType === "ram" ? "6.5 GB" : "—"
                        color: AppTheme.accent
                        font.pixelSize: 24
                        font.bold: true
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 80
                color: AppTheme.card
                radius: 8
                clip: true

                Column {
                    anchors.centerIn: parent
                    spacing: 5
                    Label {
                        text: "Processes"
                        color: AppTheme.textSecondary
                        font.pixelSize: 12
                    }
                    Label {
                        text: "127"
                        color: AppTheme.text
                        font.pixelSize: 24
                        font.bold: true
                    }
                }
            }
        }

        // === Список процессов ===
        Label {
            text: "Топ процессов"
            color: AppTheme.textSecondary
            font.pixelSize: 14
            font.bold: true
        }

        ListView {
            id: processList
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            spacing: 8

            model: ListModel {
                // Mock данные - замените на реальные из C++
                ListElement { name: "chrome"; cpu: "12.5%"; ram: "1.2 GB"; }
                ListElement { name: "code"; cpu: "8.3%"; ram: "850 MB"; }
                ListElement { name: "docker"; cpu: "5.1%"; ram: "420 MB"; }
                ListElement { name: "systemd"; cpu: "2.4%"; ram: "180 MB"; }
                ListElement { name: "sshd"; cpu: "0.5%"; ram: "45 MB"; }
            }

            delegate: Rectangle {
                width: processList.width
                height: 60
                color: index % 2 === 0 ? AppTheme.surface : AppTheme.bg
                radius: 8
                clip: true

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 15
                    anchors.rightMargin: 15
                    spacing: 15

                    Label {
                        text: model.name
                        color: AppTheme.text
                        font.pixelSize: 14
                        font.bold: true
                        Layout.fillWidth: true
                        elide: Text.ElideRight
                    }

                    Label {
                        text: processType === "ram" ? model.ram : model.cpu
                        color: processType === "ram" ? "#2196F3" : "#4CAF50"
                        font.pixelSize: 14
                        font.bold: true
                    }

                    Label {
                        text: "⋮"
                        color: AppTheme.textSecondary
                        font.pixelSize: 20
                        MouseArea {
                            anchors.fill: parent
                            onClicked: console.log("Process details:", model.name)
                        }
                    }
                }
            }
        }

        // === Кнопка обновления ===
        Button {
            text: "🔄 Обновить"
            Layout.fillWidth: true
            background: Rectangle {
                color: parent.pressed ? AppTheme.card : AppTheme.surface
                radius: 8
                border.color: AppTheme.textSecondary
                border.width: 1
            }
            contentItem: Label {
                text: parent.text
                color: AppTheme.text
                horizontalAlignment: Text.AlignHCenter
            }
            onClicked: processList.model.clear() // Здесь будет реальное обновление
        }
    }
}