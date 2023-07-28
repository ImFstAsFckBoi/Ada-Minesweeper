with Ada.Text_IO; use Ada.Text_IO;

with Field; use Field;
 
package body Field is


    function FieldGetAdj (Field: in Field_Type; X, Y: in Positive) return Natural is
        Result: Natural := 0;
    begin
        for Yidx in (Y-1)..(Y+1) loop
            for Xidx in (X-1)..(X+1) loop
                
                if Yidx in Field'Range(2) and
                   Xidx in Field'Range(1) and
                   not (Xidx = X and Yidx = Y)
                then
                    if CellIsMine(Field(Xidx, Yidx)) then
                        Result := Result + 1;
                    end if;
                end if;
            end loop;
        end loop;

        return Result;
    end FieldGetAdj;

    procedure FieldRandomize (Item: in out Field_Type) is
    begin
        for Y in Item'Range(2) loop
            for X in Item'Range(1) loop
               CellRandomize(Item(X, Y));
            end loop;
        end loop;
    end FieldRandomize;
end Field;
