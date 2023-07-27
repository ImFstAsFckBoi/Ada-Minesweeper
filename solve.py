import numpy as np
from dataclasses import dataclass
from typing import List
from itertools import product

"""
* * 1 . .
2 2 2 . .
1 1 . . .
* 1 1 1 .
1 1 * 1 .
"""
"""
11.
1..
...
"""

"""
0 1 2
"""


EMPTY = 1
MINE = 2
BOTH = 3


@dataclass
class Cell:
    superposition: int
    count: int
    hidden_count: int

    def __repr__(self) -> str:
        return self.__str__()

    def __str__(self) -> str:
        if self.superposition == MINE:
            return "*"
        elif self.superposition == BOTH:
            return "?"
        elif self.superposition == EMPTY:
            if self.count == 0:
                return " "
            else:
                return str(self.count)
        else:
            return "!"


def collapse(cell: Cell,
             adjacent: List[Cell]) -> List[Cell]:
    unknowns = [c for c in adjacent if c.superposition == BOTH]
    mines = [c for c in adjacent if c.superposition == MINE]

    if len(unknowns) + len(mines) == cell.count:
        for c in unknowns:
            c.superposition = MINE
            c.count = 9
            unknowns.remove(c)
            mines.append(c)

    if cell.count == len(mines):
        for c in unknowns:
            c.superposition = EMPTY
            c.count = c.hidden_count
    return adjacent


MAX_Y = 5
MAX_X = 5

"""
11100
1*100
11100
00122
001**
"""


def board_print(board, x, y):
    print()
    for _y in range(MAX_Y):
        for _x in range(MAX_X):
            if _y == y and _x == x:
                print(f"({board[_y, _x]})", end="")
            else:
                print(f" {board[_y, _x]}", end=" ")
        print()
    print()


board = np.array([Cell(BOTH, 9, 0) for _ in range(25)])
board = board.reshape((MAX_Y, MAX_X))
counts = np.array([[1, 1, 2, 9, 9],
                   [1, 9, 2, 2, 2],
                   [1, 1, 1, 0, 0],
                   [0, 0, 1, 2, 2],
                   [0, 0, 1, 9, 9]])


for y in range(MAX_Y):
    for x in range(MAX_X):
        board[y, x].hidden_count = counts[y, x]

board[0, 0] = Cell(EMPTY, 1, 1)
board[1, 0] = Cell(EMPTY, 1, 1)
board[0, 1] = Cell(EMPTY, 1, 1)

board_print(board, -1, -1)

visiten = []


def run_collapse(x, y):
    c = board[y, x]
    adj = board[max(0, y-1):min(MAX_Y, y+1)+1,
                max(0, x-1):min(MAX_X, x+1)+1]
    adj: List = adj.flatten().tolist()

    adj.remove(c)

    adj = collapse(c, adj)


for _ in range(10):
    n = 0
    for y in range(MAX_Y):
        for x in range(MAX_X):
            if board[y, x].superposition != BOTH:
                run_collapse(x, y)
    print(board)
