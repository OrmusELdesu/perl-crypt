#!/usr/bin/env perl
# VIGENERE CIPHER
# enc: c = p + k % 26;
# dec: p = c - k % 26;

use strict;

use File::stat;
use Getopt::Long qw(GetOptions);
Getopt::Long::Configure qw(gnu_getopt);

my $encrypt;
my $decrypt;
my $ifile; 
my $ofile;
my $keyword;

GetOptions(
  'encrypt|e'   => \$encrypt,
  'decrypt|d'   => \$decrypt,
  'ifile|i=s'   => \$ifile,
  'ofile|o=s'   => \$ofile,
  'key|k=s'     => \$keyword,
) or die "Usage: $0 [--encrypt|-e, --decrypt|-d] [--input | -i <file>] [--output | -o <file>] [--key | -k <string>] <message>";

my $result;
my $position = 0;

if($encrypt and $keyword) {
  if($ifile) {
    my $size = stat($ifile)->size;

    if($ofile) {
      open (my $fh, '>', $ofile) or die "Could not open file '$ofile' $!";
      $result = file_encode($ifile, $size);
      print $fh $result."\n";
      close($fh);

    } else {
      $result = file_encode($ifile, $size);
      print $result;
    }

  } else {
    $result = str_encode($ARGV[0], $keyword)."\n";
    print $result;
  }

} elsif($decrypt and $keyword) {
  if($ifile) {
    my $size = stat($ifile)->size;

    if($ofile) {

      open (my $fh, '>', $ofile) or die "Could not open file '$ofile' $!";
      $result = file_decode($ifile, $size);
      print $fh $result."\n";
      close($fh);

    } else {
      $result = file_decode($ifile, $size);
      print $result."\n";
    }

  } else {

    $result = str_decode($ARGV[0], $keyword)."\n";
    print $result;

  }
} else {
  print "No key or operation specified!"."\n";
}

sub file_encode 
{
  my ($filename, $filesize) = @_;
  my $fe_result = "";
  open (my $fh, '<:encoding(UTF-8)', $filename) or die "Could not open file '$filename' $!";
  $keyword = $keyword x ($filesize / length($keyword) + 1);

  while(my $row = <$fh>)
  {
    chomp $row;
    $fe_result .= str_encode($row, $keyword)."\n";
  }
  chop($fe_result);
  close($fh);
  return $fe_result;
}

sub file_decode
{
  my ($filename, $filesize) = @_;
  my $fe_result = "";
  my $fe_content = "";
  open (my $fh, '<:encoding(UTF-8)', $filename) or die "Could not open file '$filename' $!";
  $keyword = $keyword x ($filesize / length($keyword) + 1);

  while(my $row = <$fh>)
  {
    chomp $row;
    $fe_result .= str_decode($row, $keyword)."\n";
  }
  chop($fe_result);
  close($fh);
  return $fe_result;
}

sub str_encode
{

  my ($text, $key) = @_;
  my $p = 0; my $k = 0;
  my $cipher;

  for( my ($i, $j) = (0, $position); $i < length($text); $i++, $j++ )
  {
    $p = ord( lc(substr($text, $i, 1)) ) - ord('a');
    $k = ord( lc(substr($key, $j, 1)) ) - ord('a');
    if( substr($text, $i, 1) =~ /^[a-zA-Z]$/ ){
      $cipher .= chr( ($p + $k) % 26 + ord('a') );
    } else {
      $position = $j--;
      $cipher .= chr( $p + ord('a') );
    }
  }
  return $cipher;
}

sub str_decode
{

  my ($text, $key) = @_;
  my $c = 0; my $k = 0;
  my $message;

  for( my ($i, $j) = (0, $position); $i < length($text); $i++, $j++ )
  {
    $c = ord( lc(substr($text, $i, 1)) ) - ord('a');
    $k = ord( lc(substr($key, $j, 1)) ) - ord('a');
    if( substr($text, $i, 1) =~ /^[a-zA-Z]$/ ){
      $message .= chr( ($c - $k) % 26 + ord('a') );
    } else {
      $position = $j--;
      $message .= chr( $c + ord('a') );
    }
  }
  return $message;
}
