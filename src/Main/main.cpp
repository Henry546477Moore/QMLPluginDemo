#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QFontDatabase>
#include "systemconfiginfo.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    qmlRegisterType<SystemConfigInfo>("com.henrymoore", 1, 0, "SystemConfigInfo");

    int fontID = QFontDatabase::addApplicationFont(":/Fonts/fontawesome-webfont.ttf");
    QFontDatabase::applicationFontFamilies(fontID);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/LoginView.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
