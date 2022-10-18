.include "constants.inc"
.include "header.inc"

.segment "CODE"
.proc irq_handler
    RTI
.endproc

.proc nmi_handler
    LDA #$00
    STA OAMADDR
    LDA #$02
    STA OAMDMA
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
