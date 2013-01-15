
use Test::More tests=>120;

use lib 'lib/';

use strict;
use Bio::PerlCyc;
use Data::Dumper;

my $c = Bio::PerlCyc->test_mode('ECO');
$c->debug_off();

my %defs = %{$c->{_defs}};

if (shift eq "generate_tests") { 
    foreach my $k (keys %defs) { 
	if (!$k) { next; }
	my $code = Data::Dumper::Dumper($defs{$k});
#    print $code;
	$code =~ s/\$VAR1 = (.*)/$1/g;
	$code =~ s/\;$//g;
	
	print 'push @tests, [ "'.$k."\" , $code ];\n\n";
    }
}

my @tests = ();

push @tests, [ "get_slot_value",  {
    'return_type' => 'string',
    'perl_name' => 'get_slot_value',
    'optional_params' => [],
    'lisp_name' => 'get-slot-value',
    'named_params' => [],
    'description' => '',
    'pos_params' => [
	'frame',
	'slot'
	]
	       }
    ];


push @tests, [ "get_class_subclasses" , {
          'return_type' => 'list',
          'perl_name' => 'get_class_subclasses',
          'optional_params' => [
                                 'kb',
                                 'inference-level',
                                 'number-of-values',
                                 'kb-local-only-p'
                               ],
          'lisp_name' => 'get-class-subclasses',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'class'
                          ]
        }
 ];

push @tests, [ "lower_taxa_or_species_p" , {
          'return_type' => 'boolean',
          'perl_name' => 'lower_taxa_or_species_p',
          'optional_params' => [],
          'lisp_name' => 'lower-taxa-or-species-p',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'org_frame'
                          ]
        }
 ];

push @tests, [ "do_facet_values" , {
          'return_type' => 'string',
          'perl_name' => 'do_facet_values',
          'optional_params' => [
                                 'kb',
                                 'local-only-p',
                                 'kb-local-only-p'
                               ],
          'lisp_name' => 'do-facet-values',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'var',
                            'frame',
                            'slot',
                            'facet'
                          ]
        }
 ];

push @tests, [ "add_slot_value" , {
          'return_type' => '',
          'perl_name' => 'add_slot_value',
          'optional_params' => [],
          'lisp_name' => 'add-slot-value',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'frame',
                            'slot',
                            'value'
                          ]
        }
 ];

push @tests, [ "put_frame_name" , {
          'return_type' => 'string',
          'perl_name' => 'put_frame_name',
          'optional_params' => [
                                 'kb',
                                 'kb-local-only-p'
                               ],
          'lisp_name' => 'put-frame-name',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'frame',
                            'new-name'
                          ]
        }
 ];

push @tests, [ "reaction_reactants_and_products" , {
          'return_type' => 'two_values',
          'perl_name' => 'reaction_reactants_and_products',
          'optional_params' => [],
          'lisp_name' => 'reaction-reactants-and-products',
          'named_params' => [
                              'pathway',
                              'direction'
                            ],
          'description' => '',
          'pos_params' => [
                            'reaction'
                          ]
        }
 ];

push @tests, [ "modified_containers" , {
          'return_type' => 'list',
          'perl_name' => 'modified_containers',
          'optional_params' => [],
          'lisp_name' => 'modified-containers',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'protein'
                          ]
        }
 ];

push @tests, [ "transcription_unit_genes" , {
          'return_type' => 'list',
          'perl_name' => 'transcription_unit_genes',
          'optional_params' => [],
          'lisp_name' => 'transcription-unit-genes',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'tu'
                          ]
        }
 ];

push @tests, [ "chromosome_of_gene" , {
          'return_type' => 'string',
          'perl_name' => 'chromosome_of_gene',
          'optional_params' => [],
          'lisp_name' => 'chromosome-of-gene',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'gene'
                          ]
        }
 ];

push @tests, [ "pathways_of_gene" , {
          'return_type' => 'list',
          'perl_name' => 'pathways_of_gene',
          'optional_params' => [],
          'lisp_name' => 'pathways-of-gene',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'gene'
                          ]
        }
 ];

push @tests, [ "top_containers" , {
          'return_type' => 'list',
          'perl_name' => 'top_containers',
          'optional_params' => [],
          'lisp_name' => 'top-containers',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'protein'
                          ]
        }
 ];

push @tests, [ "enzymes_of_organism_in_meta" , {
          'return_type' => 'list',
          'perl_name' => 'enzymes_of_organism_in_meta',
          'optional_params' => [],
          'lisp_name' => 'enzymes-of-organism-in-meta',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'gb_tax_id'
                          ]
        }
 ];

