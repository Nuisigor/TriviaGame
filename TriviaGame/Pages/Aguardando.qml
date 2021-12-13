import QtQuick 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.1
import QtQuick.Window 2.12
import TriviaGame 1.0

Page{
    id: aguardo
    signal fecha
    StackView{
        id: stackView
        anchors.fill: parent
        initialItem: Espera{
            id: espera
            onJogo :{
                stackView.push("Jogo.qml")
            }
        }
    }
}