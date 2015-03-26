#!/usr/bin/perl
use strict;
use warnings;

#
#  Use the R Perl module for the ggplot2 graphics
#
use Statistics::R;

#
#  Use the multiplot R function to plot multiple plots 
#  on one page

require 'multiplotR.pl';

#
#  hockeyMultiplot.pl
#  Author: Deborah Stacey
#  Date of Last Update: Monday, February 16, 2015
#  Synopsis: plot multiple R (ggplot2) plots on one PDF page
#

if ($#ARGV < 2 ) {
   print "Usage: hockeyMultiplot.pl <any number of input data filenames> <output PDF filename> <number of columns>\n";
   exit;
}

my @in_file;
my $count = $#ARGV - 1;
for ( my $i=0; $i<$count; $i++ ) {
   $in_file[$i]  = $ARGV[$i];
}
my $out_file  = $ARGV[$count];
my $cols      = $ARGV[$count + 1];

my $title = "";

# Create a communication bridge with R and start R
my $R = Statistics::R->new();

# Name the PDF output file for the plot  
my $Rplots_file = $out_file;

# Set up the PDF file for plots
$R->run(qq`pdf("$Rplots_file" , paper="letter")`);

# Load the plotting library
$R->run(q`library(ggplot2)`);

#
# Include the multiplotR definition
#
$R = multiplotR($R);
my $string = "multiplot(";
my $j = 0;

my $size  = 15 - (($cols-1) * 5);

for ( my $i=1; $i<=$count; $i++ ) {
#
#  Create plot
#
   $j = $i - 1;
   $R->run(qq`data <- read.csv("$in_file[$j]")`);
   $title = "$in_file[$j]";

   $R->run(qq`p$i <- ggplot(data, aes(x=Game, y=Differential)) + 
   geom_bar(aes(fill=Performance),stat="identity",binwidth=2) + 
   ggtitle("$title") + ylab("Goal Differential") + xlab("Games") + 

   theme(axis.title.x=element_text(size=$size)) +
   theme(axis.title.y=element_text(size=$size)) +
   theme(plot.title  =element_text(face="bold",size=$size)) + 

   scale_fill_manual(values=c("red", "blue")) + 

   theme(legend.position="none") +

   theme(axis.text.x=element_text(angle=50, size=10, vjust=0.5)) `);

   $string = $string."p".$i.",";
}

$string = $string."cols=".$cols.")";
print "string = ".$string."and size = ".$size."\n";

$R->run(qq`$string`);

# Close down the PDF device
$R->run(q`dev.off()`);

$R->stop();

#
#  End of the script
#
