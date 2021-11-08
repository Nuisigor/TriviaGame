
using System;
using System.Threading.Tasks;


namespace TriviaGame{

    public class Login{
        public async Task dataWrite(string inputUser, string inputIP){
            Console.WriteLine(inputUser);
            Console.WriteLine(inputIP);
            
            await Program.socket.Connect(inputIP);
            Program.socket.Receive();
            Program.socket.Send(inputUser);
        }
    }
}