push @tests, [ "get_predecessors" , {
          'return_type' => 'list',
          'perl_name' => 'get_predecessors',
          'optional_params' => [],
          'lisp_name' => 'get-predecessors',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'reaction',
                            'pathway'
                          ]
        }
 ];

push @tests, [ "get_class_all_subs" , {
          'return_type' => 'list',
          'perl_name' => 'get_class_all_subs',
          'optional_params' => [],
          'lisp_name' => 'get-class-all-subs',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'class'
                          ]
        }
 ];

push @tests, [ "genes_of_pathway" , {
          'return_type' => 'list',
          'perl_name' => 'genes_of_pathway',
          'optional_params' => [],
          'lisp_name' => 'genes-of-pathway',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'pathwayframe'
                          ]
        }
 ];

push @tests, [ "detach_slot" , {
          'return_type' => 'frame,slot',
          'perl_name' => 'detach_slot',
          'optional_params' => [],
          'lisp_name' => 'detach-slot',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'kb',
                            'slot-type',
                            'value-selector',
                            'kb-local-only-p'
                          ]
        }
 ];

push @tests, [ "get_instance_direct_types" , {
          'return_type' => 'string',
          'perl_name' => 'get_instance_direct_types',
          'optional_params' => [],
          'lisp_name' => 'get-instance-direct-types',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'frame'
                          ]
        }
 ];

push @tests, [ "containing_tus" , {
          'return_type' => 'list',
          'perl_name' => 'containing_tus',
          'optional_params' => [],
          'lisp_name' => 'containing-tus',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'class'
                          ]
        }
 ];

push @tests, [ "member_facet_value_p" , {
          'return_type' => 'string',
          'perl_name' => 'member_facet_value_p',
          'optional_params' => [
                                 'kb',
                                 'test',
                                 'kb-local-only-p'
                               ],
          'lisp_name' => 'member-facet-value-p',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'frame',
                            'slot',
                            'facet',
                            'value'
                          ]
        }
 ];

push @tests, [ "terminators_affecting_gene" , {
          'return_type' => 'list',
          'perl_name' => 'terminators_affecting_gene',
          'optional_params' => [],
          'lisp_name' => 'terminators-affecting-gene',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'gene'
                          ]
        }
 ];

push @tests, [ "all_transcription_factors" , {
          'return_type' => 'list',
          'perl_name' => 'all_transcription_factors',
          'optional_params' => [],
          'lisp_name' => 'all-transcription-factors',
          'named_params' => [
                              'allow-modified-forms?'
                            ],
          'description' => '',
          'pos_params' => []
        }
 ];

push @tests, [ "all_transported_chemicals" , {
          'return_type' => 'list',
          'perl_name' => 'all_transported_chemicals',
          'optional_params' => [],
          'lisp_name' => 'all-transported-chemicals',
          'named_params' => [],
          'description' => '',
          'pos_params' => []
        }
 ];

push @tests, [ "reactions_of_enzyme" , {
          'return_type' => 'list',
          'perl_name' => 'reactions_of_enzyme',
          'optional_params' => [],
          'lisp_name' => 'reactions-of-enzyme',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'enzyme'
                          ]
        }
 ];

push @tests, [ "transcription_unit_activators" , {
          'return_type' => 'list',
          'perl_name' => 'transcription_unit_activators',
          'optional_params' => [],
          'lisp_name' => 'transcription-unit-activators',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'transcription_unit'
                          ]
        }
 ];

push @tests, [ "save_kb_as" , {
          'return_type' => '',
          'perl_name' => 'save_kb_as',
          'optional_params' => [
                                 'kb'
                               ],
          'lisp_name' => 'save-kb-as',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'new-name-or-locator'
                          ]
        }
 ];

push @tests, [ "transcription_factor_p" , {
          'return_type' => 'boolean',
          'perl_name' => 'transcription_factor_p',
          'optional_params' => [],
          'lisp_name' => 'transcription-factor?',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'protein'
                          ]
        }
 ];

push @tests, [ "get_frames_matching" , {
          'return_type' => 'list',
          'perl_name' => 'get_frames_matching',
          'optional_params' => [
                                 'kb',
                                 'wild-cards-allowed',
                                 'selector',
                                 'force-case-insensitive-p',
                                 'kb-local-only-p'
                               ],
          'lisp_name' => 'get-frames-matching',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'pattern'
                          ]
        }
 ];

push @tests, [ "enzymes_of_gene" , {
          'return_type' => 'list',
          'perl_name' => 'enzymes_of_gene',
          'optional_params' => [],
          'lisp_name' => 'enzymes-of-gene',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'gene'
                          ]
        }
 ];

