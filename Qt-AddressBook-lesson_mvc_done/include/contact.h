#pragma once
#include <QString>

class Contact
{
public:
    Contact() = default;
    Contact(QString firstName, QString secondName, QString phone);
    QString firstName() const;
    QString secondName() const;
    QString phone() const;

    void setPhone(const QString phone);

    void setFirstName(const QString firstName);

    void setSecondName(const QString secondName);

private:
    QString m_phone;
    QString m_firstName;
    QString m_secondName;
};

