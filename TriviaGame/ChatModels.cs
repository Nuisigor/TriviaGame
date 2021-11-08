using System;
using System.Collections.Generic;
using Qml.Net;
using Qml.Net.Runtimes;

namespace TriviaGame{

    [Signal("messageReceived", NetVariantType.String)]
    public class Chat{

        public void messageSend(string message){
            messageReceive(message);
        }
    
        public void messageReceive(string message){
            this.ActivateSignal("messageReceived", "Nome: " + message);
        }


    }

}