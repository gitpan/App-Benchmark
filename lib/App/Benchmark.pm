use 5.008;
use strict;
use warnings;

package App::Benchmark;
our $VERSION = '1.100870';
# ABSTRACT: Output your benchmarks as test diagnostics

use Test::More;
use Benchmark qw(cmpthese timethese :hireswallclock);
use Capture::Tiny qw(capture);
use Exporter qw(import);
our @EXPORT = ('benchmark_diag');

sub benchmark_diag {
    my ($iterations, $benchmark_hash) = @_;
    my $stdout = capture {
        cmpthese(timethese($iterations, $benchmark_hash));
    };
    note $stdout;
    plan tests => 1;
    pass('benchmark');
}
1;


__END__
=pod

=head1 NAME

App::Benchmark - Output your benchmarks as test diagnostics

=head1 VERSION

version 1.100870

=head1 SYNOPSIS

    # This is t/benchmark.t:

    use App::Benchmark;

    benchmark_diag(2_000_000, {
        sqrt => sub { sqrt(2) },
        log  => sub { log(2) },
    });

=head1 DESCRIPTION

This module makes it easy to run your benchmarks in a distribution's test
suite. This way you just have to look at the CPAN testers reports to see your
benchmarks being run on many different platforms using many different versions
of perl.

Ricardo Signes came up with the idea.

=head1 FUNCTIONS

=head2 benchmark_diag

Takes a number of iterations and a benchmark definition hash, just like
C<timethese()> from the L<Benchmark> module. Runs the benchmarks and reports
them, each line prefixed by a hash sign so it doesn't mess up the TAP output.
Also, a dummy test is being generated to keep the testing framework happy.

This function is exported automatically.

=head1 INSTALLATION

See perlmodinstall for information and options on installing Perl modules.

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests through the web interface at
L<http://rt.cpan.org/Public/Dist/Display.html?Name=App-Benchmark>.

=head1 AVAILABILITY

The latest version of this module is available from the Comprehensive Perl
Archive Network (CPAN). Visit L<http://www.perl.com/CPAN/> to find a CPAN
site near you, or see
L<http://search.cpan.org/dist/App-Benchmark/>.

The development version lives at
L<http://github.com/hanekomu/App-Benchmark/>.
Instead of sending patches, please fork this project using the standard git
and github infrastructure.

=head1 AUTHOR

  Marcel Gruenauer <marcel@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2008 by Marcel Gruenauer.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

