import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: item1
    width: 280
    height: 60

    Rectangle {
        id: rectangle
        color: "#ffffff"
        radius: 100
        border.width: 0
        anchors.fill: parent
        gradient: Gradient {
            GradientStop {
                id: gradientStop
                position: 0
                color: "#b224ef"
            }

            GradientStop {
                position: 1
                color: "#7579ff"
            }
            orientation: Gradient.Vertical
        }

        Text {
            id: text1
            text: "Button"
            anchors.fill: parent
            font.pixelSize: 25
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Verdana"

            MouseArea {
                id: mouseArea
                x: 0
                y: 0
                width: 361
                height: 110
            }
        }
    }
    states: [
        State {
            name: "State1"
            when: mouseArea.pressed

            PropertyChanges {
                target: gradientStop
            }

            PropertyChanges {
                target: rectangle
                border.width: 3
            }
        }
    ]
}

/*##^##
Designer {
    D{i:0;height:110;width:361}D{i:5}D{i:1}
}
##^##*/

