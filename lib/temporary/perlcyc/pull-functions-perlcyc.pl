#!/usr/bin/perl -w

use strict;

my %functions; 
my ($function_type, $function_name, @arguments);
 
while (<>) {
    if (/^5\.1\.?\d*\s+(.*)$/) {
	$function_type = $1;
	next;
    }
    if (!$function_name && <> =~ /^Description/) {
	chomp ($function_name = $_);
	@arguments = ();
	next;
    }
    if (/^Arguments/) {
	chomp (my $arg = <>);
	until ($arg =~ /^Side-Effects/) {
	    push @arguments, $arg;
	    chomp ($arg = <>);
	}
	next;    
    }
    if (/^Return\sValue\(s\)/) {
	my $return_value = <>;
  	if ($return_value =~ /A\sboolean\svalue\./) {
	    $functions{$function_type}{$function_name}{is_boolean} = 1;
	}

	my @args = ();
	my @opt_args = ();

	for (my $i = 0; $i<$#arguments; $i+=2) {
	    next if ($arguments[$i] =~ /^:/);
	    if ($arguments[$i+1] =~ /Optional/) { 
		$arguments[$i] = '"'.$arguments[$i].'"';
		push @opt_args, $arguments[$i]; 
	    }
	    else { push @args, $arguments[$i] }
	}
	
	@{$functions{$function_type}{$function_name}{args}} = @args;
	@{$functions{$function_type}{$function_name}{opt_args}} = @opt_args;

	$function_name = "";
	next;
    }
}


foreach my $type (sort keys %functions) {
    
    print "# $type\n\n";
    
    foreach my $key (sort keys %{$functions{$type}}) {
	
	my $modified_key = &lisp_to_perl($key);

	my $wrapped_function = "";

	$wrapped_function .= "sub $modified_key {\n";
	$wrapped_function .= "my \$self = shift;\n";

	my @modified_values = ();

	foreach my $value (@{$functions{$type}{$key}{args}}) {
	    my $modified_value = &lisp_to_perl($value);
	    push @modified_values, $modified_value;
	}
	
	foreach my $value (@modified_values) {
	    $wrapped_function .= "my \$$value = shift;\n";
	}
	
	my $optional = "";

	if (@{$functions{$type}{$key}{opt_args}}) {
	    $wrapped_function.= "my \$optional = shift;\n";
	    my $allowed_values = join(',', @{$functions{$type}{$key}{opt_args}});
	    $wrapped_function.= "\$optional = \&parse_opt_args(\$optional, $allowed_values);\n";
	}
		
	$wrapped_function .= 'return $self -> call_func';
	if (defined $functions{$type}{$key}{is_boolean}) { 
	    $wrapped_function .= "_that_returns_boolean";
	}
	
	$wrapped_function .= '("'.$key;
	
	foreach my $value (@modified_values) {
	    $wrapped_function .= ' \\\'$'.$value;
	}
        # TODO: $wrapped_function needs to include optional arguments
        # TODO: write &parse_opt_args! will check which arguments are valid and return them in lisp format

	if (@{$functions{$type}{$key}{opt_args}}) {

	}


	$wrapped_function .= '");'."\n}\n\n";

	print $wrapped_function;
    }
}


sub lisp_to_perl {
    my $string = shift;
    
    $string =~ s/-/_/g;
    $string =~ s/\?$/_p/;
    $string =~ s/->/-/;
    
    return $string;
}
