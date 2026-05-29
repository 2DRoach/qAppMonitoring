#ifndef MAINWINDOW_H
#define MAINWINDOW_H
#include <QObject>
#include "../core/NetworkManager/networkDispatch.h"

class MainWindow : public QObject{
    Q_OBJECT
public:
    MainWindow();
    NetworkDispatch* getNetworkDispatch() {return m_networkDispatch;}
private:
    NetworkDispatch* m_networkDispatch;

};

#endif // MAINWINDOW_H
