#!perl

# test request sub

use 5.010;
use strict;
use warnings;
use Test::More 0.98;

require Sort::Sub;

# importing a sub
{
    no strict 'subs';
    Sort::Sub->import(qw(naturally<i>));
    is_deeply([sort {&naturally} qw(t1.mp3 T10.mp3 t2.mp3)], [qw/t1.mp3 t2.mp3 T10.mp3/]);
}

# importing a variable
our $naturally;
{
    Sort::Sub->import('$naturally<i>');
    is_deeply([sort $naturally qw(t1.mp3 T10.mp3 t2.mp3)], [qw/t1.mp3 t2.mp3 T10.mp3/]);
}

# functional interface
{
    my $sorter = Sort::Sub::get_sorter('$naturally<i>');
    is_deeply([sort $sorter qw(t1.mp3 T10.mp3 t2.mp3)], [qw/t1.mp3 t2.mp3 T10.mp3/]);

    ($sorter, my $meta) = Sort::Sub::get_sorter('$by_rand', {}, "with meta");
    is_deeply($meta, {v=>1, summary => "Sort randomly using Perl's rand()"});
}

done_testing;
