# -*- coding: utf-8 -*-
"""
Main application for Sudoku using PyQt and QML.

Hosted at https://github.com/pkobrien/sudoku-qml
"""

from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine

from game import Game


def _bug_fix():
    """PyQt needs help finding plugins directory in a virtual environment."""
    paths = [os.path.abspath(os.path.join(os.path.dirname(__file__),
             os.path.pardir, 'env/Lib/site-packages/PyQt5/plugins'))]
    import PyQt5.QtCore
    PyQt5.QtCore.QCoreApplication.setLibraryPaths(paths)


if __name__ == '__main__':
    import os
    import sys
    _bug_fix()
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    context = engine.rootContext()
    game = Game()
    context.setContextProperty('game', game)
    qml_filename = os.path.join(os.path.dirname(__file__), 'main.qml')
    engine.load(qml_filename)
    sys.exit(app.exec_())
