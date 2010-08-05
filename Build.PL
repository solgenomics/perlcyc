use Module::Build;
my $build = Module::Build->new(
    module_name        => 'perlcyc',
    license            => 'mit',
    create_makefile_pl => 'passthrough',
    dist_abstract      => 'Perl interface to Pathway Tools',
    add_to_cleanup     => [ ],
    meta_merge           => {
        resources =>
          { repository => 'http://github.com/solgenomics/perlcyc', },
    },

    # and now the list of perl module dependencies
    requires           => {
     'perl'   => '5.10',
     'Carp'   => 0,
     'Socket' => 0,
    },
    build_requires => {
        'Test::More'      => 0,
    },
);
$build->create_build_script;
