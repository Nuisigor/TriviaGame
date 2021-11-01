import QtQuick 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.1

ApplicationWindow {
    id: window
    width: 1280
    height: 720
    visible: true
    title: "Qml.Net"

    Rectangle {
    id: rectangle1
    width: 1280
    height: 720
    color: "#930be9"
    radius: 0
    border.color: "#850ee8"
    border.width: 1
    layer.samplerName: "Screen"
    layer.samples: 16
    gradient: Gradient {
        GradientStop {
            position: 0
            color: "#930be9"
        }

        GradientStop {
            position: 1
            color: "#2624e3"
        }
        orientation: Gradient.Vertical
    }

    Rectangle {
        id: rectangle
        x: 361
        y: 69
        width: 551
        height: 582
        color: "#ffffff"
        radius: 27

         PurpleButton {
             id: purpleButton
             x: 136
             y: 432
         }

        Text {
            id: text1
            x: 171
            y: 104
            width: 192
            height: 109
            text: qsTr("Usuario")
            font.pixelSize: 50
        }

        Text {
            id: text2
            x: 171
            y: 254
            width: 192
            height: 109
            text: qsTr("IP")
            font.pixelSize: 50
        }
    }
}
}
