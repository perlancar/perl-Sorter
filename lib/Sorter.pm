## no critic: TestingAndDebugging::RequireUseStrict
package Sorter;

# AUTHORITY
# DATE
# DIST
# VERSION

1;
# ABSTRACT: Sorter

=head1 SPECIFICATION VERSION

0.1


=head1 SYNOPSIS

Basic:

 use Sorter::naturally;
 my $sorter = Sorter::naturally->new;

 my @sorted = $sorter->('track1.mp3', 'track10.mp3', 'track2.mp3', 'track1b.mp3', 'track1a.mp3');
 # => ('track1.mp3', 'track1a.mp3', 'track1b.mp3', 'track2.mp3', 'track10.mp3')

Specifying arguments:

 use Sorter::naturally;
 my $sorter = Sorter::naturally->new(reverse => 1);
 my @sorted = $sorter->(...);


=head1 DESCRIPTION

B<EXPERIMENTAL. SPEC MIGHT STILL CHANGE.>

=head1 Glossary

A B<sorter> is a subroutine that accepts a list of items to sort.

A B<sorter module> is a module under the C<Sorter::*> namespace that you can use
to generate a sorter.

=head2 Writing a Sorter module

 package Sorter::naturally;

 # required. must return a hash (DefHash)
 sub meta {
     return +{
         v => 1,
         args => {
             reverse => {
                 schema => 'bool*', # Sah schema
             },
         },
     };
 }

 sub gen_sorter {
     my %args = @_;
     ...
 }

 1;

=head2 Namespace organization


=head1 SEE ALSO

Base specifications: L<DefHash>, L<Sah>.

Related: L<Comparer>, L<KeyMaker>

Previous incarnation: L<Sort::Sub>. C<Sorter>, C<KeyMaker>, and C<Comparer> are
meant to eventually supersede Sort::Sub. The main improvement upon Sort::Sub is
the split into three: 1) a sorter (a subroutine that accepts a list of items to
sort); 2) a keymaker (a subroutine that converts an item to a string/numeric key
suitable for simple comparison using C<eq> or C<==> during sorting); and 3)
comparer (a subroutine that compares two items that can be used in C<sort()>).
Perl's C<sort()> allows us to specify a comparer, but oftentimes it's more
efficient to sort by key using a keymaker, and sometimes due to preprocessing
and/or postprocessing it's more suitable to use the more generic C<sorter>
interface.
