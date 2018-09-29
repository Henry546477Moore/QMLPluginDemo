#ifndef LOGINSERVERPLUGIN_H
#define LOGINSERVERPLUGIN_H

#include <QQmlExtensionPlugin>


class LoginServerPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "com.lsquan.loginserverplugin/1.0" FILE "LoginServer.json")

public:
    void registerTypes(const char *uri);
};

#endif // LOGINSERVERPLUGIN_H
