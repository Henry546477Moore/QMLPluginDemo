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
    Q_PROPERTY(QString appTitle READ appTitle)
    Q_PROPERTY(int closeType READ closeType NOTIFY closeTypeChanged)
    Q_PROPERTY(bool remberCloseType READ remberCloseType NOTIFY remberCloseTypeChanged)
    Q_PROPERTY(bool isUseBackgroundImg READ isUseBackgroundImg WRITE setIsUseBackgroundImg NOTIFY isUseBackgroundImgChanged)
    Q_PROPERTY(QString backgroundSource READ backgroundSource NOTIFY backgroundSourceChanged)
    Q_PROPERTY(double backgroundOpacity READ backgroundOpacity WRITE setBackgroundOpacity NOTIFY backgroundOpacityChanged)
    Q_PROPERTY(QList<QObject *> listSources READ listSources NOTIFY listSourcesChanged)

public:
    explicit SystemConfigInfo(QObject *parent = nullptr);
    Q_INVOKABLE void setCurrentLanguage(const QString &currentLanguage);
    Q_INVOKABLE void setBackgroundSource(QObject *source);
    Q_INVOKABLE void addBackgroundSource(const bool &isImg, const QString &source);
    Q_INVOKABLE void setBackgroundOpacity(const double &backgroundOpacity);
    Q_INVOKABLE bool invalidUser(const QString &userName, const QString &pwd);
    Q_INVOKABLE void setMainWindowCloseType(const int &closeType, const bool &isRemberType);

signals:
    void currentLanguageChanged();
    void isUseBackgroundImgChanged();
    void closeTypeChanged();
    void remberCloseTypeChanged();
    void backgroundSourceChanged();
    void backgroundOpacityChanged();
    void listSourcesChanged();

private:
    QString appTitle();

    QString currentLanguage();

    int closeType();
    bool remberCloseType();

    bool isUseBackgroundImg();
    void setIsUseBackgroundImg(const bool &isUseBackgroundImg);

    QString backgroundSource();
    void setCurrentBackgroundSource(const QString &backgroundSource);

    double backgroundOpacity();

    QList<QObject *> listSources();

    void readConfig();
    bool existSource(const QString &source);

    QString stringToMD5(const QString &source);

private:
    QString m_appTitle;
    QString m_userName;
    QString m_pwd;
    int m_closeType;
    bool m_isRemberCloseType;
    QString m_currentLanguage;
    bool m_isUseBackgroundImg;
    QString m_backgroundSource;
    double m_backgroundOpacity;
    QList<QObject *> m_listSources;
    QString m_sysConfigPath;
    QString m_imgDirPath;
};


#endif // SYSTEMCONFIGINFO_H