push @tests, [ "transcription_unit_terminators" , {
          'return_type' => 'list',
          'perl_name' => 'transcription_unit_terminators',
          'optional_params' => [],
          'lisp_name' => 'transcription-unit-terminators',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'tu'
                          ]
        }
 ];

push @tests, [ "create_facet" , {
          'return_type' => 'string',
          'perl_name' => 'create_facet',
          'optional_params' => [],
          'lisp_name' => 'create-facet',
          'named_params' => [
                              'kb',
                              'create-p',
                              'kb-local-only-p'
                            ],
          'description' => '',
          'pos_params' => [
                            'name',
                            'frame',
                            'slot'
                          ]
        }
 ];

push @tests, [ "reactions_of_gene" , {
          'return_type' => 'list',
          'perl_name' => 'reactions_of_gene',
          'optional_params' => [],
          'lisp_name' => 'reactions-of-gene',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'gene'
                          ]
        }
 ];

push @tests, [ "facet_has_value_p" , {
          'return_type' => 'string',
          'perl_name' => 'facet_has_value_p',
          'optional_params' => [
                                 'kb',
                                 'kb-local-only-p'
                               ],
          'lisp_name' => 'facet-has-value-p',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'frame',
                            'slot',
                            'facet'
                          ]
        }
 ];

push @tests, [ "get_slot_value" , {
          'return_type' => 'string',
          'perl_name' => 'get_slot_value',
          'optional_params' => [],
          'lisp_name' => 'get-slot-value',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'frame',
                            'slot'
                          ]
        }
 ];

push @tests, [ "all_rxns" , {
          'return_type' => 'list',
          'perl_name' => 'all_rxns',
          'optional_params' => [
                                 'type'
                               ],
          'lisp_name' => 'all-rxns',
          'named_params' => [],
          'description' => '',
          'pos_params' => []
        }
 ];

push @tests, [ "frame_has_slot_p" , {
          'return_type' => 'frame,slot',
          'perl_name' => 'frame_has_slot_p',
          'optional_params' => [],
          'lisp_name' => 'frame-has-slot-p',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'kb',
                            'inference-level',
                            'slot-type',
                            'kb-local-only-p'
                          ]
        }
 ];

push @tests, [ "rename_facet" , {
          'return_type' => 'string',
          'perl_name' => 'rename_facet',
          'optional_params' => [
                                 'kb',
                                 'kb-local-only-p'
                               ],
          'lisp_name' => 'rename-facet',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'facet',
                            'new-name'
                          ]
        }
 ];

push @tests, [ "slot_has_facet_p" , {
          'return_type' => 'frame,slot,facet',
          'perl_name' => 'slot_has_facet_p',
          'optional_params' => [],
          'lisp_name' => 'boolean',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'kb',
                            'inference-level',
                            'slot-type',
                            'kb-local-only-p'
                          ]
        }
 ];

push @tests, [ "regulator_proteins_of_transcription_unit" , {
          'return_type' => 'list',
          'perl_name' => 'regulator_proteins_of_transcription_unit',
          'optional_params' => [],
          'lisp_name' => 'regulator-proteins-of-transcription-unit',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'tu'
                          ]
        }
 ];

push @tests, [ "remove_slot_value" , {
          'return_type' => 'frame,slot',
          'perl_name' => 'remove_slot_value',
          'optional_params' => [],
          'lisp_name' => 'remove-slot-value',
          'named_params' => [],
          'description' => '',
          'pos_params' => []
        }
 ];

push @tests, [ "superclass_of_p" , {
          'return_type' => 'superclass,subclass',
          'perl_name' => 'superclass_of_p',
          'optional_params' => [],
          'lisp_name' => 'superclass-of-p',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'kb',
                            'inference-level',
                            'kb-local-only'
                          ]
        }
 ];

push @tests, [ "get_frame_pretty_name" , {
          'return_type' => 'frame',
          'perl_name' => 'get_frame_pretty_name',
          'optional_params' => [],
          'lisp_name' => 'string',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'kb',
                            'kb-local-only-p'
                          ]
        }
 ];

push @tests, [ "transcription_unit_inhibitors" , {
          'return_type' => 'list',
          'perl_name' => 'transcription_unit_inhibitors',
          'optional_params' => [],
          'lisp_name' => 'transcription-unit-inhibitors',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'transcription_unit'
                          ]
        }
 ];

push @tests, [ "get_class_all_instances" , {
          'return_type' => 'list',
          'perl_name' => 'get_class_all_instances',
          'optional_params' => [],
          'lisp_name' => 'get-class-all-instances',
          'named_params' => [],
          'description' => '',
          'pos_params' => []
        }
 ];

