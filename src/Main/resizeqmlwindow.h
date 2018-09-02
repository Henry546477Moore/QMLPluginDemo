#ifndef RESIZEQMLWINDOW_H
#define RESIZEQMLWINDOW_H

#include <QObject>
#include <QWindow>

class ResizeQmlWindow : public QObject
{
    Q_OBJECT
public:
    explicit ResizeQmlWindow(QObject *parent = nullptr) : QObject(parent){}
    void setWindow(QWindow *win){
        m_win = win;
        m_win->setFlags(Qt::FramelessWindowHint | Qt::Window);
    }

    Q_INVOKABLE void setMyCursor(int direct){
        switch (direct) {
        case 1:
            m_win->setCursor(QCursor(Qt::SizeFDiagCursor));
            break;
        case 2:
            m_win->setCursor(QCursor(Qt::SizeVerCursor));
            break;
        case 3:
            m_win->setCursor(QCursor(Qt::SizeBDiagCursor));
            break;
        case 4:
            m_win->setCursor(QCursor(Qt::SizeHorCursor));
            break;
        case 5:
            m_win->setCursor(QCursor(Qt::ArrowCursor));
            break;
        case 6:
            m_win->setCursor(QCursor(Qt::SizeHorCursor));
            break;
        case 7:
            m_win->setCursor(QCursor(Qt::SizeBDiagCursor));
            break;
        case 8:
            m_win->setCursor(QCursor(Qt::SizeVerCursor));
            break;
        case 9:
            m_win->setCursor(QCursor(Qt::SizeFDiagCursor));
            break;
        }
    }

private:
    QWindow *m_win;
};

#endif // RESIZEQMLWINDOW_H
