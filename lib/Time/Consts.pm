package Time::Consts;

$VERSION = 0.01;

use strict;
use Carp;

my %ok = map { $_ => 1 } qw/
	MSEC
	SEC
	MIN
	HOUR
	DAY
	WEEK
/;

my %secs = (
	MSEC => 1,
	SEC  => 1000 * 1,
	MIN  => 1000 * 60,
	HOUR => 1000 * 60 * 60,
	DAY  => 1000 * 60 * 60 * 24,
	WEEK => 1000 * 60 * 60 * 24 * 7,
);

sub import {
	shift;

	return unless @_;

	my @args = @_;

	if (my (@bad) = grep !$ok{+uc} && $_ ne ':ALL' => @args) {
		croak('Bad argument(s): ' . join ', ' => @bad);
	}

	my @unit = grep $_ eq lc, @args;
	croak("Too many units: @unit") if @unit > 1;
	push @unit => 'sec';
	my $unit = $secs{uc $unit[0]};
	
	my @consts = keys %{{
		map { $_ => 1 }
		map { $_ eq ':ALL' ? keys %ok : $_ }
		grep { $_ eq uc }
		@args
	}};

	my $pkg = caller;

	for (@consts) {
		my $t = $secs{$_} / $unit;

		no strict 'refs';
		*{"$pkg\::$_"} = sub () { $t };
	}
}

1;

=head1 NAME

Time::Consts - Define time constants with specified base


=head1 SYNOPSIS

    # Import all constants.
    use Time::Consts qw/ :ALL /; 

    # Import just MIN and HOUR
    use Time::Consts qw/ MIN HOUR /;

    # Set MIN to base, i.e. MIN = 1, SEC = 1/60, etc.
    use Time::Consts qw/ min SEC MIN /;

=head1 DESCRIPTION

C<Time::Consts> can define time constants for you. Those available are

    MSEC
    SEC
    MIN
    HOUR
    DAY
    WEEK

and are provided as arguments to the C<use()> statements. An ':ALL' tag is provided to export all of the above. Default base is seconds, but that can be changed by supplying a lowercase version of any of the constants to the C<use> statement. Note that giving a lowercase base doesn't mean that the corresponding constant automatically will be defined.

If you at any time would want to have any of the constants in another base than the one given to the C<use()> statement just divide with that constant. E.g. C<WEEK / HOUR> will always return 168, i.e. the number of hours per week.


=head1 DIAGNOSTICS

=over

=item Bad argument(s): %s

(F) Self-explanatory.

=item Too many units: %s

(F) Self-explanatory.

=back


=head1 AUTHOR

Johan Lodin <lodin@gfs.gu.se>


=head1 COPYRIGHT

Copyright 2004 Johan Lodin. All rights reserved.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.


=head1 SEE ALSO

L<Time::Seconds>


=cut
