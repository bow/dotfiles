#!/usr/bin/env bash

# Script for quick setup of stow-ed files

type stow >/dev/null 2>&1 || { "GNU Stow not found. Exiting."; exit 1; }

for prog in `ls .`;
do
    stow $prog -d `pwd` -t ~
done
