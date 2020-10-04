#!/usr/bin/env perl
# CAESAR CIPHER
my $str = $ARGV[1] || <STDIN> || "hello";
my $key = $ARGV[0] || 3;

foreach my $i (split //, $str)
{
  if( $i =~ /^[a-z]$/ )
  {
    print chr(((ord($i)-ord('a')) + int($key)) % 26 + ord('a'));
  } elsif( $i =~ /^[A-Z]$/ ) {
    print chr(((ord($i)-ord('A')) + int($key)) % 26 + ord('A'));
  } else {
    print $i;
  }
}
print "\n";