push @tests, [ "regulon_of_protein" , {
          'return_type' => 'list',
          'perl_name' => 'regulon_of_protein',
          'optional_params' => [],
          'lisp_name' => 'regulon-of-protein',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'protein'
                          ]
        }
 ];

push @tests, [ "instance_all_instance_of_p" , {
          'return_type' => 'boolean',
          'perl_name' => 'instance_all_instance_of_p',
          'optional_params' => [],
          'lisp_name' => 'instance-all-instance-of-p',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'class'
                          ]
        }
 ];

push @tests, [ "print_frame" , {
          'return_type' => 'string',
          'perl_name' => 'print_frame',
          'optional_params' => [
                                 'kb',
                                 'inference-level',
                                 'kb-local-only-p'
                               ],
          'lisp_name' => 'print-frame',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'frame'
                          ]
        }
 ];

push @tests, [ "transcription_units_of_protein" , {
          'return_type' => 'list',
          'perl_name' => 'transcription_units_of_protein',
          'optional_params' => [],
          'lisp_name' => 'transcription-units-of-protein',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'protein'
                          ]
        }
 ];

push @tests, [ "direct_activators" , {
          'return_type' => 'list',
          'perl_name' => 'direct_activators',
          'optional_params' => [],
          'lisp_name' => 'direct-activators',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'entity'
                          ]
        }
 ];

push @tests, [ "get_slot_facets" , {
          'return_type' => 'list',
          'perl_name' => 'get_slot_facets',
          'optional_params' => [
                                 'kb',
                                 'local-only-p',
                                 'kb-local-only-p'
                               ],
          'lisp_name' => 'get-slot-facets',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'frame',
                            'slot'
                          ]
        }
 ];

push @tests, [ "primitive_p" , {
          'return_type' => 'class',
          'perl_name' => 'primitive_p',
          'optional_params' => [],
          'lisp_name' => 'primitive-p',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'kb',
                            'kb-local-only-p'
                          ]
        }
 ];

push @tests, [ "put_frame_pretty_name" , {
          'return_type' => 'frame,name',
          'perl_name' => 'put_frame_pretty_name',
          'optional_params' => [],
          'lisp_name' => 'put-frame-pretty-name',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'kb',
                            'kb-local-only-p'
                          ]
        }
 ];

push @tests, [ "facet_p" , {
          'return_type' => 'boolean',
          'perl_name' => 'facet_p',
          'optional_params' => [
                                 'kb',
                                 'kb-local-only-p'
                               ],
          'lisp_name' => 'facet-p',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'frame',
                            'slot',
                            'thing'
                          ]
        }
 ];

push @tests, [ "mapc-slot-facets" , {
          'return_type' => 'frame,slot,function',
          'perl_name' => 'mapc-slot-facets',
          'optional_params' => [],
          'lisp_name' => 'list',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'kb',
                            'local-only-p',
                            'kb-local-only'
                          ]
        }
 ];

push @tests, [ "genes_of_protein" , {
          'return_type' => 'list',
          'perl_name' => 'genes_of_protein',
          'optional_params' => [],
          'lisp_name' => 'genes-of-protein',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'protein'
                          ]
        }
 ];

push @tests, [ "mapc_facet_values" , {
          'return_type' => 'string',
          'perl_name' => 'mapc_facet_values',
          'optional_params' => [
                                 'kb',
                                 'local-only-p',
                                 'kb-local-only-p'
                               ],
          'lisp_name' => 'mapc-facet-values',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'frame',
                            'slot',
                            'facet',
                            'function'
                          ]
        }
 ];

push @tests, [ "get_slot_values" , {
          'return_type' => 'list',
          'perl_name' => 'get_slot_values',
          'optional_params' => [],
          'lisp_name' => 'get-slot-values',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'frame',
                            'slot'
                          ]
        }
 ];

push @tests, [ "get_reaction_list" , {
          'return_type' => 'list',
          'perl_name' => 'get_reaction_list',
          'optional_params' => [],
          'lisp_name' => 'get-reaction-list',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'pathwayframe'
                          ]
        }
 ];

push @tests, [ "subclass_of_p" , {
          'return_type' => 'subclass,superclass',
          'perl_name' => 'subclass_of_p',
          'optional_params' => [],
          'lisp_name' => 'boolean',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'kb',
                            'inference-level',
                            'kb-local-only-p'
                          ]
        }
 ];

push @tests, [ "products_of_reaction" , {
          'return_type' => 'list',
          'perl_name' => 'products_of_reaction',
          'optional_params' => [],
          'lisp_name' => 'products-of-reaction',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'reaction'
                          ]
        }
 ];

