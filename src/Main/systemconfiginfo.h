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
    Q_PROPERTY(bool isUseBackgroundImg READ isUseBackgroundImg WRITE setIsUseBackgroundImg NOTIFY isUseBackgroundImgChanged)
    Q_PROPERTY(QString backgroundSource READ backgroundSource WRITE setBackgroundSource NOTIFY backgroundSourceChanged)
    Q_PROPERTY(double backgroundOpacity READ backgroundOpacity WRITE setBackgroundOpacity NOTIFY backgroundOpacityChanged)
    Q_PROPERTY(QStringList listBackgroundImgs READ listBackgroundImgs)
    Q_PROPERTY(QStringList listBackgroundColors READ listBackgroundColors)

public:
    explicit SystemConfigInfo(QObject *parent = nullptr);
    Q_INVOKABLE void setBackgroundSource(const bool &isImg, const QString &source);
    Q_INVOKABLE void addBackgroundSource(const bool &isImg, const QString &source);
    Q_INVOKABLE void removeBackgroundSource(const bool &isImg, const QString &source);
    Q_INVOKABLE void setBackgroundOpacity(const double &backgroundOpacity);

signals:
    void isUseBackgroundImgChanged();
    void backgroundSourceChanged();
    void backgroundOpacityChanged();

private:
    bool isUseBackgroundImg();
    void setIsUseBackgroundImg(const bool &isUseBackgroundImg);

    QString backgroundSource();
    void setBackgroundSource(const QString &backgroundSource);

    double backgroundOpacity();

    QStringList listBackgroundImgs();

    QStringList listBackgroundColors();

    void readConfig();

private:
    bool m_isUseBackgroundImg;
    QString m_backgroundSource;
    double m_backgroundOpacity;
    QStringList m_listBackgroundImgs;
    QStringList m_listBackgroundColors;
    QString m_sysConfigPath;
    QString m_imgDirPath;
};


#endif // SYSTEMCONFIGINFO_H
