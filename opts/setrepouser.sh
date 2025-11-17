#!/bin/bash
sed 's/^\[core\]/[user]\
	name = okkuweb\
	email = okkuweb@protonmail.com\
[core]/g
' $1
