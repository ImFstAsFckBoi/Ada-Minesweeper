with Ada.Text_IO; use Ada.Text_IO;
with Interfaces.C;
with GNAT.OS_Lib;

with Board; use Board;
with Cell;  use Cell;

procedure Mine is
    Board: Board_Type(14, 16);
    Input: Character;
    Running: Boolean := True;
    FirstOpen: Boolean := True;

    -- Would be much better if termios could be used
    procedure ClearCLI is
        package C renames Interfaces.C;
        use type C.int;

        function system (command : C.char_array) return C.int
        with Import, Convention => C;

        ClearCmd : aliased constant C.char_array :=
        C.To_C ("clear");

        result : C.int;
    begin
        result := system (ClearCmd);
        if result /= 0 then 
            Put_Line("Something when wrong");
            GNAT.OS_Lib.OS_Exit(1);
        end if;
    end ClearCLI;

begin

    while Running loop
        ClearCLI;
        Put(Board);

        Get_Immediate(Input);

        case Input is
            when 'q' => exit;
            when 'w' => BoardMoveCursor(Board, Up);
            when 'a' => BoardMoveCursor(Board, Left);
            when 's' => BoardMoveCursor(Board, Down);
            when 'd' => BoardMoveCursor(Board, Right);
            when 'f' => BoardPlaceFlag(Board);
            when ' ' =>
                if not CellIsFlagged(BoardGetCellAtCursor(Board)) then
                    
                    if FirstOpen then
                        BoardRandomize(Board);
                        FirstOpen := False;
                    end if;

                    BoardOpenAtCursor(Board);
                    

                    if CellIsMine(BoardGetCellAtCursor(Board)) then
                        BoardOpenAllCells(Board);
                        ClearCLI;

                        Put(Board);
                        Put_Line("YOU LOST!  Press (r) to RESTART or (q) to QUIT");

                        loop
                            Get_Immediate(Input);

                            case Input is
                                when 'q' => 
                                    Running := False;
                                    exit;
                                when 'r' => 
                                    BoardCloseAllCells(Board);
                                    FirstOpen := True;
                                    exit;
                                when others => null;
                            end case;
                        end loop;
                    
                    end if;
                end if;
            when others => null;
        end case;
    end loop;
end Mine;

