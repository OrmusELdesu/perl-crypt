#!/usr/bin/env perl
use strict;

my $message = $ARGV[1] || "hello world";
my $keycode = $ARGV[2] || "lemons";

# enc: c = p + k % 26;
# dec: p = c - k % 26;
sub encode
{
  my ($text, $key) = @_;
  my $p = 0; my $k = 0;
  my $cipher;
  $key = $key x (length($text) / length($key) + 1);

  for( my ($i, $j) = 0 x 2; $i < length($text); $i++, $j++ )
  {
    $p = ord( lc(substr($text, $i, 1)) ) - ord('a');
    $k = ord( lc(substr($key, $j, 1)) ) - ord('a');
    if( substr($text, $i, 1) =~ /^[a-zA-Z]$/ ){
      $cipher .= chr( ($p + $k) % 26 + ord('a') );
    } else {
      $j--;
      $cipher .= chr( $p + ord('a') );
    }
  }
  return $cipher;
}

sub decode
{
  my ($text, $key) = @_;
  my $p = 0; my $k = 0;
  my $cipher;
  $key = $key x (length($text) / length($key) + 1);

  for( my ($i, $j) = 0 x 2; $i < length($text); $i++, $j++ )
  {
    $p = ord( lc(substr($text, $i, 1)) ) - ord('a');
    $k = ord( lc(substr($key, $j, 1)) ) - ord('a');
    if( substr($text, $i, 1) =~ /^[a-zA-Z]$/ ){
      $cipher .= chr( ($p - $k) % 26 + ord('a') );
    } else {
      $j--;
      $cipher .= chr( $p + ord('a') );
    }
  }
  return $cipher;
}

my $encoded = encode($message, $keycode);
my $decoded = decode($message, $keycode);

if( $ARGV[0] == "-e" ){
  print "encryption\n";
} else {
  print "decryption\n";
}
