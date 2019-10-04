#pragma once
#include <QAbstractListModel>
#include "contact.h"
#include "contactsreader.h"

class ContactsModel : public QAbstractListModel
{
    Q_OBJECT
public:
    ContactsModel(QObject* parent = nullptr);
    static void registerMe(const std::string& moduleName);
    int rowCount(const QModelIndex& parent = {}) const override;
    QVariant data(const QModelIndex& index = {}, int role = Qt::DisplayRole) const override;

    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE bool editContact(int index, QString name, QString surname, QString phoneNumber);
    Q_INVOKABLE bool addContact(QString name, QString surname, QString phoneNumber);

private:
    std::vector<Contact> m_contacts;
    ContactsReader m_reader;

    enum ContactRoles
    {
        NameRole,
        SurnameRole,
        PhoneNumberRole
    };

    bool updateContacts();
};

