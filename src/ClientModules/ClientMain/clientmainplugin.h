#ifndef CLIENTMAINPLUGIN_H
#define CLIENTMAINPLUGIN_H

#include <QGenericPlugin>


class ClientMainPlugin : public QGenericPlugin
{
    Q_OBJECT
#if QT_VERSION >= 0x050000
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QGenericPluginFactoryInterface" FILE "ClientMain.json")
#endif // QT_VERSION >= 0x050000

public:
    ClientMainPlugin(QObject *parent = 0);
};

#endif // CLIENTMAINPLUGIN_H