push @tests, [ "mapcar_slot_facets" , {
          'return_type' => 'list',
          'perl_name' => 'mapcar_slot_facets',
          'optional_params' => [
                                 'kb',
                                 'local-only-p',
                                 'kb-local-only-p'
                               ],
          'lisp_name' => 'mapcar-slot-facets',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'frame',
                            'slot',
                            'function'
                          ]
        }
 ];

push @tests, [ "transcription_unit_transcription_factors" , {
          'return_type' => 'list',
          'perl_name' => 'transcription_unit_transcription_factors',
          'optional_params' => [],
          'lisp_name' => 'transcription-unit-transcription-factors',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'bsite'
                          ]
        }
 ];

push @tests, [ "compounds_of_pathway" , {
          'return_type' => 'list',
          'perl_name' => 'compounds_of_pathway',
          'optional_params' => [],
          'lisp_name' => 'compounds-of-pathway',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'pathway'
                          ]
        }
 ];

push @tests, [ "add_facet_value" , {
          'return_type' => 'string',
          'perl_name' => 'add_facet_value',
          'optional_params' => [
                                 'kb',
                                 'test',
                                 'kb-local-only-p'
                               ],
          'lisp_name' => 'add-facet-value',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'frame',
                            'slot',
                            'facet',
                            'value'
                          ]
        }
 ];

push @tests, [ "reactions_of_compound" , {
          'return_type' => 'list',
          'perl_name' => 'reactions_of_compound',
          'optional_params' => [],
          'lisp_name' => 'reactions-of-compound',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'compound'
                          ]
        }
 ];

push @tests, [ "transcription_units_of_gene" , {
          'return_type' => 'list',
          'perl_name' => 'transcription_units_of_gene',
          'optional_params' => [],
          'lisp_name' => 'transcription-units-of-gene',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'gene'
                          ]
        }
 ];

push @tests, [ "save_kb" , {
          'return_type' => '',
          'perl_name' => 'save_kb',
          'optional_params' => [],
          'lisp_name' => 'save-kb',
          'named_params' => [],
          'description' => '',
          'pos_params' => []
        }
 ];

push @tests, [ "slot_p" , {
          'return_type' => 'boolean',
          'perl_name' => 'slot_p',
          'optional_params' => [
                                 'kb',
                                 'inference-level',
                                 'kb-local-only-p'
                               ],
          'lisp_name' => 'slot-p',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'thing'
                          ]
        }
 ];

push @tests, [ "full_enzyme_name" , {
          'return_type' => 'string',
          'perl_name' => 'full_enzyme_name',
          'optional_params' => [],
          'lisp_name' => 'full-enzyme-name',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'enzyme'
                          ]
        }
 ];

push @tests, [ "replace_slot_value" , {
          'return_type' => 'frame,slot,old_value,new_value',
          'perl_name' => 'replace_slot_value',
          'optional_params' => [],
          'lisp_name' => 'replace-slot-value',
          'named_params' => [],
          'description' => '',
          'pos_params' => []
        }
 ];

push @tests, [ "enzymes_of_reaction" , {
          'return_type' => 'list',
          'perl_name' => 'enzymes_of_reaction',
          'optional_params' => [],
          'lisp_name' => 'enzymes-of-reaction',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'reaction'
                          ]
        }
 ];

push @tests, [ "direct_inhibitors" , {
          'return_type' => 'list',
          'perl_name' => 'direct_inhibitors',
          'optional_params' => [],
          'lisp_name' => 'direct-inhibitors',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'entity'
                          ]
        }
 ];

push @tests, [ "individual_p" , {
          'return_type' => 'boolean',
          'perl_name' => 'individual_p',
          'optional_params' => [
                                 'kb',
                                 'kb-local-only-p'
                               ],
          'lisp_name' => 'individual-p',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'thing'
                          ]
        }
 ];

push @tests, [ "transcription_unit_mrna_binding_sites" , {
          'return_type' => 'list',
          'perl_name' => 'transcription_unit_mrna_binding_sites',
          'optional_params' => [],
          'lisp_name' => 'transcription-unit-mrna-binding-sites',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'transcription_unit'
                          ]
        }
 ];

push @tests, [ "all_modulators" , {
          'return_type' => 'list',
          'perl_name' => 'all_modulators',
          'optional_params' => [],
          'lisp_name' => 'all-modulators',
          'named_params' => [],
          'description' => '',
          'pos_params' => []
        }
 ];

push @tests, [ "enzyme_p" , {
          'return_type' => 'boolean',
          'perl_name' => 'enzyme_p',
          'optional_params' => [],
          'lisp_name' => 'enzyme?',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'protein'
                          ]
        }
 ];

