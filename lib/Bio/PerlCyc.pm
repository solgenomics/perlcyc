

=head1 NAME 

Bio::PerlCyc - A Perl interface for Pathway Tools software for UNIX-based
systems.

=head1 SYNOPSIS

PerlCyc is a Perl interface for Pathway Tools software. Pathway Tools 
software needs to run a special socket server program for this module
to work (see below).

C<use Bio::Perlcyc;>

C<my $cyc = Bio::PerlCyc -E<gt> new("ARA");>
C<my @pathways = $cyc -E<gt> all_pathways();>

=head1 PATHWAY TOOLS REQUIREMENTS

To use the Perl module, you also need the socket_server.lisp
program. In Pathway Tools version 8.0 or later, the server program can
be started with the command line option "-api". On earlier versions,
the server daemon needs to be loaded manually, as follows: start
Pathway-Tools with the -lisp option, at the prompt, type: (load
"/path/to/socket_server.lisp"), then start the socket_server by typing
(start_external_access_daemon :verbose? t). The server is now ready to
accept connections and queries.

=head1 DESCRIPTION

PerlCyc is a Perl module for accessing internal Pathway-Tools functions. For the description of what the individual functions do,
please refer to the Pathway Tools documentation at http://bioinformatics.ai.sri.com/ptools .

In general, the Lisp function name has to be converted to something compatible with Perl: Dashes have to be replaced by underlines, and question marks with underline p (_p).  

Optional and named arguments are supported as of version 2.0. The optional positional arguments can just be given as the required positional arguments, and the named arguments are provided through a hashref as follows:

my @return = $cyc->sample_function($arg1, $arg2, $optional_arg1, { named_arg1 => $named_arg1, named_arg2 => $named_arg2 })


=head3 Limitations

Perlcyc does not run on Windows, because perlcyc creates a file system
socket that is not supported in Windows. It should run in Solaris,
Linux, MacOSX and other UNIX-like operating systems.

Perlcyc does not implement the GFP objects in Perl; it just sends
snippets of code to Pathway-Tools through the file socket
connection. Because of this, only one such connection can be openend
at any given time.

Given that the objects are not implemented in Perl, only object
references are supported.

=head3 Available functions:

  Object functions:

   new
   Parameters: The knowledge base name. Required!

  GFP functions: 
  More information on these functions can be found at:
  http://www.ai.sri.com/~gfp/spec/paper/node63.html
    
   get_slot_values
   get_slot_value 
   get_class_all_instances 
   instance_all_instance_of_p
   member_slot_value_p 
   fequal 
   current_kb  
   put_slot_values
   put_slot_value
   add_slot_value
   replace_slot_value
   remove_slot_value
   coercible_to_frame_p
   class_all_type_of_p
   get_instance_direct_types
   get_instance_all_types
   get_frame_slots
   put_instance_types
   save_kb
   revert_kb
   
  Pathway-tools functions:
  More information on these functions can be found at:
  http://bioinformatics.ai.sri.com/ptools/ptools-fns.html

   select_organism 
   all_pathways   
   all_orgs
   all_rxns
   genes_of_reaction
   substrates_of_reaction
   enzymes_of_reaction
   reaction_reactants_and_products
   get_predecessors
   get_successors
   genes_of_pathway
   enzymes_of_pathway
   compounds_of_pathway
   substrates_of_pathway
   transcription_factor_p
   all_cofactors
   all_modulators
   monomers_of_protein
   components_of_protein
   genes_of_protein 
   reactions_of_enzyme
   enzyme_p 
   transport_p
   containers_of 
   modified_forms 
   modified_containers
   top_containers 
   reactions_of_protein
   regulon_of_protein 
   transcription_units_of_protein
   regulator_proteins_of_transcription_unit
   enzymes_of_gene 
   all_products_of_gene
   reactions_of_gene 
   pathways_of_gene 
   chromosome_of_gene
   transcription_unit_of_gene 
   transcription_unit_promoter 
   transcription_unit_genes 
   transcription_unit_binding_sites 
   transcription_unit_transcription_factors
   transcription_unit_terminators 
   all_transported_chemicals 
   reactions_of_compound 
   full_enzyme_name 
   enzyme_activity_name 
   find_indexed_frame
   create-instance
   create-class
   create-frame

   pwys-of-organism-in-meta
   enzymes-of-organism-in-meta
   lower-taxa-or-species-p org-frame
   get-class-all-subs

  added 5/2008 per Suzanne's request:
   genes-regulating-gene
   genes-regulated-by-gene
   terminators-affecting-gene
   transcription-unit-mrna-binding-sites
   transcription-unit-activators
   transcription-unit-inhibitors
   containing-tus
   direct-activators
   direct-inhibitors

   added 01/2010:
   

  not supported:
   get_frames_matching_value (why not?)

  Internal functions:
   
   parselisp
   send_query
   retrieve_results
   wrap_query
   call_func
   debug 
   debug_on
   debug_off 

  Deprecated functions
   parse_lisp_list

