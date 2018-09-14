#ifndef BACKGROUNDSOURCE_H
#define BACKGROUNDSOURCE_H

#include <QObject>
#include <QString>

class BackgroundSource : public QObject {
    Q_OBJECT
    Q_PROPERTY(bool isImgSource READ isImgSource NOTIFY isImgSourceChanged)
    Q_PROPERTY(QString source READ source NOTIFY sourceChanged)
public:
    Q_INVOKABLE BackgroundSource(QObject * parent = 0);
    Q_INVOKABLE BackgroundSource(const bool &isImg, const QString &source, QObject * parent = 0);

    bool isImgSource();
    QString source();

signals:
    void isImgSourceChanged();
    void sourceChanged();

private:
    bool m_isImgSource;
    QString m_source;
};


#endif // BACKGROUNDSOURCE_H
