import QtQuick 2.11
import QtQuick.Window 2.11
import ContactsModule.Impl 1.0
import StyleModule 1.0
import QtQuick.Controls 2.12

Window {
    id:root
    visible: true
    width: 480
    height: 640
    title: qsTr("Address book")

    ContactsView {
        id:_contactView
        anchors.fill: parent
    }

    Rectangle {
        id: _background
        z: -100
        anchors.fill: parent
        color: Style.backgroundColor
        opacity: Style.emphasisOpacity

    }

    ContactDialog{
        id: _addDialog
        name: ""
        surname: ""
        phoneNumber: ""
        edit : false
    }

    RoundButton{
        width: 50
        height: width
        radius: width/2
        x: root.width - width - Style.defaultOffset
        y: root.height - height - Style.defaultOffset
        text: "+"
        font.pointSize : Style.largeTextSize
        background: Rectangle{
            radius: parent.radius
            anchors.fill: parent
            color: Style.buttonColor
        }
        onClicked:_addDialog.open()
    }


}
