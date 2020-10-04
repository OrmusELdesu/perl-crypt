#!/usr/bin/env perl -w
use strict;
# ATBASH
my $str = $ARGV[0] || <STDIN> || "hello world";

for my $i (split //, $str)
{
  if( $i =~ /^[a-z]$/ )
  {
    print chr( ord('a') + ord('z') - ord($i) );
  } elsif ($i =~ /^[A-Z]$/ ){
    print chr( ord('A') + ord('Z') - ord($i) );
  } else {
    print $i;
  }
}
print "\n";
  

