import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: root

    // === PUBLIC API ===
    property alias text: textInput.text
    property string placeholderText: "Placeholder"
    property alias validator: textInput.validator

    property color textColor: "#000000"
    property color placeholderColorNormal: "#999999"
    property color placeholderColorActive: "#3d5afe"

    property color backgroundColorNormal: "#ffffff"
    property color backgroundColorHover: "#f5f5f5"

    property color borderColorNormal: "#e0e0e0"
    property color borderColorActive: "#3d5afe"

    property int borderRadius: 12
    property bool floatingPlaceholder: true

    signal accepted()
    signal editingFinished()

    implicitHeight: 56

    property color currentBgColor: mouseArea.containsMouse ? backgroundColorHover : backgroundColorNormal
    property color currentBorderColor: {
        if (textInput.length > 0 && !textInput.acceptableInput) return AppTheme.danger
        return textInput.activeFocus ? borderColorActive : borderColorNormal
    }

    // === 1. ФОН ===
    Rectangle {
        anchors.fill: parent
        radius: root.borderRadius
        color: root.currentBgColor
        border.width: 0
        Behavior on color { ColorAnimation { duration: 150 } }
    }

    // === 2. РАМКА ===
    Rectangle {
        id: borderFrame
        anchors.fill: parent
        radius: root.borderRadius
        color: "transparent"
        border.width: 2
        border.color: root.currentBorderColor
        Behavior on border.color { ColorAnimation { duration: 150 } }
    }

    // === 3. PLACEHOLDER (КОМПАКТНЫЙ ПУЗЫРЁК) ===
    Rectangle {
        id: placeholderBubble

        // Цвет совпадает с фоном поля -> перекрывает рамку и сливается внутри
        color: root.currentBgColor

        // Максимально компактные размеры (отступы по 1-2 пикселя)
        width: placeholderText.implicitWidth + 10
        height: placeholderText.implicitHeight + 1

        radius: 2

        anchors.left: parent.left
        anchors.leftMargin: 12

        Text {
            id: placeholderText
            text: root.placeholderText
            color: textInput.activeFocus ? root.placeholderColorActive : root.placeholderColorNormal
            font.pixelSize: 16
            anchors.centerIn: parent

            Behavior on color { ColorAnimation { duration: 150 } }
        }

        states: State {
            name: "FLOATING"
            when: root.floatingPlaceholder && (textInput.activeFocus || textInput.length > 0)

            AnchorChanges {
                target: placeholderBubble
                anchors.verticalCenter: root.top
            }

            // УТОПЛЕНИЕ: Сдвигаем центр на 6px вниз.
            // При размере текста ~16px, верхняя кромка пузырька будет торчать наружу совсем чуть-чуть.
            PropertyChanges {
                target: placeholderBubble
                anchors.verticalCenterOffset: 3
            }

            PropertyChanges {
                target: placeholderText
                font.pixelSize: 12
                color: root.placeholderColorActive
            }
        }

        transitions: Transition {
            AnchorAnimation { duration: 150; easing.type: Easing.OutQuad }
            // Добавляем анимацию смещения, чтобы движение было плавным
            NumberAnimation { properties: "font.pixelSize,anchors.verticalCenterOffset"; duration: 150 }
        }

        anchors.verticalCenter: parent.verticalCenter
        z: 1 // Поверх рамки
    }

    // === 4. TEXT INPUT ===
    TextInput {
        id: textInput
        anchors.fill: parent
        anchors.leftMargin: 16
        anchors.rightMargin: 16

        // Поднимаем отступ ввода, чтобы текст был по центру оставшегося пространства
        anchors.topMargin: root.floatingPlaceholder ? 22 : 12
        anchors.bottomMargin: 12

        color: root.textColor
        font.pixelSize: 16
        verticalAlignment: TextInput.AlignTop
        selectedTextColor: "white"
        selectionColor: borderColorActive

        activeFocusOnPress: true
        onAccepted: root.accepted()
        onEditingFinished: root.editingFinished()

        cursorDelegate: Rectangle {
            visible: textInput.cursorVisible
            color: root.borderColorActive
            width: 2
            height: textInput.cursorRectangle.height
        }
    }

    // === 5. MOUSE AREA ===
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onPressed: {
            textInput.forceActiveFocus()
            Qt.inputMethod.show()
            mouse.accepted = false
        }
    }
}