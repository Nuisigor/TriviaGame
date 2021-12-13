using System.Collections.Generic;
using System;
using Qml.Net;
using Qml.Net.Runtimes;

namespace TriviaGame{

    [Signal("rodadaOwner"),Signal("rodadaComecou",NetVariantType.String),Signal("acerto",NetVariantType.String),Signal("respostaPerto",NetVariantType.String),Signal("respostaErrada"),Signal("selfAcerto"),Signal("rodadaFinalizada",NetVariantType.String)]
    public class RodadaModel{

        public RodadaModel(){
            Program.socket.ChatMessageReceived += rodadaTema;
        }

        public void rodadaTema(string message){
            char protocol = message[0];
            if(protocol == 'O'){
                message = message.Substring(1);
                if(message == Program.nomePlayer){
                    this.ActivateSignal("rodadaOwner");
                }
                string mensagem = $"Rodada começou : {message} é o Game Master da Rodada";
                this.ActivateSignal("rodadaComecou",mensagem);
            }

            if(protocol == 'c'){
                message = message.Substring(1);
                string mensagem = $"{message} acertou!";
                this.ActivateSignal("acerto",mensagem);
            }

            if(protocol == 'N'){
                string mensagem = "Quase lá! Sua resposta está perto!";
                this.ActivateSignal("respostaPerto",mensagem);
            }
            if(protocol == 'a'){
                message = message.Substring(1);
                string mensagem = $"{message} pessoas acertaram nessa rodada!";
                this.ActivateSignal("rodadaFinalizada",mensagem);
            }
        }

    }

}