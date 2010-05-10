#!/usr/local/bin/perl -w
use strict;

use perlcyc;

my $database = shift;

if (!$database) { 
    print qq {This script dumps a Pathway Tools (PGDB) database. 
Please specify database to dump (i.e. ARA for AraCyc, LYCO for lycocyc etc.)
Version 1.1, Nov 23, 2006...
};
    exit(0);
}
	

##edited by Danny 4/12/2005

my $cyc = new perlcyc("ARA");

my @pathways = $cyc -> all_pathways();
#my @pathways = ("PWY-1186");

foreach my $p (@pathways) {
    my $pathwayName = getPathwayName($p);
    my @subpathways=$cyc -> get_slot_values($p, "SUB-PATHWAYS");
    if (!@subpathways) {
	my @reactions = $cyc -> get_slot_values ($p, "REACTION-LIST");
	foreach my $r (@reactions) {
	    my $rname = $cyc -> get_slot_value($r, "EC-NUMBER");
	    if (!$rname) { $rname=$r; }
	    my @proteins = $cyc -> enzymes_of_reaction($r);

	    if (!@proteins) {
		print "$pathwayName\t$rname\tunknown\tunknown\n";
	    }
	    else {
		printProteinsReport($pathwayName, $rname, @proteins);
	    }
	}
    }
}



sub printProteinsReport {
    my ($pathwayName, $rname, @proteins) = @_;
    for my $protein (@proteins) {
	my $pname = getProteinName($protein);
	my @genes = $cyc -> genes_of_protein($protein);
	if (!@genes) {
	    print "$pathwayName\t$rname\t$pname\tunknown\n";
	}
	else {
	    printGenesReport($pathwayName, $rname, $pname, @genes);
	}
    }
}



sub printGenesReport {
    my ($pathwayName, $rname, $pname, @genes) = @_;
    foreach my $g (@genes) {
	my $gname = getGeneName($g);
	print "$pathwayName\t$rname\t$pname\t$gname\n";
    }
}





sub getPathwayName {
    my ($p) = @_;
    my $pathwayName = $cyc -> get_slot_value($p, "COMMON-NAME");
    if (!$pathwayName) {$pathwayName = "unknown";}
    return $pathwayName;
}



sub getGeneName {
    my ($g) = @_;
    if ($g =~ /(At\dg\d{5})/i) {
	return $1;
    }

    my @synonyms = $cyc -> get_slot_values($g, "SYNONYMS");
    foreach my $s (@synonyms) {
	if ($s =~ /(At\dg\d{5})/i) {
	    return $1;
	}
    }

    my $name = $cyc -> get_slot_value($g, "COMMON-NAME");
    if ($name) {
	return $name;
    }

    return $g;
}



sub getProteinName {
    my ($protein) = @_;
    if (!$protein) { return "unknown"; }

    my $pname = $cyc -> get_slot_value($protein, "COMMON-NAME");
    if ($pname) { return $pname; }

    my @others = $cyc -> get_slot_values($protein, "CATALYZES");
    my @names;
    foreach my $other (@others) {
	push @names, $cyc -> get_slot_value($other, "COMMON-NAME");
    }
    return (join "||", @names);
}
