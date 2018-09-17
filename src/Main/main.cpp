#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QFontDatabase>
#include "resizeqmlwindow.h"
#include "systemconfiginfo.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    qmlRegisterType<SystemConfigInfo>("com.henrymoore", 1, 0, "SystemConfigInfo");

    int fontID = QFontDatabase::addApplicationFont(":/Fonts/fontawesome-webfont.ttf");
    QFontDatabase::applicationFontFamilies(fontID);

    ResizeQmlWindow resize;

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/LoginView.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    engine.rootContext()->setContextProperty("resize", &resize);
    QObject *rootObject = engine.rootObjects().first();
    QWindow *w = qobject_cast<QWindow *>(rootObject);
    if(w)
    {
        resize.setWindow(w);
        w->setMinimumSize(QSize(900, 700));
    }

    return app.exec();
}
