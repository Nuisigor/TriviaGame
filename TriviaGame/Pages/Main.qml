import QtQuick 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.1
import QtQuick.Window 2.12
import TriviaGame 1.0

ApplicationWindow {
    id: window
    width: 1280
    height: 720
    visible: true
    title: "Trivia"

    StackView{
        id: stackView
        anchors.fill : parent
        initialItem: Item{
                Rectangle {
                    id: rectangle1
                    width: parent.width
                    height: parent.height
                    color: "#930be9"
                    radius: 0
                    border.color: "#850ee8"
                    border.width: 1
                    property alias username: username
                    layer.samplerName: "Screen"
                    layer.samples: 16
                    gradient: Gradient {
                        GradientStop {
                            position: 0
                            color: "#930be9"
                        }

                        GradientStop {
                            position: 1
                            color: "#2624e3"
                        }
                        orientation: Gradient.Horizontal
                    }

                    Grid{
                        id: login
                        anchors.horizontalCenter : parent.horizontalCenter
                        anchors.verticalCenter : parent.verticalCenter
                        Rectangle {
                            id: login1
                            width: 551
                            height: 582
                            color: "#ffffff"
                            radius: 27

                            Button {
                                id: logar
                                x: 136
                                y: 432
                                width: 280
                                height: 60
                                background: Rectangle{
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
                                        id: textButton
                                        text: "Entrar"
                                        anchors.fill: parent
                                        font.pixelSize: 25
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        font.family: "Verdana"

                                        MouseArea {
                                            id: mouseArea
                                            x: 0
                                            y: 0
                                            width: parent.width
                                            height: parent.height
                                            cursorShape: Qt.PointingHandCursor
                                            onClicked: {login1.isValid()}
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
                                // onClicked: {login1.isValid()}
                            }

                            Rectangle {
                                id: username
                                x: 51
                                y: 91
                                width: 449
                                height: 95
                                radius: 30
                                gradient: Gradient {
                                    GradientStop {
                                        position: 0
                                        color: "#868686"
                                    }

                                    GradientStop {
                                        position: 1
                                        color: "#7f538a"
                                    }
                                    orientation: Gradient.Vertical
                                }

                                TextInput {
                                    id: inputUser
                                    text: qsTr(login1.crianome(5))
                                    x: 8
                                    y: 8
                                    width: 433
                                    focus: true
                                    height: 79
                                    font.pixelSize: 30
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    wrapMode: Text.WrapAnywhere
                                    maximumLength: 40
                                    selectByMouse: true
                                    MouseArea {
                                        anchors.fill: parent
                                        cursorShape: Qt.IBeamCursor
                                        acceptedButtons: Qt.NoButton
                                    }
                                    Keys.onTabPressed:{
                                        inputIP.forceActiveFocus()
                                    }
                                }
                            }

                            Rectangle {
                                id: ip
                                x: 51
                                y: 264
                                width: 449
                                height: 95
                                radius: 30
                                gradient: Gradient {
                                    GradientStop {
                                        position: 0
                                        color: "#868686"
                                    }

                                    GradientStop {
                                        position: 1
                                        color: "#7f538a"
                                    }
                                    orientation: Gradient.Vertical
                                }
                                TextInput {
                                    id: inputIP
                                    text: qsTr("localhost:1338")
                                    x: 8
                                    y: 8
                                    width: 433
                                    height: 79
                                    focus:true
                                    font.pixelSize: 21
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    wrapMode: Text.WrapAnywhere
                                    maximumLength: 40
                                    selectByMouse: true
                                    MouseArea {
                                        anchors.fill: parent
                                        cursorShape: Qt.IBeamCursor
                                        acceptedButtons: Qt.NoButton
                                    }
                                    Keys.onPressed:{
                                        if((event.key == Qt.Key_Enter) || (event.key == Qt.Key_Return)){
                                            login1.isValid();
                                        }
                                    }
                                }
                            }

                            Text {
                                id: text1
                                x: 73
                                y: 55
                                text: qsTr("Username")
                                font.letterSpacing: 2.5
                                font.pixelSize: 29
                                lineHeight: 1.1
                                font.underline: false
                                font.wordSpacing: 0
                                font.bold: true
                                font.weight: Font.ExtraBold
                                font.family: "Verdana"
                            }

                            Text {
                                id: text2
                                x: 67
                                y: 231
                                text: qsTr("IP")
                                font.letterSpacing: 2.5
                                font.pixelSize: 29
                                lineHeight: 1.1
                                font.underline: false
                                font.wordSpacing: 0
                                font.bold: true
                                font.weight: Font.ExtraBold
                                font.family: "Verdana"
                            }

                            Text{
                                id: validate
                                anchors.bottom : parent.bottom
                                anchors.horizontalCenter : parent.horizontalCenter
                                color: 'red'
                            }

                            function isValid(){
                                var fieldsFilled = inputUser.text !== "" && inputIP.text !== ""
                                if(!fieldsFilled){
                                    validate.text = qsTr("Inputs invalidos")
                                }
                                else{
                                    validate.text = qsTr("")
                                    logincs.dataWrite(inputUser.text, inputIP.text)
                                    
                                }
                            }

                            function crianome(size=5) {
                                let nome = "";
                                let possible = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

                                for (let i = 0; i < size; i++) nome += possible.charAt(Math.floor(Math.random() * possible.length));

                                return nome ;
                            } 
                        }
                    }
                    Login{
                        id: logincs
                        onConnectedUser: function (){
                            stackView.push("Aguardando.qml")
                        }
                    }
                }
            }
    }
}

