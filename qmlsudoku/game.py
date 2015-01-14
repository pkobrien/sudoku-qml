# -*- coding: utf-8 -*-
"""
Main Game class for PyQt QML Sudoku.

Hosted at https://github.com/pkobrien/qml-sudoku
"""

from PyQt5.QtCore import pyqtProperty, pyqtSignal, pyqtSlot, QObject

import sudoku as su


class Game(QObject):
    """Proxy class that handles all interactions with the su.Puzzle class.
    
    This class does not have any UI elements. Instead it emits signals."""

    puzzleReset = pyqtSignal()
    puzzleSetup = pyqtSignal()
    squareAssigned = pyqtSignal(int, str, arguments=['index', 'value'])
    
    def __init__(self):
        super(Game, self).__init__()
        self._puzzle = su.Puzzle()

    @pyqtSlot(int)
    def setup_random_puzzle(self, min_assigned_squares=40):
        self.puzzleReset.emit()
        self._puzzle.setup_random_grid(min_assigned_squares)
        for index, square in enumerate(self._puzzle.squares):
            if square.was_assigned:
                self.squareAssigned.emit(index, square.solved_value)
        self.puzzleSetup.emit()
