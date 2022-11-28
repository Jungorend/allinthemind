.include "constants.inc"
.include "header.inc"

.segment "ZEROPAGE"
player_one_buttons: .res 1
player_two_buttons: .res 1
player_one_x:   .res 1
player_one_y:   .res 1
player_one_state:   .res 1
player_one_facing:  .res 1
player_two_x:   .res 1
player_two_y:   .res 1
player_two_state:   .res 1
player_two_facing:  .res 1
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
    CPX #$10
    BNE palette_loop


main_loop:
    JSR poll_controllers
    ;; Some basic testing initialization will put render player 1 at middle position
    ;; with fighter one sprites
    LDX #$37
    STX player_one_x
    STX player_one_y
    LDX #$0                     ; idle pose
    STX player_one_state
    STX player_one_facing       ; face right
    JMP draw_player_one
    JMP main_loop
.endproc

.proc draw_player_one
    ;; store tile numbers
    LDX #$00
    STX $0201
    INX
    STX $0205
    INX
    STX $0209
    LDA player_one_y
    SBC #$20
    STA $0200
    STA $0204
    STA $0208
    LDA player_one_x
    SBC #$0c
    STA $0203
    ADC #$08
    STA $0207
    ADC #$08
    STA $020b

.endproc

.segment "VECTORS"
    .addr nmi_handler, reset_handler, irq_handler

.segment "CHR"
    .incbin "graphics.chr"

.segment "RODATA"
palette:
    ;; backgrounds
    .byte $0f, $09, $19, $29    ; green just for testing purposes
    .byte $0f, $0f, $0f, $0f
    .byte $0f, $0f, $0f, $0f
    .byte $0f, $0f, $0f, $0f
    ;; sprites
    .byte $0f, $09, $19, $29
    .byte $0f, $0f, $0f, $0f
    .byte $0f, $0f, $0f, $0f
    .byte $0f, $0f, $0f, $0f
