#!/usr/bin/env perl -w
use strict;

sub gcd
{
  my ($a, $b) = @_;
  if($b == 0){
    return $a
  }
  return gcd($b, $a % $b);
}

my $result = gcd($ARGV[0], $ARGV[1]);
print $result."\n";
