#ifndef SYSTEMCONFIGIO_H
#define SYSTEMCONFIGIO_H

#include <QObject>
#include "systemconfiginfo.h"

/*!
 * \brief  The SystemConfigIO class
 * 1、read some data form app config info
 * 2、write some data to app config info
 * \author HenryMoore
 * \date   2018-09-2 16:23
 */
class SystemConfigIO : public QObject
{
    Q_OBJECT
public:
    explicit SystemConfigIO(QObject *parent = nullptr);
    /*!
     * \breif   read system config
     * \return  system config info
     * \author  HenryMoore
     * \date    2018-09-02 16:38
     */
    Q_INVOKABLE SystemConfigInfo& ReadConfig();
    /*!
     * \brief   set current background type and source
     * \param   backgroundType: background type, true: picture, false: solid color
     * \param   backgroundSource: background source, picture path or solid color
     * \return  true: write success, false: write false
     * \author  HenryMoore
     * \date    2018-09-02 16:41
     */
    Q_INVOKABLE bool WriteUsedBackgroundType(const bool &backgroundType, const QString &backgroundSource);
    /*!
     * \brief   add or remove background source
     * \param   backgroundType: background type, true: picture, false: solid color
     * \param   backgroundSource: background source, picture path or solid color
     * \return  true: write success, false: write false
     * \author  HenryMoore
     * \date    2018-09-02 16:41
     */
    Q_INVOKABLE bool ModifyBackground(const bool &backgroundType, const QString &backgroundSource);

signals:

public slots:

private:
    SystemConfigInfo _sysConfigInfo;
    QString _sysConfigPath;
};

#endif // SYSTEMCONFIGIO_H