=head1 EXAMPLES

Change product type for all genes that are in a pathway to 'Enzyme'

 use Bio::PerlCyc;

 my $cyc = Bio::PerlCyc -> new ("ARA");
 my @pathways = $cyc -> all_pathways();

 foreach my $p (@pathways) {
   my @genes = $cyc -> genes_of_pathway($p);
   foreach my $g (@genes) {
     $cyc -> put_slot_value ($g, "Product-Types", "Enzyme");
   }
 }


Load a file containing two columns with accession and a comment into
the comment field of the corresponding accession:

 use Bio::PerlCyc;
 use strict;
 
 my $file = shift;

 my $added=0;
 my $recs =0;

 open (F, "<$file") || die "Can't open file\n";

 print STDERR "Connecting to AraCyc...\n";
 my $cyc = Bio::PerlCyc -> new("ARA");

 print STDERR "Getting Gene Information...\n";
 my @genes = $cyc -> get_class_all_instances("|Genes|");

 my %genes;

 print STDERR "Getting common names...\n";
 foreach my $g (@genes) {
   my $cname = $cyc -> get_slot_value($g, "common-name"); 
   $genes{$cname}=$g; 
 } 

 print STDERR "Processing file...\n";
 while (<F>) { 
   my ($locus, $location, @rest) = split /\t/;
   $recs++;
   if (exists $genes{$locus}) { 
       my $product = $cyc -> get_slot_value($genes{$locus}, "product");
         if ($product) {
         $cyc -> add_slot_value($product, "comment", "\"\nTargetP location: $location\n\"");
          #print STDERR "Added to description of frame $product\n";
         $added++;
       }
     }
 }

 close (F);

 print STDERR "Done. Added $added descriptions. Total lines in file: $recs. \n";


Add a locus link to the TAIR locus page for each gene in the database

 use strict;
 use Bio::PerlCyc;

 my $added =0;
 my $genesprocessed=0;

 print "Connecting to AraCyc...\n";
 my $cyc = Bio::PerlCyc -> new ("ARA");

 print "Getting Gene Information...\n";
 my @genes = $cyc -> get_class_all_instances ("|Genes|");

 print "Adding TAIR links...\n";
 foreach my $g (@genes) {
   $genesprocessed++;
   my $common_name = $cyc -> get_slot_value($g, "common-name");
   if ($common_name && ($common_name ne "NIL")) {
     $cyc -> put_slot_value ($g, "dblinks", "(TAIR \"$common_name\")"); 
     $added++;
   }
   if ((!$genesprocessed ==0) && ($genesprocessed % 1000 == 0)) { print "$genesprocessed ";}
 }

 print "Done. Processed $genesprocessed genes and added $added links. Thanks!\n";
 $cyc -> close();

=head1 TROUBLESHOOTING

If your program terminates with the following error message:
C<connect: No such file or directory at Bio::Perlcyc.pm line 166.>
then the lisp_server.lisp module in Pathway Tools is not running.
Refer to http://aracyc.stanford.edu for more information on how to 
run the server program.

Please send bug reports and comments to 
lam87@cornell.edu

=head1 LICENSE

According to the MIT License,
http://www.opensource.org/licenses/mit-license.php

Copyright (c) 2002-2011 by Lukas Mueller. 

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

=head1 AUTHOR

Lukas Mueller <lam87@cornell.edu>

=head1 ACKNOWLEDGMENTS

Many thanks to Suzanne Paley, Danny Yoo and Thomas Yan.

=head1 FUNCTIONS

The following methods are defined in this class:

=cut

use strict;
use warnings;

package Bio::PerlCyc;
our $VERSION="2.00";
our $AUTOLOAD;

use Socket;
use Carp;


sub AUTOLOAD {
    my $self = shift;
    my $perl_name = $AUTOLOAD;
    print STDERR "PROCESSING $AUTOLOAD ".(join " ", @_)."\n" if ($self->debug());
    $perl_name =~ s/.*::(.+)$/$1/;
    if (my $f = $self->get_function_def($perl_name)) { 
	$self->construct_call($f, @_);
    }
}

