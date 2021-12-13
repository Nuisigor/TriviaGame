import QtQuick 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.1
import QtQuick.Window 2.12
import TriviaGame 1.0

Page{
    id: jogoPage

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
        radius : 5

        anchors{
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            leftMargin: parent.width / 12
            rightMargin: parent.width / 12
            topMargin: 100
            bottomMargin: 100
        }

        JogoTema{
            id: tema
            width: parent.width / 1.5
            anchors.right: parent.right
            anchors.top : parent.top
            height: parent.height / 4
            anchors.topMargin: 20
            
        }

        ChatPage{
            id: chat
            anchors.right: parent.right
            anchors.top: tema.bottom
            anchors.topMargin: 20
            anchors.bottom: parent.bottom
            width: parent.width / 1.5
        }

        JogadoresPontos{
            id: placar
            anchors.top: parent.top
            anchors.bottom: chat.bottom
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.topMargin: 20
            anchors.bottomMargin: 30
            width: parent.width / 3.5
        }
    }

    Popup{
        id: temaPop
        // title: qsTr("Sua Vez!")
        height: 600
        width: 600
        anchors.centerIn: parent
        Tema{
            id: temaPane
            anchors.fill: parent
            onTemaDialogFechar : temaPop.close()
        }
    }

    TemaModel{
        id: temaX
        onTemaJogo: function(tema){
            console.log(tema)
        }
    }

    RodadaModel{
        id: rodadaCs
        onRodadaOwner: temaPop.open()
    }

}