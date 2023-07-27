with Ada.Text_IO; use Ada.Text_IO;
with Ada.Characters.Latin_1; use Ada.Characters.Latin_1;
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
        blue: String := ESC &"[0;34m";
        green: String := ESC &"[0;32m";
        red: String := ESC &"[0;31m";        
        light_blue: String := ESC &"[1;34m";
        light_red: String := ESC &"[1;31m";
        cyan: String := ESC &"[0;36m";
        dark_gray: String := ESC &"[1;30m";
        light_gray: String := ESC &"[0;37m";
        orange: String := ESC &"[0;33m";

        nc: String := ESC & "[0;0m";
    begin
        if Item.IsFlagged then
            Put(orange);
            Put("F");
            Put(nc);
        elsif not Item.IsOpen then
            Put(".");
        elsif Item.IsMine then
            Put("*");
        elsif Adj = 0 then
            Put(" ");
        else
            case Adj is
                when 1 => Put(blue);
                when 2 => Put(green);
                when 3 => Put(red);
                when 4 => Put(light_blue);
                when 5 => Put(light_red);
                when 6 => Put(cyan);
                when 7 => Put(dark_gray);
                when 8 => Put(light_blue);
                when others => raise Constraint_Error;
            end case;
            Put(Adj, Width => 0);
            Put(nc);

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
