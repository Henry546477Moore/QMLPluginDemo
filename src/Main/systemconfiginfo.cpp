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
    QSettings *set = new QSettings(m_sysConfigPath, QSettings::IniFormat);
    QFile f(m_sysConfigPath);
    if(!f.exists())
    {
        set->setValue("/system/language", "zh_CN");
        set->setValue("/system/title", "qml plugin application");
        set->setValue("/background/use_image", false);
        set->setValue("/background/current_source", "#006699");
        set->setValue("/background/source_opacity", 0.8);
        set->setValue("/background/image_dir", "Images/Background");
        set->setValue("/background/colors", "#000099;#003399;#006699;#006600;#009900;#006633;#009933;#006666;#009966;#009999;#0000cc;#0033cc");
    }

    QString _language = set->value("/system/language", "zh_CN").toString();
    m_appTitle = set->value("/system/title", "qml plugin application").toString();
    m_isUseBackgroundImg = set->value("/background/use_image", false).toBool();
    m_backgroundSource = set->value("/background/current_source", "#006699").toString();
    m_backgroundOpacity = set->value("/background/source_opacity", 0.8).toDouble();
    m_imgDirPath = set->value("/background/image_dir", "Images/Background").toString();
    QString colors = set->value("/background/colors", "#006699").toString();
    delete set;

    m_listSources.clear();
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
                BackgroundSource *bgSource = new BackgroundSource(true, QString("file:%1/%2").arg(m_imgDirPath).arg(p));
                m_listSources.push_back(bgSource);
            }
        }
    }


    QStringList strColors = colors.split(";");
    foreach (QString color, strColors) {
        BackgroundSource *bgSource = new BackgroundSource(false, color);
        m_listSources.push_back(bgSource);
    }

    setCurrentLanguage(_language);
}

QString SystemConfigInfo::appTitle()
{
    return m_appTitle;
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
        set->setValue("/system/language", m_currentLanguage);
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

void SystemConfigInfo::setCurrentBackgroundSource(const QString &backgroundSource)
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

QList<QObject *> SystemConfigInfo::listSources()
{
    return m_listSources;
}

void SystemConfigInfo::setBackgroundSource(QObject *source)
{
    BackgroundSource *bgSource = dynamic_cast<BackgroundSource *>(source);
    setIsUseBackgroundImg(bgSource->isImgSource());
    setCurrentBackgroundSource(bgSource->source());
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
            if(!existSource(destPath))
            {
                f.copy(destPath);
                BackgroundSource *bgSource = new BackgroundSource(true, QString("file:%1").arg(destPath));
                m_listSources.push_front(bgSource);

                emit listSourcesChanged();
            }
        }
    }
    else
    {
        if(!existSource(source))
        {
            BackgroundSource *bgSource = new BackgroundSource(false, source);
            m_listSources.push_front(bgSource);

            QSettings *set = new QSettings(m_sysConfigPath, QSettings::IniFormat);

            QString colors = set->value("/background/colors", "#006699").toString();
            QStringList lstColors = colors.split(";");
            lstColors.push_front(source);
            set->setValue("/background/colors", lstColors.join(";"));
            delete set;

            emit listSourcesChanged();
        }
    }
}

bool SystemConfigInfo::existSource(const QString &source)
{
    bool exist(false);

    foreach (QObject *bgSource, m_listSources) {
        if(source == dynamic_cast<BackgroundSource *>(bgSource)->source()) {
            exist = true;
            break;
        }
    }

    return exist;
}
