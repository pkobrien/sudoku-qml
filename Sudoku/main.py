# -*- coding: utf-8 -*-
"""
Main application for Sudoku using PyQt and QML.

Hosted at https://github.com/pkobrien/sudoku-qml
"""

from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine

from PyQt5.QtCore import pyqtProperty, pyqtSignal, QObject, QVariant

from game import Game


class Namespace(QObject):
    """Namespace to add clarity on the QML side, contains all Python objects
    exposed to the QML root context as attributes."""

    gameChanged = pyqtSignal()

    def __init__(self):
        super(Namespace, self).__init__()
        self._game = Game()

    @pyqtProperty(QObject, notify=gameChanged)
    def game(self):
        return self._game


if __name__ == '__main__':
    from os import path
    import PyQt5
    import sys
    app = QGuiApplication(sys.argv)
    app.addLibraryPath(path.abspath(path.join(path.dirname(PyQt5.__file__), 'plugins')))
    engine = QQmlApplicationEngine()
    engine.addImportPath('../../qml-candy')
    context = engine.rootContext()
    py = Namespace()
    context.setContextProperty('py', py)
    qml_filename = path.join(path.dirname(__file__), 'Sudoku.qml')
    engine.load(qml_filename)
    sys.exit(app.exec_())
