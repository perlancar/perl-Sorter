## no critic: TestingAndDebugging::RequireUseStrict
package Sorter;

# AUTHORITY
# DATE
# DIST
# VERSION

1;
# ABSTRACT: Reusable sorter subroutines

=head1 SPECIFICATION VERSION

0.1


=head1 SYNOPSIS

Basic:

 use Sorter::naturally;
 my $sorter = Sorter::naturally::gen_sorter;

 my @sorted = $sorter->('track1.mp3', 'track10.mp3', 'track2.mp3', 'track1b.mp3', 'track1a.mp3');
 # => ('track1.mp3', 'track1a.mp3', 'track1b.mp3', 'track2.mp3', 'track10.mp3')

Specifying arguments:

 use Sorter::naturally;
 my $sorter = Sorter::naturally::gen_sorter(reverse => 1);
 my @sorted = $sorter->(...);

Specifying sorter on the command-line (for other CLI's):

 % customsort -s naturally ...
 % customsort -s naturally=reverse,1 ...


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

=head2 Base specifications

L<DefHash>

L<Sah>

=head2 Related specifications

L<Comparer>

L<SortKey>

=head2 Previous incarnation

L<Sort::Sub>

C<Sorter>, C<SortKey>, and C<Comparer> are meant to eventually supersede
Sort::Sub. The main improvement over Sort::Sub is the split into three kinds of
subroutines:

=over

=item 1. sorter

A subroutine that accepts a list of items to sort.

C<Sorter::*> modules are meant to generate sorters.

=item 2. sort key generator

A subroutine that converts an item to a string/numeric key suitable for simple
comparison using C<eq> or C<==> during sorting.

C<SortKey::*> modules are meant to generate sort key generators.

=item 3. comparer

A subroutine that compares two items. Can be used in C<sort()> as custom sort
block.

C<Comparer::*> modules are meant to generate comparers.

Perl's C<sort()>, as mentioned above, allows us to specify a comparer, but
oftentimes it's more efficient to sort by key using key generator, where the
keys are often cached. And sometimes due to preprocessing and/or postprocessing
it's more suitable to use the more generic sorter interface.

=back

Aside from the above, C<Sorter> also makes Sort::Sub's special arguments
C<reverse> and C<is_ci> become ordinary arguments, because they are not always
applicable in all situation, especially C<is_ci>.