push @tests, [ "get_frame_in_kb" , {
          'return_type' => 'two_values',
          'perl_name' => 'get_frame_in_kb',
          'optional_params' => [
                                 'kb',
                                 'error-p',
                                 'kb-local-only-p'
                               ],
          'lisp_name' => 'get-frame-in-kb',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'thing'
                          ]
        }
 ];

push @tests, [ "member_slot_value_p" , {
          'return_type' => 'boolean',
          'perl_name' => 'member_slot_value_p',
          'optional_params' => [
                                 'slot'
                               ],
          'lisp_name' => 'member-slot-value-p',
          'named_params' => [
                              'value'
                            ],
          'description' => '',
          'pos_params' => [
                            'frame'
                          ]
        }
 ];

push @tests, [ "get_frame_slots" , {
          'return_type' => 'string',
          'perl_name' => 'get_frame_slots',
          'optional_params' => [
                                 'kb',
                                 'inference-level',
                                 'slot-type',
                                 'kb-local-only-p'
                               ],
          'lisp_name' => 'get-frame-slots',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'frame'
                          ]
        }
 ];

push @tests, [ "modified_forms" , {
          'return_type' => 'list',
          'perl_name' => 'modified_forms',
          'optional_params' => [],
          'lisp_name' => 'modified-forms',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'protein'
                          ]
        }
 ];

push @tests, [ "pwys_of_organism_in_meta" , {
          'return_type' => 'list',
          'perl_name' => 'pwys_of_organism_in_meta',
          'optional_params' => [],
          'lisp_name' => 'pwys-of-organism-in-meta',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'gb_tax_id'
                          ]
        }
 ];

push @tests, [ "genes_regulated_by_gene" , {
          'return_type' => 'list',
          'perl_name' => 'genes_regulated_by_gene',
          'optional_params' => [],
          'lisp_name' => 'genes-regulated-by-gene',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'gene'
                          ]
        }
 ];

push @tests, [ "replace_facet_value" , {
          'return_type' => 'string',
          'perl_name' => 'replace_facet_value',
          'optional_params' => [
                                 'kb',
                                 'test',
                                 'kb-local-only-p'
                               ],
          'lisp_name' => 'replace-facet-value',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'frame',
                            'slot',
                            'facet',
                            'old-value',
                            'new-value'
                          ]
        }
 ];

push @tests, [ "get_slot_type" , {
          'return_type' => 'string',
          'perl_name' => 'get_slot_type',
          'optional_params' => [
                                 'kb',
                                 'inference-level',
                                 'kb-local-only-p'
                               ],
          'lisp_name' => 'get-slot-type',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'frame',
                            'slot'
                          ]
        }
 ];

push @tests, [ "class_all_type_of_p" , {
          'return_type' => 'boolean',
          'perl_name' => 'class_all_type_of_p',
          'optional_params' => [],
          'lisp_name' => 'class-all-type-of-p',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'frame',
                            'instance'
                          ]
        }
 ];

push @tests, [ "put_instance_types" , {
          'return_type' => 'string',
          'perl_name' => 'put_instance_types',
          'optional_params' => [],
          'lisp_name' => 'put-instance-types',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'frame',
                            'new_types'
                          ]
        }
 ];

push @tests, [ "monomers_of_protein" , {
          'return_type' => 'list',
          'perl_name' => 'monomers_of_protein',
          'optional_params' => [],
          'lisp_name' => 'monomers-of-protein',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'protein'
                          ]
        }
 ];

push @tests, [ "put_facet_value" , {
          'return_type' => 'string',
          'perl_name' => 'put_facet_value',
          'optional_params' => [
                                 'kb',
                                 'kb-local-only-p'
                               ],
          'lisp_name' => 'put-facet-value',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'frame',
                            'slot',
                            'facet',
                            'value'
                          ]
        }
 ];

push @tests, [ "remove_local_facet_values" , {
          'return_type' => 'string',
          'perl_name' => 'remove_local_facet_values',
          'optional_params' => [
                                 'kb',
                                 'kb-local-only-p'
                               ],
          'lisp_name' => 'remove-local-facet-values',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'frame',
                            'slot',
                            'facet',
                            'value'
                          ]
        }
 ];

push @tests, [ "transcription_unit_binding_sites" , {
          'return_type' => 'list',
          'perl_name' => 'transcription_unit_binding_sites',
          'optional_params' => [],
          'lisp_name' => 'transcription-unit-binding-sites',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'tu'
                          ]
        }
 ];

