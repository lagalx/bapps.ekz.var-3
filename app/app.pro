QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

CONFIG += c++17

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
    cardwidget.cpp \
    crypton.cpp \
    main.cpp \
    mainwindow.cpp \
    promowindow.cpp

HEADERS += \
    cardwidget.h \
    crypton.h \
    mainwindow.h \
    password.h \
    promowindow.h

FORMS += \
    cardwidget.ui \
    mainwindow.ui \
    promowindow.ui

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

include($$PWD/../Qt-Secret/src/Qt-Secret.pri)


# Выбираем директорию сборки исполняемого файла
# в зависимости от режима сборки проекта
CONFIG(debug, debug|release) {
    DESTDIR = $$OUT_PWD/debug
} else {
    DESTDIR = $$OUT_PWD/release
}

COMMON_DIR = $$OUT_PWD/common
# разделяем по директориям все выходные файлы проекта
MOC_DIR = $$COMMON_DIR/moc
RCC_DIR = $$COMMON_DIR/rcc
UI_DIR = $$COMMON_DIR/ui

unix:OBJECTS_DIR = $$COMMON_DIR/o/unix
win32:OBJECTS_DIR = $$COMMON_DIR/o/win32
macx:OBJECTS_DIR = $$COMMON_DIR/o/mac

# Добавляем модуль file_copies
CONFIG += file_copies

# Добавляем переменную, описывающую копируемые файлы
COPIES +=   \
            qt_secret \

QT_SECRET_DIR = $$PWD/../Qt-Secret
QT_SECRET_MINI_GMP = $$QT_SECRET_DIR/src/mini-gmp/src/build
QT_SECRET_BUILD = $$QT_SECRET_DIR/src/build

# в зависимости от режима сборки проекта
# запускаем win deploy приложения в целевой директории, то есть собираем все dll
CONFIG(debug, debug|release) {
    QT_SECRET_MINI_GMP = $$QT_SECRET_MINI_GMP/debug
    QT_SECRET_BUILD = $$QT_SECRET_BUILD/debug
} else {
    QT_SECRET_MINI_GMP = $$QT_SECRET_MINI_GMP/release
    QT_SECRET_BUILD = $$QT_SECRET_BUILD/release

    QMAKE_POST_LINK += $$(QTDIR)/bin/windeployqt $$DESTDIR
}

# Определяем, с каким расширением нам необохдимо скопировать файлы и по какому пути они расположены
qt_secret.files += $$files($$QT_SECRET_MINI_GMP/*.dll)
qt_secret.files += $$files($$QT_SECRET_BUILD/*.dll)

# Указываем путь, куда копировать файлы
qt_secret.path = $$DESTDIR
