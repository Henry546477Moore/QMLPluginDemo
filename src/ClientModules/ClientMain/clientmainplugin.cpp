#include "clientmainplugin.h"


ClientMainPlugin::ClientMainPlugin(QObject *parent) :
    QGenericPlugin(parent)
{
}

#if QT_VERSION < 0x050000
Q_EXPORT_PLUGIN2(ClientMain, ClientMainPlugin)
#endif // QT_VERSION < 0x050000
