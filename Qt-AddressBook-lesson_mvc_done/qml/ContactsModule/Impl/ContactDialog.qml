import QtQuick 2.0
import QtQuick.Controls 2.5
import StyleModule 1.0
import ContactsModule.Base 1.0
import Contacts 1.0



Dialog {
    id:root
    property string name: ""
    property string surname: ""
    property string phoneNumber: ""
    property bool edit

    header: ToolBar{
        height: _rect.height
        background: Rectangle{
            id: _rect
            width: parent.width
            opacity: Style.secondaryOpacity
            color: "transparent"
            height: Style.defaultTextSize *2.5
            border.width: 0.5
            border.color: Style.themeInvertedColor
            BaseText{
                anchors.centerIn: parent
                text: edit ? "Edit Contact" : "Create new contact"
                font.bold: true
            }
        }
    }
        parent: Overlay.overlay
        width: 300
        height: 280
        x: Math.round((parent.width - width)/2)
        y: Math.round((parent.height - height)/2)
        background: Rectangle{
            color: Style.backgroundColor
            border.color: Style.themeInvertedColor
            border.width: 0.5
        }
        contentItem:Column{
                anchors.leftMargin: 15
                anchors.rightMargin: 15
                spacing: 1
                BaseText{
                    text: "Edit Name"
                }
                BaseTextField{
                    id: _fieldName
                    text: name
                    placeholderText: "name"
                    width: parent.width
                    height: _fieldName.font.pointSize * 2.5
                }
                BaseText{
                    text: "Edit Surname"
                }
                BaseTextField{
                    id: _textSurname
                    text: surname
                    placeholderText: "surname"
                    font.pointSize:  Style.defaultTextSize
                    width: parent.width
                    height: _textSurname.font.pointSize * 2.5
                }
                BaseText{
                    text: "Edit Phone number"
                }
                BaseTextField{
                    id:_textPhoneNumber
                    text :phoneNumber
                    placeholderText: "+XXXXXXXXX"
                    font.pointSize:  Style.defaultTextSize
                    width: parent.width
                    height: _textPhoneNumber.font.pointSize * 2.5
                }
            }
        footer:DialogButtonBox{
            background: Rectangle{
                color: Style.backgroundColor
                border.width: 0.5
                border.color: Style.themeInvertedColor
            }
            delegate: Component{
                Button{
                    font.pointSize: Style.smallTextSize
                    background: Rectangle{
                        color: Style.buttonColor
                    }
                }
            }
            standardButtons: Dialog.Save | Dialog.Cancel
        }
        onAccepted: {
            console.log("Ok clicked")
            edit ? _baza.editContact(index, _fieldName.text, _textSurname.text, _textPhoneNumber.text) :
                _contactView.model.addContact(_fieldName.text, _textSurname.text, _textPhoneNumber.text)
            if (!edit){
            _fieldName.text = ""
            _textSurname.text = ""
            _textPhoneNumber.text = ""
            }


        }
        onRejected:{
            console.log("Cancel clicked")
            if (!edit){
            _fieldName.text = ""
            _textSurname.text = ""
            _textPhoneNumber.text = ""
            }
     }
}
