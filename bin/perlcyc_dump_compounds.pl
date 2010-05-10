#!/usr/local/bin/perl -w
use strict;
use perlcyc;
use Data::Dumper;


##modified to print out molecular weight as well. -peifenz 20060503

##This is based on the script dump_compounds.pl. The scrip will pull out all compounds of all pathways. For each compound, it will print out common name, synonyms, compound hierarchy, chemical formula, smiles formula, CAS links, all the reaction equations containing the compound, and all the pathways containing each of the reactions. -PeifenZ 8/15/2004 

print "Compound_common_name\tCompound_synonyms\tMolecular_weight\tChemical_formula\tSmiles\tLinks\tEC\tReaction_equation\tPathway\n";

my $cyc = new perlcyc("ARA");
my @pathways = $cyc -> all_pathways ();
my %compoundsHash;

sub prepareCompoundsHash {
    for my $pathwayFrameId (@pathways) {
	for my $compoundFrameId ($cyc -> compounds_of_pathway ($pathwayFrameId)) {
	    push @{$compoundsHash{$compoundFrameId}}, $pathwayFrameId;
	}
    }
}

prepareCompoundsHash();
## Returns all the compounds (id) of all pathways
sub all_compounds {
    return keys %compoundsHash;
}


## Returns a list of pathways (id) containing a reaction
sub pathways_of_reaction {
    my $reaction = shift;
    my @pathways = $cyc -> get_slot_values($reaction, "In-pathway");
    return @pathways;
}

## Returns a list of synonyms of a compound
sub synonyms_of_compound {
    my $compound = shift;
    return $cyc -> get_slot_values ($compound, "Synonyms");
}


## Returns the common name of a frame
sub getCommonName {
    my $frameId = shift;
    return $cyc->get_name_string ($frameId, strip_html => 1);
}


## Returns a list of db links.  ie: ("CAS:57-5", "(CAS:34-04-3")
sub getDbLinks {
    my ($cyc, $compound) = @_;
    my @links;
    for my $link_pair ($cyc -> get_slot_values($compound, "DBLINKS")) {
	push @links, $link_pair->[0] . ":" . $link_pair->[1];
    }
    return @links;
}


for my $compound (all_compounds()) {
    ## not all compounds are frames, so we need to skip over those that aren't frames
    if (! ($cyc->coercible_to_frame_p($compound))) {
	next;
    }
    my $mw = $cyc -> get_slot_value ($compound, "molecular-weight");
    $mw =~ s/d0//g;
    my $smiles = $cyc -> get_slot_value($compound, "SMILES");
    my @formula = $cyc -> get_slot_values($compound, "chemical-formula");
    my $formulaString = "";
    foreach my $f (@formula) {
	$formulaString.= "$$f[0]$$f[1] ";
    }

    my @DBlinks = getDbLinks($cyc, $compound);
    my $DBlink = join "*", @DBlinks;

    for my $reaction ($cyc->reactions_of_compound($compound)) {
	my $rname = $cyc -> get_slot_value($reaction, "EC-NUMBER");
	if (!$rname) { $rname=$reaction; }
	for my $pathway (pathways_of_reaction($reaction)) {
	    print join("\t", getCommonName($compound),
		       join("*", synonyms_of_compound($compound)),
		       $mw,
		       $formulaString,
		       $smiles,
		       $DBlink,
		       $rname,
		       getCommonName($reaction), 
		       getCommonName($pathway));
	    print "\n";
	}
    }
}


