#ifndef SYSTEMCONFIGINFO_H
#define SYSTEMCONFIGINFO_H

#include <QObject>
#include <QList>
#include <QString>
#include <QColor>
#include <QStringList>

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
    Q_PROPERTY(QStringList listBackgroundImgs READ listBackgroundImgs NOTIFY listBackgroundImgsChanged)
    Q_PROPERTY(QStringList listBackgroundColors READ listBackgroundColors NOTIFY listBackgroundColorsChanged)

public:
    explicit SystemConfigInfo(QObject *parent = nullptr);
    Q_INVOKABLE void setCurrentLanguage(const QString &currentLanguage);
    Q_INVOKABLE void setBackgroundSource(const bool &isImg, const QString &source);
    Q_INVOKABLE void addBackgroundSource(const bool &isImg, const QString &source);
    Q_INVOKABLE void setBackgroundOpacity(const double &backgroundOpacity);

signals:
    void currentLanguageChanged();
    void isUseBackgroundImgChanged();
    void backgroundSourceChanged();
    void backgroundOpacityChanged();
    void listBackgroundImgsChanged();
    void listBackgroundColorsChanged();

private:
    QString currentLanguage();

    bool isUseBackgroundImg();
    void setIsUseBackgroundImg(const bool &isUseBackgroundImg);

    QString backgroundSource();
    void setBackgroundSource(const QString &backgroundSource);

    double backgroundOpacity();

    QStringList listBackgroundImgs();

    QStringList listBackgroundColors();

    void readConfig();

private:
    QString m_currentLanguage;
    bool m_isUseBackgroundImg;
    QString m_backgroundSource;
    double m_backgroundOpacity;
    QStringList m_listBackgroundImgs;
    QStringList m_listBackgroundColors;
    QString m_sysConfigPath;
    QString m_imgDirPath;
};


#endif // SYSTEMCONFIGINFO_H