=head2 new

 Usage:         my $cyc = Bio::PerlCyc->new("ECOLI");  
 Desc:          creates a new Bio::PerlCyc object.
               
 Ret:
 Args:          A string specifying the database to connect to.
                Typical values are "ECOLI" (for EcoCyc") or "ARA" (for 
                AraCyc, etc). 
                
                Hash style entries can be given for options. Currently,
                only the debug option is supported. For example,

                my $cyc = Bio::PerlCyc->new("LYCO", debug=>1);

                connects to the LycoCyc database (which must be locally
                installed, of course), and turns debug messaging on.

 Side Effects:  None.

=cut

sub new {
    my $class = shift;
    my $organism =shift;
    my %args = @_;

    $organism || die("Database organism identifier is a required argument in the constructor.\n");
    
    # initialize object's variable hash
    my $self = bless {}, $class;
    $self->{_organism} = $organism;
    $self->{_socket_name} = "/tmp/ptools-socket";
    $self->{_debug} = $args{debug};
    $self->{_socket} = undef;
    $self->{_defs} = {};
    $self->read_function_defs();
    return $self;
}

=head2 read_function_defs

    Reads the function defs from the __DATA__ section.

=cut

sub read_function_defs { 
    my $self = shift;
    while (<DATA>) { 
	chomp;
	my ($perl_name, $lisp_name, $return_type, $params, $optional_params, $named_params, @description) = split /\s+/;
	
	my $description = join " ", @description;

	$self->{_defs}->{$perl_name} = {
	    perl_name => $perl_name,
	    lisp_name => $lisp_name, 
	    params => $params, 
	    named_params => $named_params,
	    optional_params => $optional_params, 
	    return_type => $return_type,
	    description => $description 
	};
    }
}

=head2 get_function_def
    
    Returns the definition of a function as a hash with the following keys:
       perl_name
       list_name
       params
       keyed_params
       optional_params
       return_type
    Args: the perl function name.

=cut 

sub get_function_def { 
    my $self = shift;
    my $function = shift;
    
    if (!exists($self->{_defs}->{$function})) { 
	warn "Function $function is not recognized by PerlCyc.\n";
	return undef;
    }
    else { 
	warn "PerlCyc knows about the function $function...\n";
	return $self->{_defs}->{$function};
    }
}

sub get_function_lisp_name { 
    my $self = shift;
    my $perl_name = shift;
    if (!exists($self->{_defs}->{$perl_name})) { 
	warn "Function $perl_name is not recognized by PerlCyc.\n";
	return undef;
    }
    return $self->{_defs}->{$perl_name}->{lisp_name};
}

=head2 construct_call()

    Constructs the call from the information provided to AUTOLOAD.
    Called from AUTOLOAD.

=cut

sub construct_call { 
    my $self = shift;
    
    my $f = shift;
    my @params = @_;

    my @call = ();

    push @call, $f->{lisp_name};

    my @named_params = split ",", $f->{named_params} if (exists($f->{names_params}));
    my %np = ();
    foreach my $a (@named_params) { 
	$np{$a} = 1;
    }

    my @optional_params = split ",", $f->{optional_params};
   
    # process required positional arguments
    my $i = 0;
    if ($f->{params} ne "-") { 
	for ($i=0; $i<@named_params; $i++) { 
	    my $p;
	    if (!defined($params[$i])) { 
		die "Missing positional argument in function $f->{perl_name}";
	    }
	    if ($named_params[$i] =~ /frame/) { $p = protectFrameName($params[$i]); }
	    else { 
		$p = $params[$i];
		
	    }
	    warn "Adding $p...\n";
	    push @call, $p;
	    $i++;
	}
	
    }
    else { 
	warn("function $f->{perl_name} has no required arguments.\n");
    }
    
    # process optional positional arguments
    # note: we don't need to worry about defaults, as they will be provided by LISP.
    #

    warn "OPTIONAL PARAMS: @optional_params\n";
    if ($optional_params[0] ne "-") { 
	warn "PUSHING OPTIONAL PARAM $params[$i]...\n";
	while (defined($params[$i]) && (ref($params[$i]) ne 'HASH')) { 

	    warn("Pushing optional parameter $params[$i]\n");
	    push @call, $params[$i];
	    $i++;
	}
	
    }

    # process keyword parameters.
    # no need to worry about defaults.
    #
    if (ref($params[$i]) eq "HASH") { 
	foreach my $a (keys( %{$params[$i]} ) ) { 
	    if (exists($np{$a})) { 
		$np{$a}--;
		push @call, ":".$a." ".$params[$i]->{$a};
	    }
	    else {
		warn "Named or optional argument $a not recognized in function $f->{perl_name}\n";
	    }
	}
    }

    
#     # check if we need a keyed parameter
#     foreach my $a (keys(%np)) { 
# 	if ($a ne "-" && $np{$a} > 0) { 
# 	    push @call, ":".$arg." ".$default;
# 	    warn "Named parameter $a not provided for function $f->{perl_name}. Using default $default.";
# 	}
#     }
     
    my $call = join " ", @call;
    
    print STDERR "CALL: $call.\n" if ($self->debug());
    if ($f->{return_type} eq "list" || $f->{return_type} eq "-") { 
	$self->call_func($call);
    }
    elsif ($f->{return_type} eq "boolean") { 
	$self->call_func_that_returns_boolean($call);
    }
    elsif ($f->{return_type} eq "two_values") { 
	$self->call_func_that_returns_two_values($call);
    }
    elsif ($f->{return_type} eq "string") { 
	$self->call_func_that_returns_string($call);
    }
    else { 
	die "$f->{perl_name} has unknown return type $f->{return_type}.\n";
    }
    
}

