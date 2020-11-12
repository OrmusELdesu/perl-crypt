#!/usr/bin/env perl -w
# A1Z26 CIPHER
use strict;

#import module for parameter processing
use Getopt::Long qw(GetOptions);

#enable gnu_getopt for combined flags
Getopt::Long::Configure qw(gnu_getopt);

my $encrypt;
my $decrypt;
my $input;
my $output;

GetOptions(
   'encrypt|e' => \$encrypt,
   'decrypt|d' => \$decrypt,
   'input|i=s'  => \$input,
   'output|o=s'  => \$output
) or die "Usage: $0 [--encrypt|-e, --decrypt|-d] [--input | -i <file>] [--output | -o <file>] <string>";

my $result;

if($encrypt) {
   if($input) {
      if($output){ #input and output file is specified

         # handle enciphered message file output
         open (my $fh, '>', $output) or die "Could not open file '$output' $!";
         $result = file_encode($input);
         print $fh $result."\n";
         close($fh);

      } else { #input file specified, output file not specified.

         $result = file_encode($input);
         print $result."\n";

      }
   } else { #neither input nor output specified, single string
      $result = str_encode($ARGV[0]);
      print $result."\n";
   }
} elsif($decrypt) {
   if($input) {
      if($output){
         # handle deciphered message file output
         open (my $fh, '>', $output) or die "Could not open file '$output' $!";
         $result = file_decode($input);
         print $fh $result."\n";
         close($fh);


      } else {
         $result = file_decode($input);
         print $result."\n";
      }
   } else  {
      $result = str_decode($ARGV[0]);
      print $result."\n";
   }
}

sub file_encode
{
   my ($filename) = @_;
   my $fe_result = "";
   open (my $fh, '<:encoding(UTF-8)', $filename) or die "Could not open file '$filename' $!";

   while(my $row = <$fh>) 
   {
      chomp $row;
      $fe_result .= str_encode($row)."\n";
   }
   chop($fe_result);
   close($fh);
   return $fe_result;
}

sub file_decode
{
   my ($filename) = @_;
   my $fd_result = "";
   open (my $fh, '<:encoding(UTF-8)', $filename) or die "Could not open file '$filename' $!";

   while(my $row = <$fh>) 
   {
      chomp $row;
      $fd_result .= str_decode($row)."\n";
   }
   chop($fd_result);
   close($fh);
   return $fd_result;
}

sub str_encode 
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

sub str_decode
{
   my ($cipher) = @_;
   my $msg = "";
   for my $i (split /\s/, $cipher)
   {
      for my $j (split /-/, $i)
      {
         if( $i =~ /(\d+)/ )
         {
            $msg .= chr(int($j - 1 + ord('a')));
         } 
      }
      $msg .= " ";
   }
   chop($msg);
   return $msg;
}

