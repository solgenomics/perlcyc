#!/usr/bin/perl -w

use strict;

while (<>) { 
    if (/^\w+-/) {
	chomp; 
	s/\s.*$//;
	print; 
	print "\n\n"; 
    } 
}
