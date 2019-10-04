import QtQuick 2.0
import ContactsModule.Base 1.0
import StyleModule 1.0
import ResourceProvider 1.0
import QtQuick.Controls 2.5

BaseListDelegate {
    id: root

    ImageBubble {
        id: _contactBubble
        anchors.left: root.left
        anchors.leftMargin: Style.defaultOffset
        anchors.verticalCenter: root.verticalCenter
        boundingRadius: root.height - 15

        image.source: Resources.contacts.defaultContactIcon
    }

    Column {
        anchors.left: _contactBubble.right
        anchors.leftMargin: Style.defaultOffset
        anchors.verticalCenter: root.verticalCenter
        Row {
            spacing: Style.smallSpacing
            BaseText {
                text: firstname
            }
            BaseText {
                text: surname
            }
        }
        BaseText {

            text: "+" + phoneNumber
            color: Style.primaryColor

        }
    }

    ContactDialog{
        id: _testDialog
        name: model.firstname
        surname: model.surname
        phoneNumber: model.phoneNumber
        edit : true
    }


    Button{
        id:_button

        text: "Edit"
        anchors.right: root.right
        anchors.verticalCenter: root.verticalCenter
        anchors.rightMargin: Style.defaultOffset
        height: root.height/3
        width: 50
        font.pointSize: Style.smallTextSize
        onClicked:{
            console.log("111")
            _testDialog.open()
        }
    }

}
