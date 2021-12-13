
using System;
using System.Threading.Tasks;
using Qml.Net;
using Qml.Net.Runtimes;


namespace TriviaGame{

    [Signal("connectedUser"),Signal("jogoFinalizado")]
    public class Login{
        public async Task dataWrite(string inputUser, string inputIP){
            Console.WriteLine(inputUser);
            Console.WriteLine(inputIP);
            
            await Program.socket.Connect(inputIP);
            Program.socket.Receive();
            Program.socket.Send(inputUser);
            Program.nomePlayer = inputUser;
        }

        public void fechaJogo(){
            System.Threading.Thread.Sleep(1000);
            Console.WriteLine("FECHAJOGO FOI");
            this.ActivateSignal("jogoFinalizado");
            Console.WriteLine("FECHAJOGO FOI");
        }
        public Login(){
            Program.socket.ChatMessageReceived += connected;
        }

        public void connected(string message){
            if(message == "C"){
                this.ActivateSignal("connectedUser");
            }
        }
    }
}