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

    def __init__(self, game, square):
        super(Cell, self).__init__()
        self._game = game
        self._square = square
        square.possible_digits_changed.connect(self._hints_changed)

    @pyqtProperty(int)
    def box(self):
        return self._square.box.number - 1

    @pyqtProperty(int)
    def column(self):
        return self._square.column.number - 1

    @pyqtProperty(QVariant)
    def hints(self):
        return QVariant([int(digit) - 1 
                         for digit in self._square.possible_digits])

    @pyqtProperty(int)
    def row(self):
        return self._square.row.number - 1

    @pyqtProperty(str)
    def solved_value(self):
        return self._square.solved_value or ''

    @pyqtProperty(bool)
    def was_assigned(self):
        return self._square.was_assigned

    @pyqtSlot(str)
    def update(self, text):
        """Update square with the value of text."""
        self._square.update(text)
        if self._game.is_solved:
            self._game.puzzleSolved.emit()

    def _hints_changed(self):
        """Emit hintsChanged when game is not in setup mode."""
        if not self._game.setup_mode:
            self.hintsChanged.emit()


class Game(QObject):
    """Proxy class that handles all interactions with the su.Puzzle class.
    
    This class does not have any UI elements. Instead it emits signals."""

    puzzleReset = pyqtSignal()
    puzzleSetup = pyqtSignal()
    puzzleSolved = pyqtSignal()

    def __init__(self):
        super(Game, self).__init__()
        self.setup_mode = False
        self._puzzle = su.Puzzle()
        self._cells = []
        for square in self._puzzle.squares:
            cell = Cell(self, square)
            self._cells.append(cell)

    @pyqtProperty(QVariant)
    def cells(self):
        return QVariant(self._cells)

    @pyqtProperty(bool)
    def is_solved(self):
        return self._puzzle.is_solved

    @pyqtSlot(int)
    def setup_random_puzzle(self, min_assigned_squares):
        """Setup a random puzzle with a minimum number of assigned squares."""
        self.setup_mode = True
        self.puzzleReset.emit()
        self._puzzle.setup_random_grid(min_assigned_squares)
        self.setup_mode = False
        for cell in self._cells:
            # It's faster if we wait until the puzzle is set up, then emit
            # this signal for all cells that were not assigned a value.
            if not cell.was_assigned:
                cell.hintsChanged.emit()
        self.puzzleSetup.emit()
