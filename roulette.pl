#!/usr/bin/perl
use strict;
use warnings;

use Text::CSV;
my $csvLeague   = Text::CSV->new({ sep_char => ',' });

my $team;
my $visitor;
my $home;
my $visitorG;
my $homeG;
my @goals;
my $i = 0;
my $leagueFName = "OtherData/2000/results.csv";
print $leagueFName." for 2000 Toronto Maple Leafs: \n";

open my $leagueFH, '<', $leagueFName
	or die "Unable to open leagues file: $leagueFName";     

my $leagueRecord = <$leagueFH>;
while ( $leagueRecord = <$leagueFH> ) {
   chomp ( $leagueRecord );
   if ( $csvLeague->parse($leagueRecord) ) {
      my @leagueFields = $csvLeague->fields();
	 $team = "Toronto Maple Leafs";
         $visitor = $leagueFields[1];
         $home = $leagueFields[4];
         
         if ($team eq $visitor) {
            $visitorG = $leagueFields[3];
            #if($visitorG =~ /^[0-9,.E]+$/ ) {
               $goals[$i] = $visitorG;
               $i++;
            #}
            
         } 
 
         if ($team eq $home) {
            $homeG = $leagueFields[6];
            #if($homeG =~ /^[0-9,.E]+$/ ) {
               $goals[$i] = $homeG;
               $i++;
           # }
           
         } 
         
   } else {
      warn "Line could not be parsed: $leagueRecord\n";
   }
}
#print "I is: ".$i."\n";

close ($leagueFH);

my $j = 0;
for ($j = 0;$j<$i;$j++) 
{
	print $goals[$j]."\n";
}

my $k = $i-1;
my @goalScored = @goals[0..$k];
my @rWheel;
   
   for (1 .. 10)
   {    #This line of code below assigns/pushes 10 random elements from goalScored to rWheel by 1
      push @rWheel, splice @goalScored, rand @goalScored, 1;
   }
   
   my @sortedWheel = sort { $a <=> $b } @rWheel; #Sorting in numerical order
   print ("Roulette Line: ");
   print join(", ", @sortedWheel);
   print ("\n");
   my @group = ( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 );
   my $range = 10;
   for ( my $i=0; $i<10; $i++ ) 
   {
      if ( $sortedWheel[$i] eq 0) 
      {
         $group[0]++;
      } 
      elsif ( $sortedWheel[$i] eq 1 ) 
      {
         $group[1]++;
      } 
      elsif ( $sortedWheel[$i] eq 2 ) 
      {
         $group[2]++;
      } 
      elsif ( $sortedWheel[$i] eq 3 ) 
      {
         $group[3]++;
      } 
      elsif ( $sortedWheel[$i] eq 4 ) 
      {
         $group[4]++;
      }
      elsif ( $sortedWheel[$i] eq 5 ) 
      {
         $group[5]++;
      }
      elsif ( $sortedWheel[$i] eq 6 ) 
      {
         $group[6]++;
      }
      elsif ( $sortedWheel[$i] eq 7 ) 
      {
         $group[7]++;
      }
      elsif ( $sortedWheel[$i] eq 8 ) 
      {
         $group[8]++;
      }
      elsif ( $sortedWheel[$i] eq 9 ) 
      {
         $group[9]++;
      } 
      else
      {
         $group[10]++;
      }
   }
   my $p;
   for ($p=0; $p<10; $p++) 
   {
      print ("Amount of times ".$p." goal(s) was scored: ".$group[$p]. "--> ".($group[$p]*10)."% \n");
   }
   print ("Amount of times 10 or more goals was scored: ".$group[10]. "--> ".($group[10]*10)."% \n");