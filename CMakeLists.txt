cmake_minimum_required(VERSION 3.16)

project(qMonitoringApp VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick QuickControls2 Network)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appqMonitoringApp
    src/main.cpp
)

set(qml_singletons
        gui_widgets/AppTheme.qml
        gui_widgets/Router.qml
)

set_source_files_properties(${qml_singletons}
    PROPERTIES QT_QML_SINGLETON_TYPE TRUE
)

target_include_directories(appqMonitoringApp PRIVATE
    appqMonitoringApp PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/src/core/
    ${CMAKE_CURRENT_SOURCE_DIR}/src/core/NetworkManager
    ${CMAKE_CURRENT_SOURCE_DIR}/src/core/
)

qt_add_qml_module(appqMonitoringApp
    URI qMonitoringApp
    QML_FILES
        gui_widgets/Main.qml

        gui_widgets/pages/DashBoardPage.qml
        gui_widgets/pages/SettingsPage.qml
        gui_widgets/pages/AddServerPage.qml
        gui_widgets/pages/LoginPage.qml
        gui_widgets/pages/RAMView.qml
        gui_widgets/pages/MetricCard.qml
        gui_widgets/pages/NetworkView.qml
        gui_widgets/pages/ProcessView.qml
        gui_widgets/pages/SplashView.qml
        gui_widgets/pages/GPUView.qml
        gui_widgets/pages/StorageManager.qml
        gui_widgets/pages/CPUView.qml

        gui_widgets/DiskDelegate.qml
        gui_widgets/widgets/AppTextField.qml
        gui_widgets/AppTheme.qml
        gui_widgets/Router.qml
    SOURCES
        src/core/NetworkManager/authManager.h src/core/NetworkManager/authManager.cpp
        src/core/NetworkManager/networkDispatch.h src/core/NetworkManager/networkDispatch.cpp

        src/core/ApiManager/apiManager.h src/core/ApiManager/apiManager.cpp
        src/core/ApiManager/apiResult.cpp

        src/core/tokenPayload.h
        src/core/serializers.h src/core/serializers.cpp
        src/core/jsonapiparser.h src/core/jsonapiparser.cpp
        src/core/mainwindow.h src/core/mainwindow.cpp
        src/core/ApiManager/apirouter.h
)


# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appqMonitoringApp PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appqMonitoringApp
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
    QT_ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android"
)

target_link_libraries(appqMonitoringApp
    PRIVATE Qt6::Quick Qt6::QuickControls2 Qt6::Network
)

set(ANDROID_PERMISSIONS
    android.permission.INTERNET
    android.permission.ACCESS_NETWORK_STATE
)

set_property(TARGET appqMonitoringApp PROPERTY QT_ANDROID_PERMISSIONS "${ANDROID_PERMISSIONS}")


install(TARGETS appqMonitoringApp
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
if (ANDROID)
    include(/opt/android-sdk/android_openssl/CMakeLists.txt)
endif()
