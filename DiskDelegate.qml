// DiskDelegate.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: delegate
    implicitHeight: 85
    implicitWidth: parent ? parent.width : 400

    property string mountPoint: "/var/lib/matrix"
    property double usedSpace: 0.75
    property string totalSpace: "500 GB"
    property string healthStatus: "Healthy"

    signal clicked()

    Rectangle {
        anchors.fill: parent
        anchors.margins: 5
        radius: 12
        color: AppTheme.card
        border.width: mouseAreaDisk.containsMouse ? 1 : 0
        border.color: AppTheme.accent

        // Анимация цвета и границ
        Behavior on color { ColorAnimation { duration: 250 } }

        RowLayout {
            anchors.fill: parent
            anchors.margins: 15
            spacing: 15

            Rectangle {
                width: 45; height: 45; radius: 22
                color: AppTheme.surface
                // Иконка
                Text {
                    text: delegate.healthStatus === "Warning" ? "⚠️" : "💾"
                    anchors.centerIn: parent
                    font.pixelSize: 20
                }
            }

            ColumnLayout {
                Layout.fillWidth: true
                spacing: 5

                Text {
                    text: delegate.mountPoint
                    color: AppTheme.text
                    font.bold: true
                    font.pixelSize: 16
                    elide: Text.ElideRight
                    Layout.fillWidth: true
                }

                ProgressBar {
                    from: 0; to: 1
                    value: delegate.usedSpace
                    Layout.fillWidth: true
                    implicitHeight: 5

                    background: Rectangle { color: AppTheme.surface; radius: 2.5 }
                    contentItem: Rectangle {
                         implicitHeight: 5
                         width: parent.visualPosition * parent.width
                         radius: 2.5
                         color: delegate.usedSpace > 0.9 ? AppTheme.danger : "#2196F3"
                         Behavior on color { ColorAnimation { duration: 200 } }
                    }
                }

                Text {
                    text: qsTr("%1 used of %2").arg(Math.round(delegate.usedSpace * 100) + "%").arg(delegate.totalSpace)
                    font.pixelSize: 12
                    color: AppTheme.textSecondary
                }
            }

            Rectangle {
                width: statusText.implicitWidth + 16; height: 24
                radius: 12
                // Анимация цвета статуса
                color: delegate.healthStatus === "Healthy" ? "#1b5e20" : "#b71c1c"
                Behavior on color { ColorAnimation { duration: 300 } }

                Text {
                    id: statusText
                    anchors.centerIn: parent
                    text: delegate.healthStatus
                    color: "white"
                    font.pixelSize: 10
                    font.bold: true
                }
            }
        }

        MouseArea {
            id: mouseAreaDisk
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: delegate.clicked()
        }
    }
}