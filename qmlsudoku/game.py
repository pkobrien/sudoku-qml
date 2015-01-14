# -*- coding: utf-8 -*-
"""
Main Game and Cell classes for PyQt QML Sudoku.

Hosted at https://github.com/pkobrien/qml-sudoku
"""

from PyQt5.QtCore import pyqtProperty, pyqtSignal, pyqtSlot, QObject

import sudoku as su


class Cell(QObject):
    """Proxy class that handles all interactions with the su.Square class.
    
    This class does not have any UI elements. Instead it emits signals."""

    hintChanged = pyqtSignal()
    valueAssigned = pyqtSignal()

    def __init__(self, square):
        super(Cell, self).__init__()
        self._square = square

    @pyqtProperty(str)
    def assigned_value(self):
        if self._square.was_assigned:
            return self._square.solved_value
        else:
            return ''

    def _setup(self, square):
        self._square = square
        if self._square.was_assigned:
            self.valueAssigned.emit()


class Game(QObject):
    """Proxy class that handles all interactions with the su.Puzzle class.
    
    This class does not have any UI elements. Instead it emits signals."""

    puzzleReset = pyqtSignal()
    puzzleSetup = pyqtSignal()
    squareAssigned = pyqtSignal(int, str, arguments=['index', 'value'])
    
    def __init__(self):
        super(Game, self).__init__()
        self._puzzle = su.Puzzle()
        self._cells = []
        for square in self._puzzle.squares:
            self._cells.append(Cell(square))

    @pyqtSlot(int, result=QObject)
    def get_cell(self, index):
        """Return cell QObject at the given index."""
        return self._cells[index]

    @pyqtSlot(int)
    def setup_random_puzzle(self, min_assigned_squares=40):
        print('puzzleReset.emit')
        self.puzzleReset.emit()
        self._puzzle.setup_random_grid(min_assigned_squares)
        for cell, square in zip(self._cells, self._puzzle.squares):
            cell._setup(square)
        self.puzzleSetup.emit()
