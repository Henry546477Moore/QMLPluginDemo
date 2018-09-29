#include "commoncontrolplugin.h"


CommonControlPlugin::CommonControlPlugin(QObject *parent) :
    QGenericPlugin(parent)
{
}

#if QT_VERSION < 0x050000
Q_EXPORT_PLUGIN2(CommonControls, CommonControlPlugin)
#endif // QT_VERSION < 0x050000
