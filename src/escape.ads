with Ada.Characters.Latin_1; use Ada.Characters.Latin_1;

package Escape is

    type Escape_Code_Type is (NONE,
                              ARROW_UP,
                              ARROW_DOWN,
                              ARROW_RIGHT,
                              ARROW_LEFT);
    function ReadEscapeSequence return Escape_Code_Type;

    CURSORHOME: String    := ESC & "[H";
    CLEARLINE: String     := ESC & "[2K";
    CLEARSCREEN: String   := ESC & "[2J";
    CLEAREOS: String      := ESC & "[0J";
    SAVECURSOR: String    := ESC & "7";
    RESTORECURSOR: String := ESC & "8";
    SETAUTOWRAP: String   := ESC & "[?7h";
    HIDECURSOR: String    := ESC & "[?25l";
    SHOWCURSOR: String    := ESC & "[?25h";
end Escape;