push @tests, [ "get_facet_values" , {
          'return_type' => 'string',
          'perl_name' => 'get_facet_values',
          'optional_params' => [],
          'lisp_name' => 'get-facet-values',
          'named_params' => [
                              'kb',
                              'kb-local-only-p'
                            ],
          'description' => '',
          'pos_params' => [
                            'frame',
                            'slot',
                            'facet',
                            'value'
                          ]
        }
 ];

push @tests, [ "rename_slot" , {
          'return_type' => 'string',
          'perl_name' => 'rename_slot',
          'optional_params' => [
                                 'kb',
                                 'kb-local-only-p'
                               ],
          'lisp_name' => 'rename-slot',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'slot',
                            'new-name'
                          ]
        }
 ];

push @tests, [ "substrates_of_reaction" , {
          'return_type' => 'list',
          'perl_name' => 'substrates_of_reaction',
          'optional_params' => [],
          'lisp_name' => 'substrates-of-reaction',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'reaction'
                          ]
        }
 ];

push @tests, [ "put_facet_values" , {
          'return_type' => 'string',
          'perl_name' => 'put_facet_values',
          'optional_params' => [
                                 'kb',
                                 'kb-local-only-p'
                               ],
          'lisp_name' => 'put-facet-values',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'frame',
                            'slot',
                            'facet',
                            'values'
                          ]
        }
 ];

push @tests, [ "containers_of" , {
          'return_type' => 'list',
          'perl_name' => 'containers_of',
          'optional_params' => [],
          'lisp_name' => 'containers-of',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'protein'
                          ]
        }
 ];

push @tests, [ "get_facet_value" , {
          'return_type' => 'string',
          'perl_name' => 'get_facet_value',
          'optional_params' => [],
          'lisp_name' => 'get-facet-value',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'frame',
                            'slot',
                            'facet',
                            'value'
                          ]
        }
 ];

push @tests, [ "get_frame_with_facet_value" , {
          'return_type' => 'list',
          'perl_name' => 'get_frame_with_facet_value',
          'optional_params' => [
                                 'kb',
                                 'local-only-p',
                                 'kb-only-p'
                               ],
          'lisp_name' => 'get-frame-with-facet-value',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'frame',
                            'slot',
                            'facet',
                            'value'
                          ]
        }
 ];

push @tests, [ "get_successors" , {
          'return_type' => 'list',
          'perl_name' => 'get_successors',
          'optional_params' => [],
          'lisp_name' => 'get-successors',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'reactionframe',
                            'pathwayframe'
                          ]
        }
 ];

push @tests, [ "genes_regulating_gene" , {
          'return_type' => 'list',
          'perl_name' => 'genes_regulating_gene',
          'optional_params' => [],
          'lisp_name' => 'genes-regulating-gene',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'gene'
                          ]
        }
 ];

push @tests, [ "enzymes_of_pathway" , {
          'return_type' => 'list',
          'perl_name' => 'enzymes_of_pathway',
          'optional_params' => [],
          'lisp_name' => 'enzymes-of-pathway',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'pathwayframe'
                          ]
        }
 ];

push @tests, [ "coercible_to_frame_p" , {
          'return_type' => 'boolean',
          'perl_name' => 'coercible_to_frame_p',
          'optional_params' => [],
          'lisp_name' => 'coercible-to-frame-p',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'frame'
                          ]
        }
 ];

push @tests, [ "all_products_of_gene" , {
          'return_type' => 'list',
          'perl_name' => 'all_products_of_gene',
          'optional_params' => [],
          'lisp_name' => 'all-products-of-gene',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'gene'
                          ]
        }
 ];

push @tests, [ "get_class_slot_slotvalue" , {
          'return_type' => 'string',
          'perl_name' => 'get_class_slot_slotvalue',
          'optional_params' => [
                                 'slot'
                               ],
          'lisp_name' => 'get-class-slot-slotvalue',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'frame'
                          ]
        }
 ];

push @tests, [ "put_slot_values" , {
          'return_type' => '',
          'perl_name' => 'put_slot_values',
          'optional_params' => [],
          'lisp_name' => 'put-slot-values',
          'named_params' => [],
          'description' => '',
          'pos_params' => []
        }
 ];

push @tests, [ "all_cofactors" , {
          'return_type' => 'list',
          'perl_name' => 'all_cofactors',
          'optional_params' => [],
          'lisp_name' => 'all-cofactors',
          'named_params' => [],
          'description' => '',
          'pos_params' => []
        }
 ];

push @tests, [ "enzyme_activity_name" , {
          'return_type' => 'string',
          'perl_name' => 'enzyme_activity_name',
          'optional_params' => [
                                 'reaction'
                               ],
          'lisp_name' => 'enzyme-activity-name',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'enzyme'
                          ]
        }
 ];

