use strict;

use Test::More qw / no_plan /;
use perlcyc;

my $cyc = perlcyc->new("LYCO");

$cyc->select_organism("LYCO");

my @pathways = $cyc->all_pathways();
my @orgs = $cyc->all_orgs();
foreach my $o (@orgs) { 
    print "$o\n";
}

my @reactions = $cyc->all_rxns();

foreach my $r (@reactions) { 
    #print $cyc->genes_of_reaction($r);
    $cyc->substrates_of_reaction($r);
    $cyc->enzymes_of_reaction($r);
    #$cyc->reaction_reactants_and_products($r);
    #$cyc->get_predecessors($r);
    #$cyc->get_successors($r);
    #$cyc->all_cofactors($r);
    #$cyc->all_modulators($r);
}

ok(@reactions > 1000, "reaction test - retrieved ".scalar(@reactions)." reactions.");

#foreach my $p (@pathways) { 
my $p = $pathways[0];

my @genes = $cyc->genes_of_pathway($p);
my @enzymes = $cyc->enzymes_of_pathway($p);
my @compounds = $cyc->compounds_of_pathway($p);
my @substrates = $cyc->substrates_of_pathway($p);

#  foreach my $c (@compounds) { 
my $c = $compounds[0];
my @reaction_compounds = $cyc->reactions_of_compound($c);
# print "$c : ".(join ", ", @reaction_compounds)." \n";
#  }

diag("Checking genes in pathway $p...\n");

my $g = $genes[0];
my @r = undef;
@r = $cyc->enzymes_of_gene($g);
ok($r[0] eq "SGN-U318402-MONOMER", " enzymes of genes $g = @r");
@r = $cyc->all_products_of_gene($g);
ok($r[0] eq "SGN-U318402-MONOMER", " all_products of gene $g = @r ");
@r = $cyc->reactions_of_gene($g);
ok($r[0] eq "ASPARAGHYD-RXN", "reactions of gene $g = @r ");
@r = $cyc->pathways_of_gene($g);
ok($r[0] eq "ASPARAGINE-DEG1-PWY", "pathways of gene $g = @r ");
@r =$cyc->chromosome_of_gene($g);

ok($r[0] eq "UNKNOWN-CHROMOSOME", "chromosome of gene $g = @r");

#$cyc->transcription_unit_of_gene($g);
ok(defined(@r = $cyc->transcription_unit_promoter($g)), "transcription unit promoter of $g = @r");
ok(defined(@r = $cyc->transcription_unit_genes($g)), "transcription unit of genes $g = @r");
ok(defined(@r = $cyc->transcription_unit_binding_sites($g)), "transcription unit binding sites $g = @r");
ok(defined(@r = $cyc->transcription_unit_transcription_factors($g)), "transcription unit transcription factors $g = @r");
ok(defined(@r = $cyc->transcription_unit_terminators($g)), "transcription unit termintators $g = @r");
@r = $cyc->all_transported_chemicals($g);
ok($r[0] eq "TREHALOSE-6P", "all transported chemcials $g = @r");

    
diag( "Checking enzymes in pathway $p...\n");

my $e = $enzymes[0];
print "ENZYME: $e\n";
my $transcription_factor = $cyc->transcription_factor_p($e);
my @monomers = $cyc->monomers_of_protein($e);
my @components = $cyc->components_of_protein($e);
my @protein_genes = $cyc->genes_of_protein($e);
my @protein_reactions = $cyc->reactions_of_enzyme($e);
my $is_enzyme = $cyc->enzyme_p($e);
my $is_transport = $cyc->transport_p($e);
print $cyc->full_enzyme_name($e);
print $cyc->enzyme_activity_name($e);
print $cyc->containers_of($e);
print $cyc->modified_forms($e);
print $cyc->modified_containers($e);
print $cyc->top_containers($e);
print $cyc->reactions_of_protein($e);
print $cyc->regulon_of_protein($e);
print $cyc->transcription_units_of_protein($e);
print $cyc->regulator_proteins_of_transcription_unit($e);
#}
diag( "Finished with pathway $p...\n");
#}   

#print "getting specific frames...\n";
#my @frames = $cyc->get_frames_matching_value("hydroxylase");
#print "FRAMES: ".(join ", ", @frames)."\n";

diag("Retrieving indexed frame...\n");
#my @indexed_frames = $cyc->find_indexed_frame("hydroxylase");

diag( "Creating instance...\n");
$cyc->create_instance("NEW-INSTANCE");
diag( "Creating class...\n");
$cyc->create_class("NEW-CLASS", "COMPOUND");
diag( "Creating frame...\n");
$cyc->create_frame("NEW-FRAME");

print "DONE.\n";
    

diag("New functions 5/2008");
$cyc->genes_regulating_gene($g);
$cyc->genes_regulated_by_gene($g);
$cyc->terminators_affecting_gene($g);
$cyc->transcription_unit_mrna_binding_sites($g);
$cyc->transcription_unit_activators($g);
$cyc->transcription_unit_inhibitors($g);
$cyc->containing_tus($g);
$cyc->direct_activators($g);
$cyc->direct_inhibitors($g);
        
