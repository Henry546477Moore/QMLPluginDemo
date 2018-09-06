#ifndef SYSTEMCONFIGINFO_H
#define SYSTEMCONFIGINFO_H

#include <QObject>
#include <QList>
#include <QString>
#include <QColor>

/*!
 * \brief  The SystemConfigInfo class
 * \author HenryMoore
 * \date   2018-09-2 16:28
 */
class SystemConfigInfo : public QObject
{
    Q_OBJECT
public:
    /*!
     * \brief IsUseImage the system background type,
     * true: use image to show app background,
     * false: use color to show app background
     */
    bool IsUseImage;
    /*!
     * \brief BackgroundSource
     * The system background source may use a picture or a solid color.
     */
    QColor BackgroundSource;
    /*!
     * \brief ImageDirPath
     * The system background picture source directory path
     */
    QString ImageDirPath;
    /*!
     * \brief ListImages
     * All background picture
     */
    QList<QString> ListImages;
    /*!
     * \brief ListColors
     * All background solid color
     */
    QList<QString> ListColors;
};


#endif // SYSTEMCONFIGINFO_H
