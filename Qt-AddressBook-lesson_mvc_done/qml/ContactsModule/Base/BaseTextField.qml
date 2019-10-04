import QtQuick 2.0
import QtQuick.Controls 2.12
import StyleModule 1.0

TextField {
    font.pointSize: Style.defaultTextSize
    color: Style.textColor

    maximumLength: 15
    background: Rectangle{
        border.color: Style.primaryColor
        color: Style.backgroundColor

    }

}
