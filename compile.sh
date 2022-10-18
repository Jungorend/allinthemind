#!/usr/bin/env bash

ca65 src/core.s
ca65 src/reset.s
ld65 src/core.o src/reset.o -C nes.cfg -o mind.nes
