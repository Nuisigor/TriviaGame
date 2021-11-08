using System.Collections.Generic;
using Qml.Net;
using Qml.Net.Runtimes;

namespace TriviaGame{
    
    class Jogadores{
        
        private readonly List<Jogador> _jogadores = new List<Jogador>{
            new Jogador{
                Nome = "Teste"
            },
            new Jogador{
                Nome = "Igor"
            },
            new Jogador{
                Nome = "Getulio"
            },
            new Jogador{
                Nome = "Joao"
            },
            new Jogador{
                Nome = "Tchubi"
            }
        };

        private readonly List<JogadorPontos> _jogadorespontos = new List<JogadorPontos>{
            new JogadorPontos{
                Nome = "Teste",
                Pontos = 0
            },
            new JogadorPontos{
                Nome = "Igor",
                Pontos = 10
            },
            new JogadorPontos{
                Nome = "Getulio",
                Pontos = 20
            },
            new JogadorPontos{
                Nome = "Joao",
                Pontos = 30
            },
            new JogadorPontos{
                Nome = "Tchubi",
                Pontos = 40
            }
        };

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
        public class Jogador{

            public string Nome{ get; set;}
        }

        public class JogadorPontos{
            public string Nome{get; set;}
            public int Pontos{get;set;}
        }
    }

}