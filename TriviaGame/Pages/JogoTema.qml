import QtQuick 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.1
import QtQuick.Window 2.12
import TriviaGame 1.0

Item{
    id: jogoTema

    Rectangle{
        id: rect1
        color : "white"
        border.color : "black"
        border.width: 2
        height: parent.height
        width: parent.width 
        Text{
            id:tema
            anchors.top: parent.top
            anchors.topMargin: 5
            text: "Tema: " 
            anchors.left: parent.left
            anchors.leftMargin: 20
        }
        Text{
            id:pista
            anchors.top: tema.bottom
            anchors.topMargin:5
            text: "Pista : "
            anchors.left: parent.left
            anchors.leftMargin: 20
        }
        Text{
            id: palavra
            anchors.top: pista.bottom
            anchors.topMargin: 5
            anchors.horizontalCenter: parent.horizontalCenter
            text: " _ _ _ _ _ _ _ "
        }
    }
}