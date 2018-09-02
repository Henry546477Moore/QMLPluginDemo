#include "systemconfigio.h"
#include <QCoreApplication>
#include <QSettings>
#include <QDir>
#include <QStringList>

SystemConfigIO::SystemConfigIO(QObject *parent) : QObject(parent)
{
    _sysConfigPath = QString("%1/hmconfig.ini").arg(QCoreApplication::applicationDirPath());
    ReadConfig();
}

/*!
 * \breif   read system config
 * \return  system config info
 * \author  HenryMoore
 * \date    2018-09-02 16:38
 */
SystemConfigInfo& SystemConfigIO::ReadConfig()
{
    QString colors;
    QSettings *set = new QSettings(_sysConfigPath, QSettings::IniFormat);
    _sysConfigInfo.IsUseImage = set->value("/background/use_image", false).toBool();
    _sysConfigInfo.BackgroundSource = set->value("/background/current_source", "blue").toString();
    _sysConfigInfo.ImageDirPath = set->value("/background/image_dir", "Images/Background").toString();
    colors = set->value("/background/colors", "blue").toString();
    delete set;

    _sysConfigInfo.ListImages.clear();
    QDir dir(_sysConfigInfo.ImageDirPath);
    if(dir.exists())
    {
        dir.setFilter(QDir::Files | QDir::NoSymLinks);
        QStringList filters;
        filters << "*.png";
        dir.setNameFilters(filters);
        QStringList lstFiles = dir.entryList();
        if(lstFiles.count() > 0)
        {
            foreach (QString p, lstFiles) {
                _sysConfigInfo.ListImages.push_back(p);
            }
        }
    }

    QStringList strColors = colors.split(";");
    _sysConfigInfo.ListColors.clear();
    foreach (QString color, strColors) {
        _sysConfigInfo.ListColors.push_back(color);
    }


    return _sysConfigInfo;
}

/*!
 * \brief   set current background type and source
 * \param   backgroundType: background type, true: picture, false: solid color
 * \param   backgroundSource: background source, picture path or solid color
 * \return  true: write success, false: write false
 * \author  HenryMoore
 * \date    2018-09-02 16:41
 */
bool SystemConfigIO::WriteUsedBackgroundType(const bool &backgroundType, const QString &backgroundSource)
{
    _sysConfigInfo.IsUseImage = backgroundType;
    _sysConfigInfo.BackgroundSource = backgroundSource;

    QSettings *set = new QSettings(_sysConfigPath, QSettings::IniFormat);
    set->setValue("/background/use_image", _sysConfigInfo.IsUseImage);
    set->setValue("/background/current_source", _sysConfigInfo.BackgroundSource);

    delete set;

    return true;
}

/*!
 * \brief   add or remove background source
 * \param   backgroundType: background type, true: picture, false: solid color
 * \param   backgroundSource: background source, picture path or solid color
 * \return  true: write success, false: write false
 * \author  HenryMoore
 * \date    2018-09-02 16:41
 */
bool SystemConfigIO::ModifyBackground(const bool &backgroundType, const QString &backgroundSource)
{

}
