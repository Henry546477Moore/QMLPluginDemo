#ifndef COMMONCONTROLPLUGIN_H
#define COMMONCONTROLPLUGIN_H

#include <QGenericPlugin>


class CommonControlPlugin : public QGenericPlugin
{
    Q_OBJECT
#if QT_VERSION >= 0x050000
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QGenericPluginFactoryInterface" FILE "CommonControls.json")
#endif // QT_VERSION >= 0x050000

public:
    CommonControlPlugin(QObject *parent = 0);
};

#endif // COMMONCONTROLPLUGIN_H
