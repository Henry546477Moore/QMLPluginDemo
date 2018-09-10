#include "systemconfiginfo.h"
#include <QCoreApplication>
#include <QSettings>
#include <QDir>
#include <QFile>
#include <QTranslator>

SystemConfigInfo::SystemConfigInfo(QObject *parent) : QObject(parent)
{
    m_sysConfigPath = QString("%1/hmconfig.ini").arg(QCoreApplication::applicationDirPath());
    readConfig();
}

void SystemConfigInfo::readConfig()
{
    QFile f(m_sysConfigPath);
    if(!f.exists())
    {
        QSettings *set1 = new QSettings(m_sysConfigPath, QSettings::IniFormat);

        set1->setValue("/background/language", "zh_CN");
        set1->setValue("/background/use_image", false);
        set1->setValue("/background/current_source", "#006699");
        set1->setValue("/background/source_opacity", 0.8);
        set1->setValue("/background/image_dir", "Images/Background");
        set1->setValue("/background/colors", "#000099;#003399;#006699;#006600;#009900;#006633;#009933;#006666;#009966;#009999;#0000cc;#0033cc");
    }
    QSettings *set = new QSettings(m_sysConfigPath, QSettings::IniFormat);
    QString _language = set->value("/background/language", "zh_CN").toString();
    m_isUseBackgroundImg = set->value("/background/use_image", false).toBool();
    m_backgroundSource = set->value("/background/current_source", "#006699").toString();
    m_backgroundOpacity = set->value("/background/source_opacity", 0.8).toDouble();
    m_imgDirPath = set->value("/background/image_dir", "Images/Background").toString();
    QString colors = set->value("/background/colors", "#006699").toString();
    delete set;

    m_listBackgroundImgs.clear();
    m_imgDirPath = QString("%1/%2").arg(QCoreApplication::applicationDirPath()).arg(m_imgDirPath);
    QDir dir(m_imgDirPath);
    if(dir.exists())
    {
        dir.setFilter(QDir::Files | QDir::NoSymLinks);
        QStringList filters;
        filters << "*.png" << "*.jpg";
        dir.setNameFilters(filters);
        QStringList lstFiles = dir.entryList();
        if(lstFiles.count() > 0)
        {
            foreach (QString p, lstFiles) {
                m_listBackgroundImgs.push_back(QString("file:%1/%2").arg(m_imgDirPath).arg(p));
            }
        }
    }

    QStringList strColors = colors.split(";");
    m_listBackgroundColors.clear();
    foreach (QString color, strColors) {
        m_listBackgroundColors.push_back(color);
    }

    setCurrentLanguage(_language);
}


QString SystemConfigInfo::currentLanguage()
{
    return m_currentLanguage;
}
QTranslator *trans = nullptr;
void SystemConfigInfo::setCurrentLanguage(const QString &currentLanguage)
{
    if(currentLanguage != m_currentLanguage)
    {
        m_currentLanguage = currentLanguage;

        QSettings *set = new QSettings(m_sysConfigPath, QSettings::IniFormat);
        set->setValue("/background/language", m_currentLanguage);
        delete set;

        if(trans == nullptr)
        {
            trans = new QTranslator;
            qApp->installTranslator(trans);
        }

        QString languagePath(QString("%1/languages/%2.qm").arg(QCoreApplication::applicationDirPath()).arg(currentLanguage));
        trans->load(languagePath);

        emit currentLanguageChanged();
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

void SystemConfigInfo::setBackgroundSource(const bool &isImg, const QString &source)
{
    setIsUseBackgroundImg(isImg);
    setBackgroundSource(source);
}


void SystemConfigInfo::addBackgroundSource(const bool &isImg, const QString &source)
{
    if(isImg)
    {
        QString filePath = source;
        if(source.startsWith("file:///"))
        {
            filePath = filePath.replace("file:///", "");
        }
        QFile f(filePath);
        if(f.exists())
        {
            QString fileName = QFileInfo(filePath).fileName();
            QString destPath = QString("%1/%2").arg(m_imgDirPath).arg(fileName);
            if(!m_listBackgroundImgs.contains(destPath))
            {
                f.copy(destPath);
                m_listBackgroundImgs.push_front(QString("file:%1").arg(destPath));
                emit listBackgroundImgsChanged();
            }
        }
    }
    else
    {
        if(!m_listBackgroundColors.contains(source))
        {
            m_listBackgroundColors.push_front(source);

            QSettings *set = new QSettings(m_sysConfigPath, QSettings::IniFormat);
            set->setValue("/background/colors", m_listBackgroundColors.join(";"));

            emit listBackgroundColorsChanged();
        }
    }
}
