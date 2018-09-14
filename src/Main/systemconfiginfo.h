#ifndef SYSTEMCONFIGINFO_H
#define SYSTEMCONFIGINFO_H

#include <QObject>
#include <QList>
#include <QString>
#include <QColor>
#include <QStringList>
#include "backgroundsource.h"

/*!
 * \brief  The SystemConfigInfo class
 * \author HenryMoore
 * \date   2018-09-2 16:28
 */
class SystemConfigInfo : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString currentLanguage READ currentLanguage WRITE setCurrentLanguage NOTIFY currentLanguageChanged)
    Q_PROPERTY(bool isUseBackgroundImg READ isUseBackgroundImg WRITE setIsUseBackgroundImg NOTIFY isUseBackgroundImgChanged)
    Q_PROPERTY(QString backgroundSource READ backgroundSource WRITE setBackgroundSource NOTIFY backgroundSourceChanged)
    Q_PROPERTY(double backgroundOpacity READ backgroundOpacity WRITE setBackgroundOpacity NOTIFY backgroundOpacityChanged)
    Q_PROPERTY(QList<QObject *> listSources READ listSources NOTIFY listSourcesChanged)

public:
    explicit SystemConfigInfo(QObject *parent = nullptr);
    Q_INVOKABLE void setCurrentLanguage(const QString &currentLanguage);
    Q_INVOKABLE void setBackgroundSource(QObject *source);
    Q_INVOKABLE void addBackgroundSource(const bool &isImg, const QString &source);
    Q_INVOKABLE void setBackgroundOpacity(const double &backgroundOpacity);

signals:
    void currentLanguageChanged();
    void isUseBackgroundImgChanged();
    void backgroundSourceChanged();
    void backgroundOpacityChanged();
    void listSourcesChanged();

private:
    QString currentLanguage();

    bool isUseBackgroundImg();
    void setIsUseBackgroundImg(const bool &isUseBackgroundImg);

    QString backgroundSource();
    void setBackgroundSource(const QString &backgroundSource);

    double backgroundOpacity();

    QList<QObject *> listSources();

    void readConfig();
    bool existSource(const QString &source);

private:
    QString m_currentLanguage;
    bool m_isUseBackgroundImg;
    QString m_backgroundSource;
    double m_backgroundOpacity;
    QList<QObject *> m_listSources;
    QString m_sysConfigPath;
    QString m_imgDirPath;
};


#endif // SYSTEMCONFIGINFO_H
