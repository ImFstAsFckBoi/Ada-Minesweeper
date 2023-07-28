with Escape; use Escape;
with Ada.Text_IO; use Ada.Text_IO;

package body Escape is
    function ReadEscapeSequence return Escape_Code_Type is
        Input: Character;
    begin
        Get_Immediate(Input);
        if Input /= '[' then
            return NONE;
        end if;

        Get_Immediate(Input);
        case Input is
            when 'A' => return ARROW_UP;
            when 'B' => return ARROW_DOWN;
            when 'C' => return ARROW_RIGHT;
            when 'D' => return ARROW_LEFT;
            when others => return NONE;
        end case;
    end ReadEscapeSequence;

end Escape;