.include "constants.inc"

.segment "ZEROPAGE"
.importzp player_one_buttons, player_two_buttons

.segment "CODE"
    ;; This reads in the input from both controllers.
    ;; Example taken directly from nesdev.org
    ;; https://www.nesdev.org/wiki/Controller_reading_code
.export poll_controllers
.proc poll_controllers
    LDA #$01
    STA JOYPAD1
    STA player_two_buttons
    LSR a
    STA JOYPAD1
read_input_loop:
    LDA JOYPAD1
    AND #%00000011
    CMP #$01
    ROL player_one_buttons
    LDA JOYPAD2
    AND #%00000011
    CMP #$01
    ROL player_two_buttons
    BCC read_input_loop
    RTS
.endproc
