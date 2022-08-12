with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with ada.numerics.discrete_random;



with Cell; use Cell;

package body Cell is
    

    function CellIsMine (Item: in Cell_Type) return Boolean is
    begin
        return Item.IsMine;
    end CellIsMine;

    
    function CellIsOpen (Item: in Cell_Type) return Boolean is
    begin
        return Item.IsOpen;
    end CellIsOpen;


    function CellIsFlagged (Item: in Cell_Type) return Boolean is
    begin
        return Item.IsFlagged;
    end CellIsFlagged;


    procedure Put (Item: in Cell_Type; Adj: in Natural) is
    begin
        if Item.IsFlagged then
            Put("F");
        elsif not Item.IsOpen then
            Put(".");
        elsif Item.IsMine then
            Put("*");
        elsif Adj = 0 then
            Put(" ");
        else
            Put(Adj, Width => 0);
        end if;
    end Put;


    procedure CellRandomize(Item: in out Cell_Type) is
        type randRange is range 1..6;
        package Chance is new ada.numerics.discrete_random(randRange);
        use Chance;
        gen: Generator;
        rnd: randRange;
    begin
        reset(gen);
        rnd := random(gen);

        if rnd = 1 then
            Item.IsMine := True;
        else
            Item.IsMine := False;
        end if;
    end CellRandomize;


    procedure CellOpen(Cell: in out Cell_Type) is
    begin
        if not Cell.IsFlagged then
            Cell.IsOpen := True;
        end if;
    end CellOpen;


    procedure CellClose(Cell: in out Cell_Type) is
    begin
        Cell.IsOpen := False;
    end CellClose;


    procedure CellFlag(Cell: in out Cell_Type) is
    begin
        Cell.IsFlagged := not Cell.IsFlagged;
    end CellFlag;
end Cell;
