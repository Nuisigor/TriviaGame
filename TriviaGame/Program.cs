using System;
using System.IO;
using Qml.Net;
using Qml.Net.Runtimes;

namespace TriviaGame{
    class Program{
        static int Main(string[] args){
            RuntimeManager.DiscoverOrDownloadSuitableQtRuntime();
            
            QQuickStyle.SetStyle("Material");

            using (var application = new QGuiApplication(args)){
                using (var qmlEngine = new QQmlApplicationEngine()){
                    Qml.Net.Qml.RegisterType<Login>("TriviaGame",1,0);
                    Qml.Net.Qml.RegisterType<Jogadores>("TriviaGame", 1,0);
                    qmlEngine.Load("Main.qml");
                    return application.Exec();
                }
            }
        }
    }
}

