import QtQuick 2.15
import QtQuick.Controls.Material 2.5
import QtQuick.Controls 2.2
import TriviaGame 1.0


Item{
    id: chat
    Rectangle{
        id: rectangle1
        border.color : "black"
        border.width : 2
        color: "white"
        radius : 20
        anchors.right: parent.right
        anchors.left : parent. left
        width : parent.width / 1.8
        height: parent.height / 1.1

    }
}