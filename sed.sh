#!/bin/bash
sed '
:again
s/^\(.\)\(.*\)\1$/\2/
t again
s/^\(.\)$//
s/.\+/nie/
s/^$/tak/
'
#Łukasz Wroński
