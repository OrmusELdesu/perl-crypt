#!/usr/bin/env perl -w
# A1Z26 CIPHER
use strict;
sub encode 
{
  my ($msg) = @_;
  my $cipher = "";
  for my $i (split //, $msg)
  {
    if( $i =~ /^[a-z]$/ )
    {
      $cipher .= (ord($i)-ord('a') + 1).'-';
    } else {
      chop($cipher);
      $cipher .= $i;
    }
  }
  chop($cipher);
  return $cipher;
}

my $result = encode($ARGV[0]);
print $result."\n";
