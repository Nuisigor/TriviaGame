using System;
using System.Collections.Generic;
using Qml.Net;
using Qml.Net.Runtimes;

namespace TriviaGame{

    [Signal("temaJogo", NetVariantType.String)]
    public class TemaModel{
        
        static public string tema{get;set;}
        static public string dica{get;set;}
        static public string resposta{get;set;}

        public TemaModel(){
            Program.socket.ChatMessageReceived += temaReceived;
        }
        
        public void sendTema(string tema, string dica, string resposta){
            TemaModel.tema = tema;
            TemaModel.dica = dica;
            TemaModel.resposta = resposta;
            string message = "T"+tema+';'+dica+';'+resposta;
            Program.socket.Send(message);
        }

        public void temaReceived(string message){
            char protocol = message[0];
            if(protocol == 'T'){
                message = message.Substring(1);
                string[] values = message.Split(';');
                TemaModel.tema = values[0];
                TemaModel.dica = values[1];
                TemaModel.resposta = values[2];
                this.ActivateSignal("temaJogo",message);
            }
        }


    }

}