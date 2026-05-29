#include "mainwindow.h"

MainWindow::MainWindow() {
    m_networkDispatch = new NetworkDispatch(this);
}
