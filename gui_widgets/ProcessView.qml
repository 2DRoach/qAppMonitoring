import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    id: root
    background: Rectangle { color: AppTheme.bg }

    // Свойство для хранения текущего состояния сортировки (Mock)
    property string sortBy: "cpu"

    header: ToolBar {
        background: Rectangle { color: AppTheme.surface }
        ColumnLayout {
            anchors.fill: parent
            spacing: 0

            // Верхняя строка: Заголовок и кнопки
            RowLayout {
                Layout.fillWidth: true
                ToolButton {
                    text: "←"
                    font.bold: true
                    onClicked: Router.pop()
                }
                Label {
                    text: "Process Monitor"
                    font.bold: true
                    font.pixelSize: 16
                    color: AppTheme.text
                    Layout.fillWidth: true
                }
                ToolButton {
                    text: "⟳"
                    font.pointSize: 14
                    onClicked: console.log("Refresh list")
                }
            }

            // Строка поиска
            TextField {
                id: searchField
                Layout.fillWidth: true
                Layout.margins: 5
                placeholderText: "Search process..."
                color: AppTheme.text
                font.pixelSize: 14

                background: Rectangle {
                    color: AppTheme.bg
                    radius: 4
                    border.color: "#444"
                }
            }
        }
    }

    // Заголовок таблицы (Header)
    Rectangle {
        id: tableHeader
        anchors.top: parent.top
        width: parent.width
        height: 35
        color: AppTheme.surface
        z: 2 // Чтобы был поверх списка при скролле

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            spacing: 5

            Text {
                text: "NAME / PID"
                font.bold: true
                font.pixelSize: 12
                color: AppTheme.textSecondary
                Layout.fillWidth: true
            }
            Text {
                text: "CPU"
                font.bold: true
                font.pixelSize: 12
                color: AppTheme.textSecondary
                Layout.preferredWidth: 60
                horizontalAlignment: Text.AlignHCenter
            }
            Text {
                text: "MEM"
                font.bold: true
                font.pixelSize: 12
                color: AppTheme.textSecondary
                Layout.preferredWidth: 60
                horizontalAlignment: Text.AlignHCenter
            }
            Text {
                text: "ACT" // Actions
                font.bold: true
                font.pixelSize: 12
                color: AppTheme.textSecondary
                Layout.preferredWidth: 40
                horizontalAlignment: Text.AlignHCenter
            }
        }

        // Разделитель снизу
        Rectangle {
            anchors.bottom: parent.bottom
            width: parent.width
            height: 1
            color: "#333"
        }
    }

    // Список процессов
    ListView {
        id: listView
        anchors.top: tableHeader.bottom
        anchors.bottom: parent.bottom
        width: parent.width
        clip: true

        // Mock модель с реалистичными данными
        model: ListModel {
            ListElement { name: "matrix-synapse"; pid: "1045"; user: "matrix"; cpu: 45.2; mem: 12.8; cmd: "python3 -m synapse" }
            ListElement { name: "postgres"; pid: "892"; user: "postgres"; cpu: 12.5; mem: 25.0; cmd: "postgres: main" }
            ListElement { name: "nginx"; pid: "1201"; user: "www-data"; cpu: 2.1; mem: 1.5; cmd: "nginx: worker" }
            ListElement { name: "docker-proxy"; pid: "650"; user: "root"; cpu: 0.5; mem: 0.8; cmd: "docker-proxy" }
            ListElement { name: "systemd-journal"; pid: "320"; user: "root"; cpu: 0.0; mem: 0.5; cmd: "systemd-journald" }
            ListElement { name: "sshd"; pid: "890"; user: "root"; cpu: 0.1; mem: 0.2; cmd: "sshd: user@pts0" }
            ListElement { name: "bash"; pid: "1500"; user: "admin"; cpu: 0.0; mem: 0.1; cmd: "bash" }
            ListElement { name: "ffmpeg"; pid: "1602"; user: "media"; cpu: 95.0; mem: 10.0; cmd: "ffmpeg -i stream..." }
        }

        delegate: Rectangle {
            id: delegate
            width: ListView.view.width
            height: 50
            color: index % 2 ? AppTheme.card : AppTheme.bg

            // Определение цвета для баров
            property color cpuColor: model.cpu > 80 ? AppTheme.danger : (model.cpu > 30 ? "#FF9800" : "#4CAF50")
            property color memColor: model.mem > 80 ? AppTheme.danger : (model.mem > 30 ? "#FF9800" : "#2196F3")

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                spacing: 5

                // Колонка 1: Имя и PID
                ColumnLayout {
                    spacing: 2
                    Layout.fillWidth: true

                    Text {
                        text: model.name
                        font.bold: true
                        font.pixelSize: 13
                        color: AppTheme.text
                        elide: Text.ElideRight
                        Layout.fillWidth: true
                    }
                    Text {
                        text: model.user + " | " + model.pid
                        font.pixelSize: 11
                        color: AppTheme.textSecondary
                    }
                }

                // Колонка 2: CPU (с баром)
                Item {
                    Layout.preferredWidth: 60
                    Layout.fillHeight: true

                    Text {
                        anchors.top: parent.top
                        anchors.topMargin: 5
                        text: model.cpu.toFixed(1) + "%"
                        font.pixelSize: 12
                        font.bold: model.cpu > 30
                        color: delegate.cpuColor
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    // Графический бар (KDE style)
                    Rectangle {
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 5
                        width: parent.width - 10
                        height: 4
                        radius: 2
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: "#333" // Background track

                        Rectangle {
                            width: parent.width * (model.cpu / 100.0)
                            height: parent.height
                            radius: 2
                            color: delegate.cpuColor
                        }
                    }
                }

                // Колонка 3: MEM (с баром)
                Item {
                    Layout.preferredWidth: 60
                    Layout.fillHeight: true

                    Text {
                        anchors.top: parent.top
                        anchors.topMargin: 5
                        text: model.mem.toFixed(1) + "%"
                        font.pixelSize: 12
                        font.bold: model.mem > 30
                        color: delegate.memColor
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Rectangle {
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 5
                        width: parent.width - 10
                        height: 4
                        radius: 2
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: "#333"

                        Rectangle {
                            width: parent.width * (model.mem / 100.0)
                            height: parent.height
                            radius: 2
                            color: delegate.memColor
                        }
                    }
                }

                // Колонка 4: Действие (Kill)
                Item {
                    Layout.preferredWidth: 40
                    Layout.fillHeight: true

                    RoundButton {
                        anchors.centerIn: parent
                        text: "✕"
                        font.pixelSize: 12
                        flat: true

                        background: Rectangle {
                            implicitWidth: 30
                            implicitHeight: 30
                            radius: 15
                            color: parent.down ? "#b71c1c" : (parent.hovered ? "#333" : "transparent")
                        }

                        contentItem: Text {
                            text: parent.text
                            color: parent.hovered ? "white" : AppTheme.textSecondary
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        onClicked: console.log("Killing PID: " + model.pid)
                    }
                }
            }

            // Разделитель строк
            Rectangle {
                anchors.bottom: parent.bottom
                width: parent.width
                height: 1
                color: "#222"
            }
        }
    }
}