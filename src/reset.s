.include "constants.inc"

.segment "CODE"
.import main
.export reset_handler
.proc reset_handler
    SEI
    CLD
    LDX #$00
    STX PPUCTRL
    STX PPUMASK

vblankwait:
    BIT PPUSTATUS
    BPL vblankwait

    LDX #$00
    LDA #$FF
clear_oam:
    ;; Store sprite positions off-screen initially
    STA $0200,X
    INX
    INX
    INX
    INX
    BNE clear_oam

vblankwait2:
    BIT PPUSTATUS
    BPL vblankwait2

    JMP main
.endproc
