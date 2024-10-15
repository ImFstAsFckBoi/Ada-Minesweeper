with Cell; Use Cell;

package Field is
    type Field_Type is array (Positive range <>, Positive range <>) of Cell_Type;
    
    function  FieldGetAdj    (Field: in Field_Type; X, Y: in Positive) return Natural;
    procedure FieldRandomize (Item: in out Field_Type);
private

end Field;
