import QtQuick 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.1
import QtQuick.Window 2.12
import TriviaGame 1.0

Page{
    id: esperaPage

    signal jogo

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
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            leftMargin: parent.width / 12
            rightMargin: parent.width / 12
            topMargin: 100
            bottomMargin: 100
        }
        

        Knob {
            id: progressBar
            anchors.verticalCenter : tela.verticalCenter
            anchors.right: tela.right
            anchors.rightMargin: 50
            width: parent.height / 1.3
            height: parent.height / 1.3
            from: 0
            to: 30
            value: 30
            fromAngle: 0
            toAngle: Math.PI*2
            reverse: false
            function addProgress(){
                update(value-1)
                // if(progressBar.value === 0){
                //     esperaPage.jogo()
                // }
            }

            function resetTimer(){
                update(30)
            }
        }

        JogadoresItem{
            id: jogadores
            anchors.left : tela.left
            anchors.leftMargin : 50
            anchors.top: tela.top
            anchors.topMargin: 50
            anchors.bottom: tela.bottom
            anchors.right: tela.right
        }
    }

    Timer {
        id: timerEspera;
        interval: 1000; repeat: true;
        onTriggered: progressBar.addProgress();
    }

    EsperaModel{
        id: esperaCs
        onSetCounter: {
            progressBar.resetTimer();
            timerEspera.start();
        }
    }

    JogoModel{
        id:jogoCs
        onStartGameR: esperaPage.jogo()
    }
}