import QtQuick 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.1
import QtQuick.Window 2.12
import TriviaGame 1.0

Item{
    id: victoryScreen

    signal victoryScreenAbrir
    signal fecharJogo

    Rectangle{
        id: rect1
        anchors.fill:parent

        Text{
            id: vencedor
            text: "nada"
            anchors.centerIn: parent
            font.pixelSize: 100
            font.family: "8514oem"
        }

        Text{
            id: botao
            anchors.top: vencedor.bottom
            anchors.topMargin: 30
            anchors.left: vencedor.left
            anchors.right: vencedor.right
            text: "Feche e Inicie o jogo para Jogar novamente"
        }
    }

    RodadaModel{
        id:rodadaCs
        onVencedor: function (message){
            vencedor.text = message + " venceu a partida!"
            victoryScreen.victoryScreenAbrir()
        }
    }
}