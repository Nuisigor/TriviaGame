import QtQuick 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.1
import QtQuick.Window 2.12
import TriviaGame 1.0

ApplicationWindow {
    id: window
    width: 1280
    height: 720
    visible: true
    title: "Trivia"

    StackView{
        id: stackView
        anchors.fill : parent
        initialItem: LoginScreen{
            id: loginSc
            onLogin: stackView.push("Aguardando.qml")
        }
    }
}

