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
    valueChanged = pyqtSignal()

    def __init__(self, game, square):
        super(Cell, self).__init__()
        self._game = game
        self._square = square
        square.possible_digits_changed.connect(self._hints_changed)
        square.value_assigned.connect(self.valueAssigned.emit)
        square.value_changed.connect(self.valueChanged.emit)

    @pyqtProperty(str)
    def assigned_value(self):
        if self._square.was_assigned:
            return self._square.solved_value
        else:
            return ''

    @pyqtProperty(int)
    def box(self):
        return self._square.box.number - 1

    @pyqtProperty(str)
    def current_value(self):
        return self._square.current_value or ''

    @pyqtProperty(QVariant)
    def hints(self):
        return QVariant([int(digit) - 1 
                         for digit in self._square.possible_digits])

    @pyqtProperty(str)
    def solved_value(self):
        return self._square.solved_value or ''

    @pyqtSlot(str)
    def update(self, text):
        """Update square with the value of text."""
        self._square.update(text)

    def _hints_changed(self):
        """Emit hintsChanged when game is not in setup mode."""
        if not self._game.setup_mode:
            self.hintsChanged.emit()


class Game(QObject):
    """Proxy class that handles all interactions with the su.Puzzle class.
    
    This class does not have any UI elements. Instead it emits signals."""

    hintModeChanged = pyqtSignal()
    puzzleReset = pyqtSignal()
    puzzleSetup = pyqtSignal()
    
    def __init__(self):
        super(Game, self).__init__()
        self.setup_mode = False
        self._puzzle = su.Puzzle()
        self._cells = []
        for square in self._puzzle.squares:
            cell = Cell(self, square)
            self._cells.append(cell)
        self._show_hints = False

    @pyqtProperty(QVariant)
    def cells(self):
        return QVariant(self._cells)

    @pyqtProperty(bool, notify=hintModeChanged)
    def show_hints(self):
        return self._show_hints

    @show_hints.setter
    def show_hints(self, value):
        self._show_hints = value
        self.hintModeChanged.emit()

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
            if not cell.assigned_value:
                cell.hintsChanged.emit()
        self.puzzleSetup.emit()
