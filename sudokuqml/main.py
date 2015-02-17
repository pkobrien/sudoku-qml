# -*- coding: utf-8 -*-
"""
Main application for Sudoku using PyQt and QML.

Hosted at https://github.com/pkobrien/sudoku-qml
"""

from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine

from game import Game


def _find_plugins():
    import PyQt5
    from os import path
    paths = [path.abspath(path.join(path.dirname(PyQt5.__file__), 'plugins'))]
    import PyQt5.QtCore
    PyQt5.QtCore.QCoreApplication.setLibraryPaths(paths)


if __name__ == '__main__':
    import os
    import sys
    _find_plugins()
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    context = engine.rootContext()
    game = Game()
    context.setContextProperty('game', game)
    qml_filename = os.path.join(os.path.dirname(__file__), 'main.qml')
    engine.load(qml_filename)
    sys.exit(app.exec_())
