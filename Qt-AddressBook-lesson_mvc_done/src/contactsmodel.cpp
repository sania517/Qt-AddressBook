#include "contactsmodel.h"
#include <QQmlEngine>
#include <QDebug>

ContactsModel::ContactsModel(QObject *parent)
    :QAbstractListModel(parent)
{
    const bool updateResult {updateContacts()};
    if (!updateResult) {
        qWarning() << "Update contacts failed!";
    }
}

void ContactsModel::registerMe(const std::string& moduleName)
{
    qmlRegisterType<ContactsModel>(moduleName.c_str(), 1, 0, "ContactsModel");
}

int ContactsModel::rowCount(const QModelIndex& parent) const
{
    Q_UNUSED(parent)
    return static_cast<int>(m_contacts.size());
}

QVariant ContactsModel::data(const QModelIndex& index, int role) const
{
    if (!index.isValid() || index.row() > rowCount(index)) {
        return {};
    }

    const Contact& contact = m_contacts.at(index.row());

    switch (role) {
        case ContactRoles::NameRole: {
            return QVariant::fromValue(contact.firstName());
        }
        case ContactRoles::SurnameRole: {
            return QVariant::fromValue(contact.secondName());
        }
        case ContactRoles::PhoneNumberRole: {
            return QVariant::fromValue(contact.phone());
        }
        default: {
            return {};
        }
    }
}

QHash<int, QByteArray> ContactsModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[ContactRoles::NameRole] = "firstname";
    roles[ContactRoles::SurnameRole] = "surname";
    roles[ContactRoles::PhoneNumberRole] = "phoneNumber";

    return roles;
}

bool ContactsModel::editContact(int index, QString name, QString surname, QString phoneNumber)
{
    m_contacts[index].setFirstName(name);
    m_contacts[index].setSecondName(surname);
    m_contacts[index].setPhone(phoneNumber);
    emit dataChanged(createIndex(index, 0), createIndex(index, 0));
    return  true;

}

bool ContactsModel::addContact(QString name, QString surname, QString phoneNumber)
{
    beginInsertRows(QModelIndex(), m_contacts.size(), m_contacts.size());
    m_contacts.emplace_back(name,surname,phoneNumber);
    endInsertRows();
//    emit dataChanged(createIndex(0, 0), createIndex(m_contacts.size(), 0));
    return  true;
}

bool ContactsModel::updateContacts()
{
    bool requestResult {false};
    std::vector<Contact> contactsResult;
    std::tie(requestResult, contactsResult) = m_reader.requestContactsBrowse();

    if (requestResult) {
        m_contacts.swap(contactsResult);
        emit dataChanged(createIndex(0, 0), createIndex(m_contacts.size(), 0));
    }

    return requestResult;
}
