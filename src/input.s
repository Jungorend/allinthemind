.include "constants.inc"

.segment "ZEROPAGE"
.importzp player_one_buttons, player_two_buttons

.segment "CODE"
.export update_input
.proc update_input

.endproc
