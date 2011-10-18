use strict;
use warnings;

use Test::More  "no_plan";
BEGIN{ use_ok('Bio::PerlCyc') }

my $cyc = Bio::PerlCyc->new("LYCO");

$cyc->set_debug(1);
#$cyc->put_slot_value("f1 11", "s2222", "v3333");
#$cyc->put_slot_value("abc", "blabla", "123"  );


SKIP: {
    skip "pathway tools -api not running.", 20, if !-S "/tmp/ptools-socket";

    my $sock = $cyc->socket_name( $ENV{PATHWAY_TOOLS_SOCKET} || ());
    $sock && -S $sock
        or skip "PT socket '$sock' not found, please make sure PT is running, or set environment variable PATHWAY_TOOLS_SOCKET to socket file name", 41;

    $cyc->select_organism("TEST");

    my @pathways = $cyc->all_pathways(":all");
    #warn "Pathways: @pathways\n";
    ok(@pathways == 2, "number of pathways test");
    
    my @superpathways = $cyc->all_pathways(":all", 'T');
    #print STDERR "SUPER: ".scalar(@superpathways)."\n";
    ok(@superpathways == 2, "superpathways query");


    
    my @orgs = $cyc->all_orgs();
    foreach my $o (@orgs) { 
        print "$o\n";
    }

    

    my @reactions = $cyc->all_rxns();
    #print STDERR "REACTIONS: ".scalar(@reactions)."\n";
    ok(40 == @reactions, "reaction count test");
    my @small_molecule_reactions = $cyc->all_rxns(":smm");
    #print STDERR "SMM: ".scalar(@small_molecule_reactions)."\n";
    ok(40 == @small_molecule_reactions, "small molecule reaction count");
    my @all_reactions = $cyc->all_rxns(":all");
    #print STDERR "ALL: ".scalar(@all_reactions)."\n";
    ok(40 == @all_reactions, "all reaction count");
    my @enzyme_reactions = $cyc->all_rxns(":enzyme");
    #print STDERR "ENZYME: ".scalar(@enzyme_reactions)."\n";
    ok(40 == @enzyme_reactions, "enzyme reaction count");
    my @transport_reactions = $cyc->all_rxns(":transport");
    #print STDERR "TRANSPORT: ".scalar(@transport_reactions)."\n";
    ok(0 == @transport_reactions, "transport reaction count");


    my @all_transcription_factors = $cyc->all_transcription_factors();
    my @all_modified_forms = $cyc->all_transcription_factors( { "allow-modified-forms?" => 'T' } );
    #print STDERR "TRANSCRIPTION FACTORS: @all_transcription_factors\n";
    #print STDERR "MODIFIED FORMS: @all_modified_forms\n";

    



    foreach my $r (@reactions) { 
        #print $cyc->genes_of_reaction($r);
        my @s = $cyc->substrates_of_reaction($r);
	ok (@s > 0, "substrate of reaction $r test");
        $cyc->enzymes_of_reaction($r);
        $cyc->reaction_reactants_and_products($r);
        #$cyc->get_predecessors($r, $);
        #$cyc->get_successors($r);
        my @cf = $cyc->all_cofactors($r);
        my @m = $cyc->all_modulators($r);
    }
    

    ok(@reactions == 40, "reaction test - retrieved ".scalar(@reactions)." reactions.");

    my $p = $pathways[0];

    print STDERR "PATHWAY: $p\n";
    exit();
    my @genes = $cyc->genes_of_pathway($p);

    warn "Genes of pathway $p: @genes\n";
    
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
    ok(scalar(@r = $cyc->transcription_unit_promoter($g)), "transcription unit promoter of $g = @r");
    ok(scalar(@r = $cyc->transcription_unit_genes($g)), "transcription unit of genes $g = @r");
    ok(scalar(@r = $cyc->transcription_unit_binding_sites($g)), "transcription unit binding sites $g = @r");
    ok(scalar(@r = $cyc->transcription_unit_transcription_factors($g)), "transcription unit transcription factors $g = @r");
    ok(scalar(@r = $cyc->transcription_unit_terminators($g)), "transcription unit termintators $g = @r");
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
        
}
