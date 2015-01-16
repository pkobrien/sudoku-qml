# -*- coding: utf-8 -*-
"""
Main Game and Cell classes for PyQt QML Sudoku.

Hosted at https://github.com/pkobrien/qml-sudoku
"""

from PyQt5.QtCore import pyqtProperty, pyqtSignal, pyqtSlot, QObject, QVariant

import sudoku as su


class Cell(QObject):
    """Proxy class that handles all interactions with the su.Square class.
    
    This class does not have any UI elements. Instead it emits signals."""

    hintsChanged = pyqtSignal()
    valueAssigned = pyqtSignal()

    def __init__(self, game, square):
        super(Cell, self).__init__()
        self._game = game
        self._square = square

    @pyqtProperty(str)
    def assigned_value(self):
        if self._square.was_assigned:
            return self._square.solved_value
        else:
            return ''

    @pyqtProperty(QVariant)
    def hints(self):
        return QVariant([int(digit) - 1 
                         for digit in self._square.possible_digits])

    @pyqtSlot(str)
    def update(self, text):
        self._square.update(text)
        self._game._hints_changed()

    def _setup(self, square):
        self._square = square
        if self._square.was_assigned:
            self.valueAssigned.emit()
        else:
            self.hintsChanged.emit()


class Game(QObject):
    """Proxy class that handles all interactions with the su.Puzzle class.
    
    This class does not have any UI elements. Instead it emits signals."""

    puzzleReset = pyqtSignal()
    puzzleSetup = pyqtSignal()
    
    def __init__(self):
        super(Game, self).__init__()
        self._puzzle = su.Puzzle()
        self._cells = []
        for square in self._puzzle.squares:
            self._cells.append(Cell(self, square))

    @pyqtSlot(int, result=QObject)
    def get_cell(self, index):
        """Return cell QObject at the given index."""
        return self._cells[index]

    @pyqtSlot(int)
    def setup_random_puzzle(self, min_assigned_squares=40):
        self.puzzleReset.emit()
        self._puzzle.setup_random_grid(min_assigned_squares)
        for cell, square in zip(self._cells, self._puzzle.squares):
            cell._setup(square)
        self.puzzleSetup.emit()

    def _hints_changed(self):
        for cell in self._cells:
            cell.hintsChanged.emit()
