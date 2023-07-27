with Field; use Field;
with Cell;  use Cell;
package Board is

    type Directions_Type is (Up, Down, Left, Right);
    type Board_Type (x, y: Positive) is private;
    
    procedure Put                  (Item: in Board_Type);
    function  BoardGetAdj          (Board: in Board_Type) return Natural;
    function  BoardGetCellAtCursor (Board: in Board_Type) return Cell_Type;
    procedure BoardRandomize       (Item: in out Board_Type);
    procedure BoardMoveCursor      (Board: in out Board_Type; Direction: in Directions_Type; Increment: in Integer := 1);
    procedure BoardCloseAllCells   (Board: in out Board_Type);
    procedure BoardOpenAllCells    (Board: in out Board_Type);
    procedure BoardUnflagAllCells  (Board: in out Board_Type);
    procedure BoardPlaceFlag       (Board: in out Board_Type);
    procedure BoardOpenAtCursor    (Board: in out Board_Type);
private
    type AnyBoolArray is array (Integer range <>, Integer range <>) of Boolean;

    type Cursor_Type is record
        X: Integer := 1;
        Y: Integer := 1;
    end record;

    type Board_Type (x, y: Positive) is record
        Cursor: Cursor_Type;
        Field: Field_Type(1..x, 1..y);
    end record;
end Board;
