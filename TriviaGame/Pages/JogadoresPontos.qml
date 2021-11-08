import QtQuick 2.15
import QtQuick.Controls.Material 2.5
import QtQuick.Controls 2.2
import TriviaGame 1.0


//ARRUMAR A SCROLLBAR

Item{
    id: jogadores
    Rectangle{
        id: rectangle1
        color: "white"
        border.color : "black"
        border.width : 2
        height : parent.height
        width : parent.width
        radius: 20
        
        Rectangle{
            id: aguardando
            anchors{
                top: rectangle1.top
                left: rectangle1.left
                right: rectangle1.right
                topMargin: 20
                leftMargin: 20
                rightMargin: 20
            }
            radius: 5
            height: 50
            color: "#2624e3"
            Text{
                id: aguardandoText
                anchors{
                    verticalCenter: aguardando.verticalCenter
                    horizontalCenter: aguardando.horizontalCenter
                }
                color: "white"
                text: qsTr("Placar")
            }
        }
        
        
        Rectangle{
            id: frame
            clip: true
            color: Qt.rgba(0,0,0,0)
            border.color:"black"
            anchors.top : aguardando.bottom
            anchors.topMargin : 20
            anchors.left: rectangle1.left
            anchors.right: rectangle1.right
            anchors.rightMargin: 10
            anchors.leftMargin : 10
            anchors.bottom: rectangle1.bottom
            anchors.bottomMargin: 20
            
            Item{
                id:content
                anchors.fill: parent
                Column{
                    id: lista
                    spacing: 20
                    anchors.fill : parent
                    anchors.topMargin: 10
                    anchors.leftMargin: 10
                    Repeater{
                        id: repeater
                        Column{
                            Text{
                                text: modelData.nome + " [" + modelData.pontos + " pontos ]"
                            }
                        }
                    }
                }
            }
        }
    }
    Jogadores{
        id: jogadoresCs
        Component.onCompleted:{
            repeater.model = Net.toListModel(jogadoresCs.jogadoresP)
        }
    }
}