with Ada.Text_IO; use Ada.Text_IO;
with Ada.Characters.Latin_1; use Ada.Characters.Latin_1;

with Board; use Board;
with Cell;  use Cell;
with Escape; use Escape;
procedure Mine is
    Board: Board_Type($BOARD_WIDTH, $BOARD_HEIGHT);
    Input: Character;
    Running: Boolean := True;
    FirstOpen: Boolean := True;
    Remaning_Mines: Natural := 1;
    procedure ClearCLI is   
    begin
        Put(ESC & "[2J");
    end ClearCLI;
begin
    Put(ESC & "[?25l");
    Put(SAVECURSOR);
    while Running loop
        Put(RESTORECURSOR);
        Put(Board);

        Get_Immediate(Input);
        if Input = ESC then
            
            case ReadEscapeSequence is
                when ARROW_UP    => Input := 'w';
                when ARROW_DOWN  => Input := 's';
                when ARROW_RIGHT => Input := 'd';
                when ARROW_LEFT  => Input := 'a';
                when others => null;
            end case;
        end if;

        case Input is
            when 'q' => exit;
            when 'w' => BoardMoveCursor(Board, Up);
            when 'a' => BoardMoveCursor(Board, Left);
            when 's' => BoardMoveCursor(Board, Down);
            when 'd' => BoardMoveCursor(Board, Right);
            when 'f' =>
                if CellIsMine(BoardGetCellAtCursor(Board)) then
                    if CellIsFlagged(BoardGetCellAtCursor(Board)) then
                        Remaning_Mines := Remaning_Mines + 1;
                    else
                        Remaning_Mines := Remaning_Mines - 1;
                    end if;
                end if;

                if not CellIsOpen(BoardGetCellAtCursor(Board)) then
                    BoardPlaceFlag(Board);
                end if;
            when ' ' =>
                if not CellIsFlagged(BoardGetCellAtCursor(Board)) then
                    
                    if FirstOpen then
                        loop
                            BoardRandomize(Board);
                            if not CellIsMine(BoardGetCellAtCursor(Board)) then
                                exit;
                            end if;
                        end loop;
                        
                        Remaning_Mines := BoardCountMines(Board);

                        FirstOpen := False;
                    end if;

                    BoardOpenAtCursor(Board);

                    if CellIsMine(BoardGetCellAtCursor(Board)) then
                        BoardOpenAllCells(Board);
                        Put(RESTORECURSOR);

                        Put(Board);
                        Put_Line("YOU LOST!  Press (r) to RESTART or (q) to QUIT");

                        loop
                            Get_Immediate(Input);

                            case Input is
                                when 'q' => 
                                    Running := False;
                                    exit;
                                when 'r' =>
                                    Put(RESTORECURSOR);
                                    Put(CLEAREOS);
                                    BoardUnflagAllCells(Board);
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
  
        if Remaning_Mines = 0 then
            BoardOpenAllCells(Board);
            Put(RESTORECURSOR);
            Put(RESTORECURSOR);
            Put(Board);
            Put_Line("YOU WON!  Press (r) to RESTART or (q) to QUIT");
            loop
                Get_Immediate(Input);

                case Input is
                    when 'q' => 
                        Running := False;
                        exit;
                    when 'r' =>
                        Put(CLEAREOS);
                        BoardUnflagAllCells(Board);
                        BoardCloseAllCells(Board);
                        FirstOpen := True;
                        exit;
                    when others => null;
                end case;
            end loop;
        end if;
    end loop;
    Put(ESC & "[?25h");
end Mine;

