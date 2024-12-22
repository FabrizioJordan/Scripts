#!/bin/bash

clear

neofetch | lolcat

alias > $HOME/Scripts/myAlias.txt | batcat -p --theme=base16 $HOME/Scripts/myAlias.txt

read -rp "	<INTRO>"
