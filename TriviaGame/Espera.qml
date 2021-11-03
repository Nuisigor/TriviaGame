import QtQuick 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.1

Page{
    id: esperaPage

    Rectangle{
        id: header
        color: Qt.rgba(0,1,0,1)
        height: parent.height / 12
        anchors{
            left: parent.left
            top: parent.top
            right: parent.right
        }
    }

    background: Rectangle{
        gradient : Gradient{
            GradientStop{
                position: 0
                color: "#a82311"
            }
            GradientStop{
                position: 1
                color: "#0849a8"
            }
            orientation: Gradient.Horizontal
        }
    }

    Rectangle{
        id: tela
        color: "white"
        radius: 40
        anchors{
            top: header.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            leftMargin: parent.width / 12
            rightMargin: parent.width / 12
            topMargin: 50
            bottomMargin: 100
        }
    }

}