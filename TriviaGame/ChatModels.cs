using System;
using System.Collections.Generic;
using Qml.Net;
using Qml.Net.Runtimes;

namespace TriviaGame{

    [Signal("messageReceived", NetVariantType.String)]
    public class Chat{
        public Chat() {
            Program.socket.ChatMessageReceived += messageReceive;
        }

        public void messageSend(string message){
            Program.socket.Send(message);
        }
    
        public void messageReceive(string message){
            char protocol = message[0];
            if(protocol == 'M'){
                message = message.Substring(1);
                this.ActivateSignal("messageReceived", message);
            }
        }
    }

}