import QtQuick 2.15
import QtQml 2.15
import QtQuick.Controls.Material 2.5
import QtQuick.Controls 2.2
import TriviaGame 1.0
import QtMultimedia 5.15


Item{
    id: chat
    Rectangle{
        id: rectangle1
        border.color : "black"
        border.width : 2
        color: "white"
        radius : 20
        anchors.right: parent.right
        anchors.left : parent. left
        width : parent.width / 1.8
        height: parent.height / 1.1

        Rectangle{
            id: mensagens
            color: "#ebebeb"
            anchors.top: rectangle1.top
            anchors.bottom: input.top
            anchors.left: rectangle1.left
            anchors.right: rectangle1.right
            anchors.bottomMargin: 10
            anchors.topMargin: 20
            anchors.leftMargin: 20
            anchors.rightMargin: 20
            border.color: "black"
            radius: 5
            Component{
                id: messageDelegate
                Item{
                    width: mensagens.width / 1.2
                    height: mensagens.height / 8    
                    Column{
                        spacing: 40
                        Rectangle{
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            width: mensagens.width / 1.2
                            height: mensagens.height / 10
                            color: model.cor
                            Text{
                                id: mensagem
                                text: model.mensagem
                                color: "#FFFFFF"
                                anchors.left: parent.left
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                verticalAlignment: Text.AlignVCenter
                                anchors.leftMargin: 10
                                font.pixelSize: 14
                            }
                        }
                    } 
                }
            }
            ListView{
                id: listachat
                spacing: 2
                clip:true
                anchors.fill: parent
                anchors.topMargin:20
                anchors.bottomMargin:20
                model: chatList
                delegate: messageDelegate
                onCountChanged: {
                    var newIndex = count - 1 // last index
                    positionViewAtEnd()
                    currentIndex = newIndex
                }
            }
        }
    
        Rectangle{
            id: input
            color: "#ebebeb"
            border.color : "black"
            anchors.bottom: rectangle1.bottom
            anchors.left : rectangle1.left
            anchors.right : rectangle1.right
            anchors.rightMargin: 20
            anchors.leftMargin: 20
            anchors.bottomMargin: 30
            height: rectangle1.height / 5.7
            radius: 10

            Rectangle{
                id: frame
                anchors.left: parent.left
                anchors.right: enviar.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.topMargin: 10
                anchors.bottomMargin: 10
                anchors.rightMargin : 10
                anchors.leftMargin : 10
                color:"white"
                border.color: "grey"
                TextInput{
                    id: texto
                    text: qsTr("")
                    anchors.fill: parent
                    clip: true
                    font.pixelSize: 16
                    wrapMode: Text.WrapAnywhere
                    autoScroll: true
                    leftPadding: 5
                    topPadding: 2
                    maximumLength: 200
                    selectByMouse: true
                    focus: true
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.IBeamCursor
                        acceptedButtons: Qt.NoButton
                        enabled: texto.focus
                        onClicked: texto.cursorPosition = texto.positionAt(mouseX,mouseY)
                        onWheel: {
                            if(wheel.angleDelta.y>0)
                                texto.cursorPosition -= 1
                            if(wheel.angleDelta.y<0)
                                texto.cursorPosition += 1
                        }
                    }
                    Keys.onPressed: {
                        if((event.key == Qt.Key_Enter) || (event.key == Qt.Key_Return))
                            input.sendMessage()
                    }
                }
            }

            Rectangle{
                id: enviar
                width : parent.width / 10
                height : parent.height / 1.3
                color: Qt.rgba(0,0,0,0)
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.topMargin: 10
                anchors.bottomMargin: 10
                anchors.rightMargin: 10
                Button{
                    anchors.fill: parent
                    background: Image{source: "../img/outline_send_white_36dp.png"}
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {input.sendMessage()}
                    }
                }
            }

            function sendMessage(){
                var message = texto.text
                if(message !== ""){
                    chatCs.messageSend('M'+texto.text)
                    texto.text = qsTr("")
                }
            }
        }
    }
    ListModel{
        id: chatList
    }

    Chat{
        id: chatCs
        onMessageReceived: function(message){
            chatList.append({"mensagem": message, "cor":"#2624E3"})
        }
    }

    
    Audio{
        id: audioAcerto
        source: "../audio/Acerto.ogg"
    }


    RodadaModel{
        id: rodadModelCs
        onRodadaComecou: function(message){
            chatList.append({"mensagem": message, "cor":"#B3239D"})
        }
        onAcerto: function(message){
            chatList.append({"mensagem":message, "cor": "#1DE419"})
            audioAcerto.play()
        }
        onRespostaPerto: function(message){
            chatList.append({"mensagem":message, "cor":"#C89114"})
        }
        onRodadaFinalizada: function(message){
            chatList.append({"mensagem":message, "cor":"#B3239D"})
            chatList.append({"mensagem":"Rodada finalizada", "cor": "#B3239D"})
        }
    }


}