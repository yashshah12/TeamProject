#!/usr/bin/perl
use strict;
use warnings;

my $numOfTeams = 3;
my $numOfGames = 3;
my $total;

$total =($numOfTeams*$numOfGames)/2;
my $rounded = int($total + 0.5);

if (0 == $rounded % 2) 
{
    print "The number $rounded is even\n";    # There is no remainder
} 
else 
{    
    print "The number $rounded is odd\n";     # There is a remainder (of 1)
    $rounded = $rounded +1;
}

print ("The even number of games played is: ".$rounded."\n");

#
#Take the first team and make it play every other team, store into 2d array
#	check if home tesm played number of games required for each team, if they didnt, then make the remaining combinations random
#take the second team and first check the database to see how many games that team played, and check if they played all the other teams, then check if they exhausted how many
#games they played.
#keep doing this until the 2d array length is equal to number of gamess needed to play in the season (kushal code)
#