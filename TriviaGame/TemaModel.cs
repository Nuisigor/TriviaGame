using System;
using System.Collections.Generic;
using Qml.Net;
using Qml.Net.Runtimes;

namespace TriviaGame{

    [Signal("temaJogo",NetVariantType.String)]
    public class TemaModel{
        
        static public string tema;
        static public string dica;
        static public string resposta;
        
        public void sendTema(string tema, string dica, string resposta){
            TemaModel.tema = tema;
            TemaModel.dica = dica;
            TemaModel.resposta = resposta;
        }

        public void temaReceived(){
            this.ActivateSignal("temaJogo", TemaModel.tema);
        }


    }

}