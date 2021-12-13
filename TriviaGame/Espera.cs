using System.Collections.Generic;
using System;
using Qml.Net;
using Qml.Net.Runtimes;

namespace TriviaGame{

    [Signal("setCounter")]
    public class EsperaModel{

        public EsperaModel(){
            Program.socket.ChatMessageReceived += startCounter;
        }

        public void startCounter(string message){
            char protocol = message[0];
            if(protocol == 'L'){
                if(Jogadores._jogadores.Count >= 2){
                    this.ActivateSignal("setCounter");
                }
            }
        }

    }

    [Signal("startGameR")]
    public class JogoModel{
        public JogoModel(){
            Program.socket.ChatMessageReceived += startGame;
        }

        public void startGame(string message){
            char protocol = message[0];
            if(protocol == 'G'){
                this.ActivateSignal("startGameR");
            }
        }
    }

}