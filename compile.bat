@echo [off]
ca65 src\reset.s
ca65 src\core.s
ld65 src\core.o src\reset.o -C nes.cfg -o mind.nes
