.include "constants.inc"
.include "header.inc"

.segment "ZEROPAGE"
player_one_buttons: .res 1
player_two_buttons: .res 1
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
.export main
.proc main
do_nothing:
    JMP do_nothing
.endproc

.segment "VECTORS"
    .addr nmi_handler, reset_handler, irq_handler

.segment "CHR"
    .res 8192
