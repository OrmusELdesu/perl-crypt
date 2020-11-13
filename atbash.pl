#!/usr/bin/env perl -w
use strict;
use Getopt::Long qw(GetOptions);

my $input;
my $output;
my $result;
my $usage = "Usage: $0 <file> or -i <input file> -o <output file>";
my $error = "Could not open file";

GetOptions(
   'input|i=s' => \$input,
   'output|o=s' => \$output
) or die $usage;

if($input){

   if($output) {
      open (my $fh, ">", $output) or die $error;
      $result = file_encode($input);
      print $fh $result."\n";
      close($fh);
   } else {
      $result = file_encode($input);
      print $result."\n";
   }

} else {

   if($output) {
      open (my $fh, ">", $output) or die $error;
      $result = str_encode($ARGV[0]);
      print $fh $result."\n";
      close($fh);
   } else {
      $result = str_encode($ARGV[0]);
      print $result."\n";
   }

}

sub file_encode
{
   my ($filename) = @_;
   my $output = "";
   open (my $fh, "<:encoding(UTF-8)", $filename) or die;

   while(my $row = <$fh>)
   {
      chomp($row);
      $output .= str_encode($row)."\n";
   }
   chop($output);
   close($fh);
   return $output;
}

sub str_encode
{
   my ($message) = @_;
   my $output = "";
   for my $i (split //, $message)
   {
     if( $i =~ /^[a-z]$/ )
     {
       $output .= chr( ord('a') + ord('z') - ord($i) );
     } elsif ($i =~ /^[A-Z]$/ ){
       $output .=  chr( ord('A') + ord('Z') - ord($i) );
     } else {
       $output .= $i;
     }
   }
   return $output;
}
