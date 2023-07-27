with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; 	use Ada.Integer_Text_IO; 

with Cell; use Cell;
with Field; use Field;
package body Board is


    procedure Put (Item: in Board_Type) is
    begin
        for Y in Item.Field'Range(2) loop
            for X in Item.Field'Range(1) loop
                declare
                    Adj: Natural;
                begin
                    if Item.Cursor.X = X and Item.Cursor.Y = Y then
                        Put("(");
                    else
                        Put(" ");
                    end if;

                    Adj := FieldGetAdj(Item.Field, X, Y);
                    Put(Item.Field(X, Y), Adj);

                    if Item.Cursor.X = X and Item.Cursor.Y = Y then
                        Put(")");
                    else
                        Put(" ");
                    end if;
                end; 
            end loop;
            New_Line;
        end loop;
    end Put;


    function BoardGetAdj (Board: in Board_Type) return Natural is
    begin
        return FieldGetAdj(Board.Field, Board.Cursor.X, Board.Cursor.Y);
    end BoardGetAdj;


    function BoardGetCellAtCursor (Board: in Board_Type) return Cell_Type is
    begin
        return Board.Field(Board.Cursor.X, Board.Cursor.Y);
    end BoardGetCellAtCursor;


    procedure BoardRandomize (Item: in out Board_Type) is
        RunOnce: Boolean := True;
    begin
        while (BoardGetAdj(Item) /= 0 and not CellIsMine(BoardGetCellAtCursor(Item))) or
              RunOnce loop
            RunOnce := False;
            for Y in Item.Field'Range(2) loop
                for X in Item.Field'Range(1) loop
                    CellRandomize(Item.Field(X, Y));
                end loop;
            end loop;
        end loop;
    end BoardRandomize;


    procedure BoardMoveCursor (Board: in out Board_Type; Direction: in Directions_Type; Increment: in Integer := 1) is
        tmp: Cursor_Type := Board.Cursor;
    begin
        case Direction is
            when Up    => Board.Cursor.Y := Board.Cursor.Y - Increment;
            when Down  => Board.Cursor.Y := Board.Cursor.Y + Increment;
            when Left  => Board.Cursor.X := Board.Cursor.X - Increment;
            when Right => Board.Cursor.X := Board.Cursor.X + Increment;
        end case;

        if
            Board.Cursor.X not in Board.Field'Range(1) or
            Board.Cursor.Y not in Board.Field'Range(2)
        then
            Board.Cursor := tmp;
        end if;
    end BoardMoveCursor;


    procedure BoardOpenAllCells(Board: in out Board_Type) is
    begin
         for Y in Board.Field'Range(2) loop
            for X in Board.Field'Range(1) loop
                CellOpen(Board.Field(X, Y));
            end loop;
        end loop;
    end BoardOpenAllCells;

    procedure BoardCloseAllCells(Board: in out Board_Type) is
    begin
         for Y in Board.Field'Range(2) loop
            for X in Board.Field'Range(1) loop
                CellClose(Board.Field(X, Y));
            end loop;
        end loop;
    end BoardCloseAllCells;

    procedure BoardUnflagAllCells (Board: in out Board_Type) is
    begin
         for Y in Board.Field'Range(2) loop
            for X in Board.Field'Range(1) loop
                if CellIsFlagged(Board.Field(X, Y)) then
                    CellFlag(Board.Field(X, Y));
                end if;
            end loop;
        end loop;
    end BoardUnflagAllCells;


    procedure BoardPlaceFlag(Board: in out Board_Type) is
    begin
        CellFlag(Board.Field(Board.Cursor.X, Board.Cursor.Y));
    end BoardPlaceFlag;


    procedure BoardOpenAdj(Board: in out Board_Type; X, Y: in Positive; UseMatrix: in out AnyBoolArray) is
        procedure OpenSquare(Board: in out Board_Type; X, Y: in Positive) is 
        begin
            for Y_idx in (Y-1)..(Y+1) loop
                for X_idx in (X-1)..(X+1) loop
                    if Y_idx in Board.Field'Range(2) and
                       X_idx in Board.Field'Range(1)
                    then
                        if not CellIsMine(Board.Field(X_idx, Y_idx)) and 
                           not CellIsOpen(Board.Field(X_idx, Y_idx))
                        then                        
                            CellOpen(Board.Field(X_idx, Y_idx));
                        end if;
                    end if;
                end loop;
            end loop;
        end OpenSquare;
    begin
        OpenSquare(board, X, Y);
        UseMatrix(X, Y) := True;

        for Y_idx in (Y-1)..(Y+1) loop
                for X_idx in (X-1)..(X+1) loop
                    if Y_idx in Board.Field'Range(2) and
                       X_idx in Board.Field'Range(1)
                    then
                        if not CellIsMine(Board.Field(X_idx, Y_idx)) and
                           FieldGetAdj(Board.Field, X_idx, Y_idx) = 0 and
                           not UseMatrix(X_idx, Y_idx)
                        then 
                            BoardOpenAdj(Board, X_idx, Y_idx, UseMatrix);
                        end if;
                    end if;
                end loop;
            end loop;
    end BoardOpenAdj;


    procedure BoardOpenAtCursor(Board: in out Board_Type) is
        UseMatrix: AnyBoolArray(Board.Field'Range(1), Board.Field'Range(2))
         := (others => (others => False));
    begin
        if FieldGetAdj(Board.Field, Board.Cursor.X ,Board.Cursor.Y) = 0 then
            BoardOpenAdj(Board, Board.Cursor.X, Board.Cursor.Y, UseMatrix);
        else
            CellOpen(Board.Field(Board.Cursor.X ,Board.Cursor.Y));
        end if;
    end BoardOpenAtCursor;
end Board;
