#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QQmlContext>
#include "mainwindow.h"
int main(int argc, char *argv[]) {
    QQuickStyle::setStyle("Material");

    MainWindow w;
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;


    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("qMonitoringApp", "Main");

    return QCoreApplication::exec();
}
