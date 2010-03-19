#!/usr/bin/perl -w

use strict;

my %functions;
my ($function_type,$function_name,@arguments);
 
while (<>) {
    if (/^5\.1\.?\d*\s+(.*)$/) {
	$function_type = $1;
#	print "$function_type\n";
	next;
    }
    if (!$function_name && <> =~ /^Description/) {
	chomp ($function_name = $_);
#	print "$function_name\n";
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
#	    $functions{$function_name}{is_boolean} = 1;
	}
	my @argument_names;
	for (my $i = 0; $i<$#arguments; $i+=2) {
	    next if ($arguments[$i] =~ /^:/);
	    next if ($arguments[$i+1] =~ /Optional/);
	    push @argument_names, $arguments[$i];
	}

	@{$functions{$function_type}{$function_name}{args}} = @argument_names;
#	@{$functions{$function_name}{args}} = @argument_names;
	$function_name = "";
	next;
    }
}



foreach my $type (sort keys %functions) {

    print "# $type\n\n";
 
    foreach my $key (sort keys %{$functions{$type}}) {

	my $wrapped_function = "";

	my $modified_key = $key;
	$modified_key =~ s/-/_/g;
	$modified_key =~ s/\?$/_p/;
	$modified_key =~ s/->/-/;

	$wrapped_function .= "sub $modified_key {\n";
	$wrapped_function .= "my \$self = shift;\n";
	my @modified_values = ();
	
	foreach my $value (@{$functions{$type}{$key}{args}}) {
	    my $modified_value = $value;
	    $modified_value =~ s/-/_/g;
	    $modified_value =~ s/\?$/_p/;
	    push @modified_values, $modified_value;
	}
	
	foreach my $value (@modified_values) {
	    $wrapped_function .= "my \$$value = shift;\n";
	}
	
	$wrapped_function .= 'return $self -> call_func';
	if (defined $functions{$type}{$key}{is_boolean}) { 
	    $wrapped_function .= "_that_returns_boolean";
	}
	
	$wrapped_function .= '("'.$key;
	
	foreach my $value (@modified_values) {
	    $wrapped_function .= ' \\\'$'.$value;
	}
	$wrapped_function .= '");'."\n}\n\n";

	print $wrapped_function;
    }
}
