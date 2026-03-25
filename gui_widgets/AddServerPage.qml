// AddServerPage.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    id: root
    background: Rectangle { color: AppTheme.bg }

    property bool isChecking: false


        Flickable {
           id: flickable
           anchors.fill: parent
           contentWidth: width
           contentHeight: columnLayout.implicitHeight + 100 // Запас снизу

           ColumnLayout {
               id: columnLayout

               // Привязываем к верху, а не к центру!
               anchors.top: parent.top
               anchors.topMargin: 40 // Отступ от шапки
               anchors.horizontalCenter: parent.horizontalCenter

               width: parent.width * 0.85
               spacing: 25 // Увеличим отступ между элементами

               Label {
                   text: "Добавить сервер"
                   font.pixelSize: 24
                   font.bold: true
                   color: AppTheme.text
                   Layout.alignment: Qt.AlignHCenter
               }

               Label {
                   text: "Введите адрес и имя для нового подключения"
                   color: AppTheme.textSecondary
                   Layout.alignment: Qt.AlignHCenter
                   wrapMode: Text.WordWrap

                   // ВАЖНО: Заставляем текст переноситься по ширине колонки
                   Layout.fillWidth: true
                   horizontalAlignment: Text.AlignHCenter
               }


                   AppTextField {
                        id: nameInput
                        Layout.fillWidth: true
                        backgroundColorNormal: AppTheme.surface
                        backgroundColorHover: AppTheme.card
                        placeholderText: "Имя Сервера"
                        floatingPlaceholder: true  // Включаем "андроидное" поведение

                        // Кастомизация цветов
                        borderColorActive: AppTheme.accent // Фиолетовый акцент
                        placeholderColorActive: "#6200EE"
                        textColor: AppTheme.text
                        onAccepted: urlInput.forceActiveFocus()
                   }



                   AppTextField {
                       id: urlInput
                       Layout.fillWidth: true
                       backgroundColorNormal: AppTheme.surface
                       backgroundColorHover: AppTheme.card
                       placeholderText: "URL"
                       floatingPlaceholder: true
                       borderColorActive: AppTheme.accent
                       placeholderColorActive: "#6200EE"
                       textColor: AppTheme.text
                       // Теперь это свойство доступно
                       validator: RegularExpressionValidator {
                            regularExpression: /[a-zA-Z0-9.:\/\-]+/
                       }
                   }



               Button {
                   text: root.isChecking ? "Проверка..." : "Добавить"
                   Layout.fillWidth: true
                   Layout.topMargin: 10
                   enabled: !root.isChecking && nameInput.text !== "" && urlInput.text !== ""

                   background: Rectangle {
                       color: parent.enabled ? AppTheme.accent : AppTheme.textSecondary
                       radius: 10
                   }
                   contentItem: Text {
                       text: parent.text
                       color: "white"
                       font.bold: true
                       horizontalAlignment: Text.AlignHCenter
                       verticalAlignment: Text.AlignVCenter
                   }

                   onClicked: {
                       root.isChecking = true;
                       // Логика будет позже
                       console.log("Add server clicked");
                       // ServerManager.addServer(nameInput.text, urlInput.text);
                   }
               }

               // Распорка, чтобы можно было прокрутить выше клавиатуры
               Item { Layout.preferredHeight: 100 }
           }
       }

    // Закомментировано, так как ServerManager не реализован
    /*
    Connections {
        target: ServerManager
        function onServerAdded(success, message) {
            root.isChecking = false;
            if (!success) {
                console.warn("Error adding server:", message);
            }
        }
    }
    */
}