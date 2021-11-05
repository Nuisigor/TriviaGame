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
    }

}