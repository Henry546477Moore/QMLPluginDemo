#include "backgroundsource.h"

BackgroundSource::BackgroundSource(QObject * parent) : QObject(parent) {

}
BackgroundSource::BackgroundSource(const bool &isImg, const QString &source, QObject * parent) :
                   QObject(parent), m_isImgSource(isImg), m_source(source) {

}

bool BackgroundSource::isImgSource() {
    return m_isImgSource;
}

QString BackgroundSource::source() {
    return m_source;
}
