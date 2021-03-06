using System;
using System.Net.Sockets;
using System.Threading.Tasks;
using System.Text;
using System.IO;

namespace TriviaGame{

    public class ClientSocket{
        private TcpClient client;

        private string ip;
        private int port;
        private bool connected;
        private NetworkStream stream;

        public delegate void ChatMessageReceivedHandler(string message);
        public event ChatMessageReceivedHandler ChatMessageReceived;

        public async Task Connect(string address) {
            string[] addressParts = address.Split(':');
            ip = addressParts[0];
            port = Int32.Parse(addressParts[1]);
            connected = false;
            try {
                client = new TcpClient();
                await client.ConnectAsync(ip, port);
                stream = client.GetStream();
                connected = true;
            } catch (Exception e) {
                connected = false;
                Close();
                
                Console.WriteLine(e.ToString());
            }
        }

        public void Close() {
            if (connected) {
                connected = false;
                stream.Close();
                client.Close();
            }
        }

        public async Task Receive() {
            byte[] buffer = new byte[1024];

            while(connected && client.Connected) {
                int bufferSize = await stream.ReadAsync(buffer, 0, buffer.Length);
                if (bufferSize == 0) break;

                string msg = Encoding.ASCII.GetString(buffer, 0, bufferSize);
                Console.WriteLine("SOCKET:" + msg);

                string[] messages = msg.Split('|');
                foreach (string message in messages) {
                    if (message.Length > 0) {
                        OnChatMessageReceived(message);
                    }
                }
            }

            Close();
        }

        public async Task Send(string msg) {
            if (connected) {
                byte[] buffer = Encoding.ASCII.GetBytes(msg);
                await stream.WriteAsync(buffer, 0, buffer.Length);
            }
        }

        public virtual void OnChatMessageReceived(string message) {
            if (ChatMessageReceived != null) {
                Console.WriteLine("OnChatMessageReceived: " + message);
                ChatMessageReceived(message);
            }
        }

    }
}