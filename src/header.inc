.segment "HEADER"
  .byte $4e, $45, $53, $1a ; Magic string for iNES v1
  .byte $02       ; 16 KB PRG
  .byte $01       ; 8 KB CHR
  .byte %00000001 ; vertical mirroring, no save RAM, NROM
  .byte %00000000 ; No special case flags
  .byte $00       ; No PRG RAM
  .byte $00       ; NTSC format
