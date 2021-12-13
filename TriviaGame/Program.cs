using System;
using System.IO;
using Qml.Net;
using Qml.Net.Runtimes;

namespace TriviaGame{

    class Program{
        public static ClientSocket socket = new ClientSocket();

        public static string nomePlayer;

        static int Main(string[] args){
            RuntimeManager.DiscoverOrDownloadSuitableQtRuntime();
            
            QQuickStyle.SetStyle("Material");

            using (var application = new QGuiApplication(args)){
                using (var qmlEngine = new QQmlApplicationEngine()){
                    Qml.Net.Qml.RegisterType<Login>("TriviaGame",1,0);
                    Qml.Net.Qml.RegisterType<Chat>("TriviaGame", 1, 0);
                    Qml.Net.Qml.RegisterType<Jogadores>("TriviaGame", 1,0);
                    Qml.Net.Qml.RegisterType<Jogador>("TriviaGame",1,0);
                    Qml.Net.Qml.RegisterType<JogadorPontos>("TriviaGame",1,0);
                    Qml.Net.Qml.RegisterType<TemaModel>("TriviaGame",1,0);
                    Qml.Net.Qml.RegisterType<EsperaModel>("TriviaGame",1,0);
                    Qml.Net.Qml.RegisterType<JogoModel>("TriviaGame",1,0);
                    Qml.Net.Qml.RegisterType<RodadaModel>("TriviaGame",1,0);
                    qmlEngine.Load("Pages/Main.qml");
                    return application.Exec();
                }
            }
        }
    }
}

