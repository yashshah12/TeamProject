#!/usr/bin/perl
use strict;
use warnings;
#
#  Use the R Perl module for the ggplot2 graphics
#
use Statistics::R;

#
#  plotHockeyData.pl
#  Author: Deborah Stacey
#  Date of Last Update: Wednesday, January 28, 2015
#  Synopsis: bar plot of hockey game goal differential using R
#

if ($#ARGV != 2 ) {
   print "Usage: plotHockeyData.pl <input data filename> <output PDF filename> <Title in quotes>\n";
   exit;
}

my $in_filename  = $ARGV[0];
my $out_filename = $ARGV[1];
my $title        = $ARGV[2];

# Create a communication bridge with R and start R
my $R = Statistics::R->new();

# Name the PDF output file for the plot  
my $Rplots_file = $out_filename;

# Set up the PDF file for plots
$R->run(qq`pdf("$Rplots_file" , paper="letter")`);

# Load the plotting library
$R->run(q`library(ggplot2)`);

# Read in data from the CSV file named on the command line
$R->run(qq`data <- read.csv("$in_filename")`);

#
# Plot the data as a bar plot using blue for wins and red for losses
#
$R->run(qq`ggplot(data, aes(x=Game, y=Differential)) + 
geom_bar(aes(fill=Performance),stat="identity", binwidth=3) + 
ggtitle("$title") + ylab("Goal Differential") + xlab("Games") + 
scale_fill_manual(values=c("red", "blue")) + 
theme(axis.text.x=element_text(angle=50, size=10, vjust=0.5)) `);

# Close down the PDF device
$R->run(q`dev.off()`);

$R->stop();

#
#  End of the script
#
