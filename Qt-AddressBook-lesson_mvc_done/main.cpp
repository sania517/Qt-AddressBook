#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "contactsmodel.h"
#include <QDebug>


//#include <QQmlContext>
//#include "controller.h"
//#include "battletimer.h"
//#include <QDebug>
//#include <QQmlComponent>

int main(int argc, char *argv[])
{


    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    ContactsModel::registerMe("Contacts");

    QQmlApplicationEngine engine;

//    engine.rootContext()->setContextProperty("contactModel",);
//            engine.rootContext()->setContextProperty("biCiFiModel", controller.get_BattleCityField());



    engine.addImportPath(":/qml");
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
