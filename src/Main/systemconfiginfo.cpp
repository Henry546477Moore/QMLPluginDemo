#include "systemconfiginfo.h"
#include <QCoreApplication>
#include <QSettings>
#include <QDir>
#include <QFile>

SystemConfigInfo::SystemConfigInfo(QObject *parent) : QObject(parent)
{
    m_sysConfigPath = QString("%1/hmconfig.ini").arg(QCoreApplication::applicationDirPath());
    readConfig();
}

void SystemConfigInfo::readConfig()
{
    QSettings *set = new QSettings(m_sysConfigPath, QSettings::IniFormat);
    m_isUseBackgroundImg = set->value("/background/use_image", false).toBool();
    m_backgroundSource = set->value("/background/current_source", "lightblue").toString();
    m_backgroundOpacity = set->value("/background/source_opacity", 0.8).toDouble();
    m_imgDirPath = set->value("/background/image_dir", "Images/Background").toString();
    QString colors = set->value("/background/colors", "red;blue;green;#989899;black").toString();
    delete set;

    m_listBackgroundImgs.clear();
    QDir dir(m_imgDirPath);
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
                m_listBackgroundImgs.push_back(p);
            }
        }
    }

    QStringList strColors = colors.split(";");
    m_listBackgroundColors.clear();
    foreach (QString color, strColors) {
        m_listBackgroundColors.push_back(color);
    }
}

bool SystemConfigInfo::isUseBackgroundImg()
{
    return m_isUseBackgroundImg;
}

void SystemConfigInfo::setIsUseBackgroundImg(const bool &isUseBackgroundImg)
{
    if(isUseBackgroundImg != m_isUseBackgroundImg)
    {
        m_isUseBackgroundImg = isUseBackgroundImg;

        QSettings *set = new QSettings(m_sysConfigPath, QSettings::IniFormat);
        set->setValue("/background/use_image", m_isUseBackgroundImg);
        delete set;

        emit isUseBackgroundImgChanged();
    }
}

QString SystemConfigInfo::backgroundSource()
{
    return m_backgroundSource;
}
void SystemConfigInfo::setBackgroundSource(const QString &backgroundSource)
{
    if(backgroundSource != m_backgroundSource)
    {
        m_backgroundSource = backgroundSource;

        QSettings *set = new QSettings(m_sysConfigPath, QSettings::IniFormat);
        set->setValue("/background/current_source", m_backgroundSource);

        delete set;

        emit backgroundSourceChanged();
    }
}

double SystemConfigInfo::backgroundOpacity()
{
    return m_backgroundOpacity;
}

void SystemConfigInfo::setBackgroundOpacity(const double &backgroundOpacity)
{
    if(backgroundOpacity != m_backgroundOpacity)
    {
        m_backgroundOpacity = backgroundOpacity;

        QSettings *set = new QSettings(m_sysConfigPath, QSettings::IniFormat);
        set->setValue("/background/source_opacity", m_backgroundOpacity);
        delete set;

        emit backgroundOpacityChanged();
    }
}

QStringList SystemConfigInfo::listBackgroundImgs()
{
    return m_listBackgroundImgs;
}

QStringList SystemConfigInfo::listBackgroundColors()
{
    return m_listBackgroundColors;
}


void SystemConfigInfo::addBackgroundSource(const bool &isImg, const QString &source)
{
    if(isImg)
    {
        QFile f(source);
        if(f.exists())
        {
            f.remove();
        }
    }
    else
    {

    }
}

void SystemConfigInfo::removeBackgroundSource(const bool &isImg, const QString &source)
{

}
