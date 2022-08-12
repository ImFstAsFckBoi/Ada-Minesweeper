
package Cell is
    type Cell_Type is private;

    procedure Put          (Item: in Cell_Type; Adj: in Natural);
    function  CellIsMine   (Item: in Cell_Type) return Boolean;
    function  CellIsOpen    (Item: in Cell_Type) return Boolean;
    function  CellIsFlagged (Item: in Cell_Type) return Boolean;
    procedure CellRandomize (Item: in out Cell_Type);
    procedure CellOpen      (Cell: in out Cell_Type);
    procedure CellClose     (Cell: in out Cell_Type);
    procedure CellFlag      (Cell: in out Cell_Type);
private
    type Cell_Type is
    record
        IsMine:    Boolean;
        IsOpen:    Boolean := False;
        IsFlagged: Boolean := False;
    end record;
end Cell;