=head2 socket_name
    
  Usage: $cyc->socket_name($new_socket_name);
  Desc : get/set the name of the local socket file
         to connect to
  Args : (optional) local socket name.
         defaults to '/tmp/ptools-socket'
  Ret  : current set local socket filename
  Side Effects: none
  Example:

=cut

sub socket_name {
    my $self = shift;
    $self->{_socket_name} = shift if @_;
    $self->{_socket_name};
}

=head2 makeSocket { 

    Creates the socket in the file system.

=cut 

sub makeSocket {
    my $self = shift;
    # get socket connection with pathway-tools
    socket(SOCK, PF_UNIX, SOCK_STREAM, 0) || die "socket: $!";
    my $sock =
    connect (SOCK,  sockaddr_un($self->{_socket_name}))
        or croak "could not connect to Pathway Tools socket '$self->{_socket_name}': $!\nIs Pathway Tools running?\n";
    my $old_fh = select(SOCK); $|=1; select($old_fh);
    $self->{_socket} = \*SOCK;
}

=head2 close()

    Closes the socket.

=cut 

sub close {
    my $self = shift;
    close($self->{_socket});
}

# the old lisp parser -- now deprecated
sub parse_lisp_list {
    my ($list_expr) = @_;
    my @results;
    while ($list_expr =~ m/
                           \|(.+?)\|      # match words delimited by pipes
                           |              # or
                           ([\w-]+)       # match a single word
	   /xg) {
	push @results, $1 || $2;
    }
    return @results;
}

## Given a lisp expression, returns a Perl list, where every inner
## Lisp list is converted into an equivalent Perl arrayref.
sub parselisp {
    my ($self, $lisp_string) = @_;
    my @tokens = tokenize($lisp_string);
    my $parsed_expr = parseExpr(\@tokens);

    if (wantarray && ref($parsed_expr)) {
	## Shallow flatten the list by one level if we're in list context.
	return @$parsed_expr;
    }
    else {
	return $parsed_expr;
    }
}

######################################################################
# Danny's Lisp parsing routines.
######################################################################

## Parses a lisp expression.
sub parseExpr {
    my ($token_ref) = @_;
    if (!(@$token_ref)) { return undef; }
    my $first = $token_ref->[0];
    if ($first eq '(') {
	shift @$token_ref;
	my @list_elements;
	while ($token_ref->[0] ne ')') {
	    push @list_elements, parseExpr($token_ref);
	}
	shift @$token_ref;
	return [@list_elements];
    }
    elsif ($first eq 'NIL') {
	shift (@$token_ref);
	return [];
    }
    else {
	return shift(@$token_ref);
    }
}

sub tokenize {
     my ($s) = @_;
     my $LPAREN = '\(';
     my $RPAREN = '\)';
     my $WSPACE = '\s+';
     my $STRING = '\"[^"]*?\"';
     my $PIPES = '\|[^\|]*?\|';
     my @tokens = grep {$_} split /($LPAREN|$RPAREN|$STRING|$PIPES)|$WSPACE/, $s;
     @tokens = map { $_ =~ s/\"([^\"]*)\"/$1/;  $_ } @tokens;  ## removes outer quotes from the string.
## note: we must not wipe out bars because they're used in frame ids.  Do not strip them out.
#     @tokens = map { $_ =~ s/\|([^|]*)\|/$1/;  $_ } @tokens;  ## removes outer pipes from the string.
     return @tokens;
}

sub send_query {
    # sends a query to server
    my $self = shift;
    my $query = shift;
    $self->makeSocket();
    $self-> debug_off();
    $self -> debug("Now sending query: $query");
    $self-> debug_off();
    my $s = $self->{_socket};
    print $s "$query\n";
}       

sub retrieve_results {
    # retrieves a result from the server after a query has been sent and parses it into an array.
    my $self = shift;
    my $s = $self->{_socket};
    my @results;
    while (<$s>)
    {
	push @results, $_;
    }
    return $self->parselisp(join("\n", @results));
}    

sub retrieve_results_string {
    my $self = shift;
    my $s = $self->{_socket};
    my @results;
    while (<$s>) {
      chomp;
      push @results, $_;
    }
    if ($results[0] eq "NIL") { $results[0]=""; }
    $results[0]=~s/\"(.*)\"/$1/;
    return ($results[0]);
}

sub retrieve_results_array {
    my $self = shift;
    my $s = $self->{_socket};
    my @results;
    while (<$s>) {
      chomp;
      push @results, $_;
    }
    return (@results);
}


sub wrap_query {
    my $self = shift;
    my $s = shift;
    return "(with-organism (:org-id\'".$self->{_organism}.") (mapcar #\'object-name ($s)))";
}

sub call_func {
    # used for functions that return a list. The list is converted to a list of object-names
    # and the resulting list is parsed into an array.
    #
    my $self = shift;
    my $function = shift;
##    print $self->wrap_query($function), "\n"; ## debug
    $self->send_query ($self->wrap_query($function));
    my @result = $self-> retrieve_results();

    $self -> debug_off();
    if ($self->debug) { 
      foreach my $r (@result) {
	print "READ TOKEN: $r\n";
      }
    }

    return @result;
}

## Similar to call_function, but forces scalar constext on retreive_results so that it maintains
## the inner list structure of 'result', array references and all.
sub call_func_with_structure {
    my $self = shift;
    my $function = shift;
    $self->send_query ($self->wrap_query($function));
    my $result = $self->retrieve_results();
    return $result;
}


# Caution! The following function is deprecated and doesn't work.
# Wrap your query instead in a multiple-value-list call.
sub call_func_that_returns_two_values {
  # used for functions that return two values (lisp lists). The lists 
  # are converted to two arrays, and two pointers to arrays are returned.
  my $self = shift;
  my $function = shift;
  $self->debug("Sending query...\n");
  $self -> send_query($self->wrap_query($function));
  $self->debug("QUERY SENT: $function\n");
  my ($res1, $res2) = $self -> retrieve_results_array();
  $self->debug("Results: $res1, $res2\n") if (defined($res1) && defined($res2));
  my ($list1, $list2) = $self -> parse_lisp_list($res1);
  $self->debug("LISTS: $list1\n$list2\n\n");
  my (@res1) = $self -> parse_lisp_list($list1);
  my (@res2) = $self -> parse_lisp_list($list2);
  return (\@res1, \@res2);
}

sub call_func_that_returns_string {
    # use for functions that will return a string and not a list. 
    # this function doesn't call mapcar and doesn't parse the returned list.
    #
    my $self = shift;
    my $function = shift;
   $self-> send_query ("(with-organism (:org-id\'".$self->{_organism}.") (object-name ($function)))");
  
    return $self-> retrieve_results_string();
}

sub call_func_that_returns_boolean {
   # call this function for functions that return a boolean.
  my $self = shift;
  my $function = shift;
  my $s = $self -> call_func_that_returns_string($function);
  if ($s eq "") { return ""; }
  else {
    return "T";
  }
}

# Some functions that need special treatment...
#

sub current_kb {
    my $self = shift;
    #this may not make sense because we prefix everything with select-organism.
    #maybe we should just return $self->{_organism}?
    #return $self->call_func("current-kb");
    return $self->{_organism};
}

## Warning: specialized because we're getting the list of elements in an order
## we didn't expect. -Danny 11/11/03
sub get_instance_all_types {
  my $self = shift;
  my $frame = shift;
  $frame = protectFrameName($frame);
  my $lisp_query = "
  (let* ((results (with-organism (:org-id 'ARA) 
                                                    (get-instance-all-types '$frame))))
           (mapcar #'get-frame-pretty-name results))";
	$self->send_query($lisp_query);
  my @results = $self->retrieve_results();
  return split_up_types(@results);
}

sub split_up_types {
    my @results = @_;
    my $in_frames = 0;
    my @groups;

    my @titles;
    for my $e (@results) {
	if ($e ne 'THINGS') {
	    push @titles, $e;
	}
	else {
	    last;
	}
    }
    @titles = reverse @titles;

##    print "DEBUG dyoo: ", join(", ", @results), "\n";
    my @row;
    for my $e (@results, 'THINGS') {
	if ($e eq 'FRAMES') {
	    $in_frames = 1;
	}
	elsif ($e eq 'THINGS') {
	    shift @row; ## remove first element "Generalized-reactions"
	    if (@row) {
		push @groups, [@row, (shift @titles)];
	    }
	    $in_frames = 0;
	    @row = ();
	}
	elsif ($in_frames) {
	    push @row, $e;
	}
    }
    return @groups;
}

sub find_indexed_frame {
  my $self =shift;
  my $datum = shift;
  my $class = shift;
  return $self -> call_func("multiple-value-list (find-indexed-frame \'$datum \'$class)");
}

sub gfp_get_value_annot { 
    my $self = shift;
    my $frame1 = shift;
    my $term1 = shift;
    my $frame2 = shift;
    my $term2 = shift;

    return $self->call_func_that_returns_string("gkb:get_value_annot \'$frame1 \'$term1 \'$frame2 \'$term2");
}

sub gfp_get_value_annots { 
    my $self = shift;
    my $frame1 = shift;
    my $term1 = shift;
    my $frame2 = shift;
    my $term2 = shift;

    return $self->call_func("gkb:get_value_annots \'$frame1 \'$term1 \'$frame2 \'$term2");
}


sub protectFrameName {
    my $frame = shift;
    if ($frame =~ m/^\|.*\|$/) { return $frame; } ## if already pipe protected, don't do anything.
    if ($frame =~ m/\s/) {
	return "|$frame|";
    }
    return $frame;
}

sub substrates_of_pathway {
     my $self = shift;
     my $pathway = shift;
     return $self -> call_func("multiple-value-list (substrates-of-pathway \'$pathway)");
}

sub components_of_protein {
    my $self = shift;
    my $protein = shift;
    my $coefficient = shift;
    if ($coefficient) { $coefficient = "\'$coefficient";}
    else { 
	$coefficient = "";
    }
    return $self -> call_func("multiple-value-list (components-of-protein \'$protein $coefficient )");
}


sub create_instance { 
    my $self = shift;
    my $name = shift;
    my @types = @_;
    my $types = "";
    foreach my $t (@types) { 
	$types .= " \'$t";
    }
    if (@types > 1) { "(".$types.")"; }
    
    return $self -> call_func_that_returns_string("create-instance \'$name $types");
}

sub create_class {
    my $self = shift;
    my $name = shift;
    my @direct_supers = @_;
    my $supers = undef;
    foreach my $ds (@direct_supers) { 
	$supers .= " \'$ds";
    }
   if (@direct_supers > 1) { 
	$supers = "(".$supers.")";
    }
    
    return $self -> call_func_that_returns_string("create-class \'$name $supers");
}

# create-frame  name &key direct-types direct-supers doc template-slots template-facets own-slots own-facets kb error-p
sub create_frame {
    my $self = shift;
    my $name = shift;
    my @types = @_;
    my $types = undef;

    foreach my $t (@types) { 
	$types .= " :direct-types \'$t";
    }
    return $self -> call_func_that_returns_string("create-frame \'$name $types");
}

# # Pathway-Tools internal lisp functions
# #

 sub select_organism {
    # this just sets a variable in the object and doesn't access the 
    # select-organism function in lisp. The selected organism is prefixed to
    # every query sent to the socket server.
    #
    my $self = shift;
    my $organism = shift;
    $self -> {_organism} = $organism;
}

## Converts a Perl boolean value to the equivalent Lisp value.
sub perl_boolean_to_lisp {
    my ($value) = @_;
    if ($value) {
	return "T";
    } else {
	return "NIL";
    }
}

## Converts a Perl value to NIL if necessary.
sub perl_undef_to_nil {
    my ($value) = @_;
    if (defined($value)) { return $value; }
    else {
	return "NIL";
    }
}

## Implements the GET-NAME-STRING wrapper.
sub get_name_string {
    my $self = shift;
    my $frame = shift;
    $frame = protectFrameName($frame);
    my %args = (
		rxn_eqn_as_name => 1,
		direction => undef,
		name_slot => undef,
		strip_html => undef,
		@_
		);
    return $self->call_func_that_returns_string("get-name-string \'$frame"
			    . ( " :rxn-eqn-as-name? " 
				. perl_boolean_to_lisp($args{rxn_eqn_as_name}))
			    . ( "  :direction " 
				. perl_undef_to_nil($args{direction}))
			    . ( "  :name-slot "
				. perl_undef_to_nil($args{name_slot}))
			    . ( "  :strip-html? "
				. perl_boolean_to_lisp($args{strip_html})));
}


sub perl_to_list {
# converts function names from perl to list
}

# Debugging functions
#

=head2 debug()

 Usage:
 Desc:
 Ret:
 Args:
 Side Effects:
 Example:

=cut

sub debug {
    my $self = shift;
    my $message = shift;
    if ($self -> {_debug}) { print "$message\n"; }
} 

=head2 debug_on(), debug_off()

 Usage: 
 Desc:         Turn debug on or off.
 Ret:
 Args:
 Side Effects: if turned on, debug information sent to STDERR
 Example:

=cut

sub debug_on {
    my $self = shift;
    $self->{_debug} = "TRUE";
}

sub debug_off {
    my $self = shift;
    $self->{_debug} = "";
}

1;

## DATA section lists function as: perl name, lisp name, positional arguments, optional positional arguments, named arguments.

__DATA__

print_frame print-frame string frame kb,inference-level,kb-local-only-p
primitive_p primitive-p class kb,kb-local-only-p
put_frame_name put-frame-name string frame,new-name kb,kb-local-only-p
get_frame_name get-frame-name string frame kb,kb-local-only-p
put_frame_pretty_name put-frame-pretty-name frame,name kb,kb-local-only-p
get_frame_pretty_name string frame kb,kb-local-only-p
get_frame_in_kb get-frame-in-kb two_values thing kb,error-p,kb-local-only-p
put_instance_types put-instance-types frame,new-types kb,kb-local-only-p
get_slot_value get-slot-value string frame slot
get_class_slot_slotvalue get-class-slot-slotvalue string frame slot
get_class_all_instances get-class-all-instances list - -
get_class_all_subs get-class-all-subs list class
instance_all_instance_of_p instance-all-instance-of-p boolean class
get_class_subclasses get-class-subclasses list class kb,inference-level,number-of-values,kb-local-only-p
get_class_instances get-class-instances list class kb,inference-level,number-of-values,kb-local-only-p
individual_p individual-p boolean thing kb,kb-local-only-p
member_slot_value_p member-slot-value-p boolean frame slot value
put_slot_values put-slot-values - - -
put_slot_value put-slot-value - frame,slot,value
add_slot_value add-slot-value - frame,slot,value
detach_slot detach-slot frame,slot kb,slot-type,value-selector,kb-local-only-p
slot_has_value_p boolean frame,slot kb,inference-level,slot-type,value-selector,kb-local-only-p
get_slot_type get-slot-type string frame,slot kb,inference-level,kb-local-only-p
frame_has_slot_p frame-has-slot-p frame,slot kb,inference-level,slot-type,kb-local-only-p
slot_p slot-p boolean thing kb,inference-level,kb-local-only-p
subclass_of_p boolean subclass,superclass kb,inference-level,kb-local-only-p
superclass_of_p superclass-of-p superclass,subclass kb,inference-level,kb-local-only
type_of_p type-of-p boolean class,frame kb,inference-level,kb-local-only
replace_slot_value replace-slot-value frame,slot,old_value,new_value -
remove_slot_value remove-slot-value frame,slot -
rename_slot rename-slot string slot,new-name kb,kb-local-only-p
coercible_to_frame_p coercible-to-frame-p boolean frame -
class_all_type_of_p class-all-type-of-p boolean frame,instance - 
get_instance_direct_types get-instance-direct-types string frame - 
get_frame_slots get-frame-slots string frame kb,inference-level,slot-type,kb-local-only-p
get_frame_type get-frame-type string thing kb,inference-level,kb-local-only-p
get_frames_matching get-frames-matching list pattern kb,wild-cards-allowed,selector,force-case-insensitive-p,kb-local-only-p
put_instance_types put-instance-types string frame,new_types -
save_kb save-kb - - -
save_kb_as save-kb-as - new-name-or-locator kb
revert_kb revert-kb - - kb
all_pathways all-pathways list - selector,base -
all_orgs all-orgs list - verbose -
all_rxns all-rxns list - type -
genes_of_reaction genes-of-reaction list reaction - 
substrates_of_reaction substrates-of-reaction list reaction -
products_of_reaction products-of-reaction list reaction -
enzymes_of_reaction enzymes-of-reaction list reaction -
reaction_reactants_and_products reaction-reactants-and-products two_values reaction - pathway,direction
get_predecessors get-predecessors list reaction,pathway - -
get_successors get-successors list reactionframe,pathwayframe - 
get_reaction_list get-reaction-list list pathwayframe -
genes_of_pathway genes-of-pathway list pathwayframe - -
enzymes_of_pathway enzymes-of-pathway list pathwayframe -
enzyme_activity_name enzyme-activity-name string enzyme reaction -
compounds_of_pathway compounds-of-pathway list pathway -
all_transcription_factors all-transcription-factors list - - allow-modified-forms?
transcription_factor_p transcription-factor? boolean protein
all_cofactors all-cofactors list - - 
all_modulators all-modulators list - -
monomers_of_protein monomers-of-protein list protein
genes_of_protein genes-of-protein list protein
reactions_of_enzyme reactions-of-enzyme enzyme
enzyme_p enzyme? boolean protein
transporter_p transporter? boolean protein
containers_of containers-of list protein
modified_forms modified-forms list protein
modified_containers modified-containers list protein
top_containers top-containers list protein
reactions_of_protein reactions-of-protein list protein - lists all reactions for a given protein
regulon_of_protein regulon-of-protein list protein
transcription_units_of_protein transcription-units-of-protein list protein
regulator_proteins_of_transcription_unit regulator-proteins-of-transcription-unit list tu
enzymes_of_gene enzymes-of-gene list gene
all_products_of_gene all-products-of-gene list gene
reactions_of_gene reactions-of-gene list gene
pathways_of_gene pathways-of-gene list gene
chromosome_of_gene chromosome-of-gene string gene
transcription_units_of_gene transcription-units-of-gene list gene
transcription_unit_promoter transcription-unit-promoter string tu
transcription_unit_genes transcription-unit-genes list tu
transcription_unit_binding_sites transcription-unit-binding-sites list tu
transcription_unit_transcription_factors transcription-unit-transcription-factors list bsite
transcription_unit_terminators transcription-unit-terminators list tu
all_transported_chemicals all-transported-chemicals list - -
reactions_of_compound reactions-of-compound list compound - 
full_enzyme_name full-enzyme-name string enzyme - 
pwys_of_organism_in_meta pwys-of-organism-in-meta list gb_tax_id -
enzymes_of_organism_in_meta enzymes-of-organism-in-meta list gb_tax_id -
lower_taxa_or_species_p lower-taxa-or-species-p boolean org_frame -
genes_regulating_gene genes-regulating-gene list gene -
genes_regulated_by_gene genes-regulated-by-gene list gene -
terminators_affecting_gene terminators-affecting-gene list gene -
transcription_unit_mrna_binding_sites transcription-unit-mrna-binding-sites list transcription_unit -
transcription_unit_activators transcription-unit-activators list transcription_unit -
transcription_unit_inhibitors transcription-unit-inhibitors list transcription_unit -
containing_tus containing-tus list class -
direct_activators direct-activators list entity -
direct_inhibitors direct-inhibitors list entity -
create_facet create-facet string name,frame,slot - kb,create-p,kb-local-only-p
get_facet_values get-facet-values string frame,slot,facet,value - kb,kb-local-only-p
get_facet_value get-facet-value string frame,slot,facet,value - 
get_frame_with_facet_value get-frame-with-facet-value list frame,slot,facet,value kb,local-only-p,kb-only-p
put_facet_values put-facet-values string frame,slot,facet,values kb,kb-local-only-p
put_facet_value put-facet-value string frame,slot,facet,value kb,kb-local-only-p
add_facet_value add-facet-value string frame,slot,facet,value kb,test,kb-local-only-p
replace_facet_value replace-facet-value string frame,slot,facet,old-value,new-value kb,test,kb-local-only-p
remove_local_facet_values remove-local-facet-values string frame,slot,facet,value kb,kb-local-only-p
member_facet_value_p member-facet-value-p string frame,slot,facet,value kb,test,kb-local-only-p
facet_has_value_p facet-has-value-p string frame,slot,facet kb,kb-local-only-p
facet_p facet-p boolean frame,slot,thing kb,kb-local-only-p
get_slot_facets get-slot-facets list frame,slot kb,local-only-p,kb-local-only-p
mapcar_facet_values mapcar-facet-values string frame,slot,facet,function kb,local-only-p,kb-local-only-p
mapc_facet_values mapc-facet-values string frame,slot,facet,function kb,local-only-p,kb-local-only-p
do_facet_values do-facet-values string var,frame,slot,facet kb,local-only-p,kb-local-only-p
mapcar_slot_facets mapcar-slot-facets list frame,slot,function kb,local-only-p,kb-local-only-p
mapc-slot-facets list frame,slot,function kb,local-only-p,kb-local-only
rename_facet rename-facet string facet,new-name kb,kb-local-only-p
slot_has_facet_p boolean frame,slot,facet kb,inference-level,slot-type,kb-local-only-p
