import QtQuick 2.15
import QtQuick.Controls.Material 2.5
import QtQuick.Controls 2.2
import TriviaGame 1.0

Item{
    id: temaDialog
    Rectangle{
        id: rect1
        anchors.fill : parent
        color: "white"
        
        Text{
            id: suavez
            text: "Sua Vez!"
            font.pixelSize: 16
        }
        Rectangle{
            id: tema
            color: "white"
            anchors.top: suavez.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            height: parent.height / 4
            anchors.topMargin : 20
            Text{
                id: temaTitle
                text: "Tema :"
                anchors.top: parent.top
                anchors.left : parent.left
                font.pixelSize: 30
            }
            Rectangle{
                id: temaInput
                border.color: "black"
                border.width: 2
                radius: 20
                anchors.top: temaTitle.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.bottomMargin: parent.height / 3
                anchors.leftMargin: parent.width / 9
                anchors.rightMargin: parent.width / 9
                TextInput{
                    id: texto
                    text: qsTr("")
                    anchors.fill: parent
                    clip: true
                    font.pixelSize: 25
                    wrapMode: Text.WrapAnywhere
                    autoScroll: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    maximumLength: 30
                    selectByMouse: true
                    focus: true
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.IBeamCursor
                        acceptedButtons: Qt.NoButton
                    }
                }
            }
        }
        Rectangle{
            id: dica
            color: "white"
            anchors.top: tema.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            height: parent.height / 4
            anchors.topMargin : 20
            Text{
                id: dicaTitle
                text: "Dica :"
                anchors.top: parent.top
                anchors.left : parent.left
                font.pixelSize: 30
            }
            Rectangle{
                id: dicaInput
                border.color: "black"
                border.width: 2
                radius: 20
                anchors.top: dicaTitle.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.bottomMargin: parent.height / 3
                anchors.leftMargin: parent.width / 9
                anchors.rightMargin: parent.width / 9
                TextInput{
                    id: texto1
                    text: qsTr("")
                    anchors.fill: parent
                    clip: true
                    font.pixelSize: 25
                    wrapMode: Text.WrapAnywhere
                    autoScroll: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    maximumLength: 30
                    selectByMouse: true
                    focus: true
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.IBeamCursor
                        acceptedButtons: Qt.NoButton
                    }
                }
            }
        }
        Rectangle{
            id: resposta
            color: "white"
            anchors.top: dica.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            height: parent.height / 4
            anchors.topMargin : 20
            Text{
                id: respostaTitle
                text: "Resposta :"
                anchors.top: parent.top
                anchors.left : parent.left
                font.pixelSize: 30
            }
            Rectangle{
                id: repostaInput
                border.color: "black"
                border.width: 2
                radius: 20
                anchors.top: respostaTitle.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.bottomMargin: parent.height / 3
                anchors.leftMargin: parent.width / 9
                anchors.rightMargin: parent.width / 9
                TextInput{
                    id: texto2
                    text: qsTr("")
                    anchors.fill: parent
                    clip: true
                    font.pixelSize: 25
                    wrapMode: Text.WrapAnywhere
                    autoScroll: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    maximumLength: 30
                    selectByMouse: true
                    focus: true
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.IBeamCursor
                        acceptedButtons: Qt.NoButton
                    }
                }
            }
        }
        Button{
            id: enviar
            text: qsTr("Enviar")
            anchors.top: resposta.bottom
            anchors.left: parent.left
            anchors.right: parent.right
        }
        ProgressBar{
            id: barra
            value: 0.5
            anchors.top: enviar.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
        }
    }
}