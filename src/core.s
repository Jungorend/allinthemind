.include "constants.inc"
.include "header.inc"

.segment "ZEROPAGE"
player_one_buttons: .res 1
player_two_buttons: .res 1
player_one_x:   .res 1
player_one_y:   .res 1
player_one_state:   .res 1
player_two_x:   .res 1
player_two_y:   .res 1
player_two_state:   .res 1
.exportzp player_one_buttons, player_two_buttons

.segment "CODE"
.proc irq_handler
    RTI
.endproc

.proc nmi_handler
    LDA #$00
    STA OAMADDR
    LDA #$02
    STA OAMDMA                  ; Copy graphics to OAM once a frame
    LDA #$00

    RTI
.endproc

.import reset_handler
.import poll_controllers
.export main
.proc main
    ;; load palette
    LDX PPUSTATUS
    LDX $3f
    STX PPUADDR
    LDX $00
    STX PPUADDR
palette_loop:
    LDA palette,X
    STA PPUDATA
    INX
    CMX #$10
    BNE palette_loop


main_loop:
    JSR poll_controllers
    JMP main_loop
.endproc

.segment "VECTORS"
    .addr nmi_handler, reset_handler, irq_handler

.segment "CHR"
    .res 8192

.segment "RODATA"
palette:
    ;; backgrounds
    .byte $0f, $09, $19, $29    ; green just for testing purposes
    .byte $0f, $0f, $0f, $0f
    .byte $0f, $0f, $0f, $0f
    .byte $0f, $0f, $0f, $0f
    ;; sprites
    .byte $0f, $0f, $0f, $0f
    .byte $0f, $0f, $0f, $0f
    .byte $0f, $0f, $0f, $0f
    .byte $0f, $0f, $0f, $0f
