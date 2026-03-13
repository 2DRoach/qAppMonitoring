import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: delegate
    implicitHeight: 80
    implicitWidth: parent ? parent.width : 400

    // Mock данные (потом придут из C++ модели)
    property string mountPoint: "/var/lib/matrix"
    property double usedSpace: 0.75
    property string totalSpace: "500 GB"
    property string healthStatus: "Healthy"

    Rectangle {
        anchors.fill: parent
        anchors.margins: 5
        radius: 8
        color: "#32373e"

        RowLayout {
            anchors.fill: parent
            anchors.margins: 15
            spacing: 15

            // Иконка диска (простой Rectangle вместо картинки для прототипа)
            Rectangle {
                width: 40; height: 40; radius: 20
                color: "#444"
                Text { text: "💾"; anchors.centerIn: parent; font.pixelSize: 20 }
            }

            ColumnLayout {
                Layout.fillWidth: true
                spacing: 4

                Text {
                    text: delegate.mountPoint
                    color: "white"
                    font.bold: true
                    font.pixelSize: 16
                }

                // Полоска использования
                ProgressBar {
                    from: 0; to: 1
                    value: delegate.usedSpace
                    Layout.fillWidth: true
                    implicitHeight: 4

                    background: Rectangle { color: "#222"; radius: 2 }
                    contentItem: Rectangle {
                         implicitHeight: 4
                         width: parent.visualPosition * parent.width
                         radius: 2
                         color: delegate.usedSpace > 0.9 ? "#f44336" : "#2196F3" // Красный если > 90%
                    }
                }

                Text {
                    text: qsTr("%1 used of %2").arg(Math.round(delegate.usedSpace * 100) + "%").arg(delegate.totalSpace)
                    font.pixelSize: 12
                    color: "#888"
                }
            }

            // Статус здоровья
            Rectangle {
                width: statusText.implicitWidth + 20; height: 25
                radius: 12
                color: delegate.healthStatus === "Healthy" ? "#1b5e20" : "#b71c1c"

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
    }
}