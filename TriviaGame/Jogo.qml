import QtQuick 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.1
import QtQuick.Window 2.12
import TriviaGame 1.0

Page{
    id: jogoPage

    background: Rectangle{
        gradient : Gradient{
            GradientStop{
                position: 0
                color: "#a82311"
            }
            GradientStop{
                position: 1
                color: "#0849a8"
            }
            orientation: Gradient.Horizontal
        }
    }
}