push @tests, [ "put_slot_value" , {
          'return_type' => '',
          'perl_name' => 'put_slot_value',
          'optional_params' => [],
          'lisp_name' => 'put-slot-value',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'frame',
                            'slot',
                            'value'
                          ]
        }
 ];

push @tests, [ "slot_has_value_p" , {
          'return_type' => 'frame,slot',
          'perl_name' => 'slot_has_value_p',
          'optional_params' => [],
          'lisp_name' => 'boolean',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'kb',
                            'inference-level',
                            'slot-type',
                            'value-selector',
                            'kb-local-only-p'
                          ]
        }
 ];

push @tests, [ "get_frame_type" , {
          'return_type' => 'string',
          'perl_name' => 'get_frame_type',
          'optional_params' => [
                                 'kb',
                                 'inference-level',
                                 'kb-local-only-p'
                               ],
          'lisp_name' => 'get-frame-type',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'thing'
                          ]
        }
 ];

push @tests, [ "get_frame_name" , {
          'return_type' => 'string',
          'perl_name' => 'get_frame_name',
          'optional_params' => [
                                 'kb',
                                 'kb-local-only-p'
                               ],
          'lisp_name' => 'get-frame-name',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'frame'
                          ]
        }
 ];

push @tests, [ "type_of_p" , {
          'return_type' => 'boolean',
          'perl_name' => 'type_of_p',
          'optional_params' => [
                                 'kb',
                                 'inference-level',
                                 'kb-local-only'
                               ],
          'lisp_name' => 'type-of-p',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'class',
                            'frame'
                          ]
        }
 ];

push @tests, [ "revert_kb" , {
          'return_type' => '',
          'perl_name' => 'revert_kb',
          'optional_params' => [
                                 'kb'
                               ],
          'lisp_name' => 'revert-kb',
          'named_params' => [],
          'description' => '',
          'pos_params' => []
        }
 ];

push @tests, [ "get_class_instances" , {
          'return_type' => 'list',
          'perl_name' => 'get_class_instances',
          'optional_params' => [
                                 'kb',
                                 'inference-level',
                                 'number-of-values',
                                 'kb-local-only-p'
                               ],
          'lisp_name' => 'get-class-instances',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'class'
                          ]
        }
 ];

push @tests, [ "transporter_p" , {
          'return_type' => 'boolean',
          'perl_name' => 'transporter_p',
          'optional_params' => [],
          'lisp_name' => 'transporter?',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'protein'
                          ]
        }
 ];

push @tests, [ "reactions_of_protein" , {
          'return_type' => 'list',
          'perl_name' => 'reactions_of_protein',
          'optional_params' => [],
          'lisp_name' => 'reactions-of-protein',
          'named_params' => [
                              'lists'
                            ],
          'description' => 'all reactions for a given protein',
          'pos_params' => [
                            'protein'
                          ]
        }
 ];

push @tests, [ "genes_of_reaction" , {
          'return_type' => 'list',
          'perl_name' => 'genes_of_reaction',
          'optional_params' => [],
          'lisp_name' => 'genes-of-reaction',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'reaction'
                          ]
        }
 ];

push @tests, [ "all_pathways" , {
          'return_type' => 'list',
          'perl_name' => 'all_pathways',
          'optional_params' => [
                                 'all'
                               ],
          'lisp_name' => 'all-pathways',
          'named_params' => [],
          'description' => '',
          'pos_params' => []
        }
 ];

push @tests, [ "transcription_unit_promoter" , {
          'return_type' => 'string',
          'perl_name' => 'transcription_unit_promoter',
          'optional_params' => [],
          'lisp_name' => 'transcription-unit-promoter',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'tu'
                          ]
        }
 ];

push @tests, [ "mapcar_facet_values" , {
          'return_type' => 'string',
          'perl_name' => 'mapcar_facet_values',
          'optional_params' => [
                                 'kb',
                                 'local-only-p',
                                 'kb-local-only-p'
                               ],
          'lisp_name' => 'mapcar-facet-values',
          'named_params' => [],
          'description' => '',
          'pos_params' => [
                            'frame',
                            'slot',
                            'facet',
                            'function'
                          ]
        }
 ];

push @tests, [ "all_orgs" , {
          'return_type' => 'list',
          'perl_name' => 'all_orgs',
          'optional_params' => [
                                 'verbose'
                               ],
          'lisp_name' => 'all-orgs',
          'named_params' => [],
          'description' => '',
          'pos_params' => []
        }
 ];




foreach my $t (@tests) { 
    is_deeply( $c->get_function_def($t->[0]), $t->[1], "$t->[0] definition");
}

