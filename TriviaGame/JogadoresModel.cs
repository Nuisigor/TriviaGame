using System.Collections.Generic;
using System;
using Qml.Net;
using Qml.Net.Runtimes;

namespace TriviaGame{

    class Jogadores{
        static public List<Jogador> _jogadores = new List<Jogador>{
        };
        static public List<JogadorPontos> _jogadorespontos = new List<JogadorPontos>{};

        public List<JogadorPontos> JogadoresP{
            get => _jogadorespontos;
        }
        
        public List<Jogador> JogadoresL
        {
            get => _jogadores;
        }

        public int JogadoresSize{
            get => _jogadores.Count;
        }
    }


    [Signal("updateJogador")]
    public class Jogador{

        public string Nome{ get; set;}

        static int count = 0;
        public Jogador(){
            if(count == 0) {
                Program.socket.ChatMessageReceived += updateJogadores;
                count++;
            }
        }
        public void updateJogadores(string message){
            char protocol = message[0];
            if(protocol == 'L') {
                Console.WriteLine("Lista de jogadores recebida");
                message = message.Substring(1);
                string[] jogadores = message.Split(';');
                Jogadores._jogadores.Clear();
                foreach (string jogador in jogadores) {
                    Jogadores._jogadores.Add(new Jogador{
                        Nome = jogador
                    });
                }
                this.ActivateSignal("updateJogador");
            }
        }
    }

    [Signal("updatePontosR")]
    public class JogadorPontos{
        public string Nome{get; set;}
        public string Pontos{get;set;}
        static int count = 0;

        public JogadorPontos(){
            if(count == 0){
                Program.socket.ChatMessageReceived += updateJogadoresPontos;
                count++;
            }        
        }

        public void updateJogadoresPontos(string message){
            char protocol = message[0];
            if(protocol == 'P'){
                Console.WriteLine("ATUALIZAR AQUI:" + message);
                message = message.Substring(1);
                string[] values = message.Split(';');
                Jogadores._jogadorespontos.Clear();
                Console.WriteLine("ATEAQUIVAI");
                foreach (string jogador in values){
                    string[] registro = jogador.Split(',');
                    Console.WriteLine(registro[0]+" "+registro[1]);
                    Jogadores._jogadorespontos.Add(new JogadorPontos{
                        Nome = registro[0],
                        Pontos = registro[1],
                    });
                    
                }
                Console.WriteLine("ATUALIZADO:" + message);
                this.ActivateSignal("updatePontosR");
                Console.WriteLine("POS SINAL");
            }
        }
    }
}