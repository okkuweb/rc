#!/bin/bash
sed -i 's/^\[core\]/[user]\
	name = okkuweb\
	email = okkuweb@protonmail.com\
[core]/g
' $1
