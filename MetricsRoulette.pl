#!/usr/bin/perl
use strict;
use warnings;

	use Text::CSV;
	my $csvTeams   = Text::CSV->new({ sep_char => ',' });
	my @teams;
	my $teamChoice;
	my $userChoice = 0;	
	my $year;
	my $numOpponents;
	my $i = 0;
	my $teamName;
	my $teamYear;
	my @goalScoredUser;
	my @goalScoredOpp;
	my @opponents;
	print "What year will you like to choose (Ex. 1920 not 1920-1921)\n";
	chomp ($teamYear = <>);
	$teamName = chooseTeamFromYear($teamYear);
	print "User Selected: ".$teamYear.$teamName."\n";
	
	print "How many teams do you want to face again\n";
	chomp ($numOpponents = <>);
	print $numOpponents;
	for ($i = 1;$i<=$numOpponents;$i++) {
		print "What year will you like to choose (Ex. 1920 not 1920-1921)\n";
		chomp ($year = <>);
		$opponents[$i-1][0] = chooseTeamFromYear($year);
		$opponents[$i-1][1] = $year;
		#print "Opponent:".$i."-".$opponents[$i-1][1].$opponents[$i-1][0]."\n";
	}
	print "Teams Chosen\n";
	print "User Selected: ".$teamYear.$teamName."\n";
	@goalScoredUser = getGoalsOfTeams($teamName,$teamYear);
	#print join(", ", @goalScoredUser);
	rouletteWheel(@goalScoredUser);
	for ($i = 1;$i<=$numOpponents;$i++) {
		print "Opponent:".$i." - ".$opponents[$i-1][1].$opponents[$i-1][0]."\n";
		@goalScoredOpp = getGoalsOfTeams($opponents[$i-1][0],$opponents[$i-1][1]);
		#print join(", ", @goalScoredOpp);
		rouletteWheel(@goalScoredOpp);
	}
		
	
sub chooseTeamFromYear {
	my ($year) = @_;
	use Text::CSV;
	my $csvTeams   = Text::CSV->new({ sep_char => ',' });
	my @teams;
	my $teamChoice;
	my $userChoice = 0;	

		
	my $teamsFName   = "OtherData/".$year."/teams.csv";
	print $teamsFName."\n";
	open my $teamsFH, '<', $teamsFName
		or die "Unable to open teams file: $teamsFName";
	
	
	my $teamRecord = <$teamsFH>;
	my $i = 0;
	while ( $teamRecord = <$teamsFH> ) {
	   chomp ( $teamRecord );	
	   if ( $csvTeams->parse($teamRecord) ) {
	      my @teamFields = $csvTeams->fields();
	      $teams[$i] = $teamFields[1];
	      print $teams[$i]."(".($i+1).")\n";

	   } else {
	      warn "Line/record could not be parsed: $teamRecord\n";
	   }
	   $i++;
	}
	close ($teamsFH);
	$userChoice = 0;
	do {
		print "What team will you like to choose (ex. For Hamilton Tigers, press 1):\n";
		chomp ($userChoice = <>);
		if($userChoice <1 || $userChoice >(@teams)) {
			print "Incorrect Input"."\n";
		}
	} while ($userChoice < 1 || $userChoice >(@teams));
	#print "User Selected: ".$userChoice."-".$teams[$userChoice-1]."\n";

	$teamChoice = $teams[$userChoice-1];
	#print "User Selected: ".$userChoice."-".$teamChoice."\n";

	return $teamChoice;
	
}

sub getGoalsOfTeams {
my ($team, $year) = @_;

use Text::CSV;
my $csvLeague   = Text::CSV->new({ sep_char => ',' });

my $visitor;
my $home;
my $visitorG;
my $homeG;
my @goals;
my $i = 0;
my $leagueFName = "OtherData/".$year."/results.csv";
print $leagueFName."\n";

open my $leagueFH, '<', $leagueFName
	or die "Unable to open leagues file: $leagueFName";     

my $leagueRecord = <$leagueFH>;
while ( $leagueRecord = <$leagueFH> ) {
   chomp ( $leagueRecord );
   if ( $csvLeague->parse($leagueRecord) ) {
      my @leagueFields = $csvLeague->fields();
         $visitor = $leagueFields[1];
         
         if ($team eq $visitor) {
            $visitorG = $leagueFields[3];
            #if($visitorG =~ /^[0-9,.E]+$/ ) {
               $goals[$i] = $visitorG;
               $i++;
            #}
            
         } 
         $home = $leagueFields[4];
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
#print $team." Goals \n";
my $j = 0;
for ($j = 0;$j<$i;$j++) 
{
	print $goals[$j]."\n";
}
my $k = $i-1;
my @goalScored = @goals[0..$k];
#print join(", ", @goalScored);
return @goalScored;

}

sub rouletteWheel {
   
   my (@goalScored) = @_;
   my @rWheel;
   
   for (1 .. 10)
   {    #This line of code below assigns/pushes 10 random elements from goalScored to rWheel by 1
      push @rWheel, splice @goalScored, rand @goalScored, 1;
   }
   
   my @sortedWheel = sort { $a <=> $b } @rWheel; #Sorting in numerical order
   print join(", ", @sortedWheel);
   print ("\n");
   my @group = ( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 );
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
   my $k;
   for ($k=0; $k<10; $k++) 
   {
      print ("Amount of times ".$k." goal(s) was scored: ".$group[$k]. "--> ".($group[$k]*10)."% \n");
   }
   print ("Amount of times 10 or more goals was scored: ".$group[10]. "--> ".($group[10]*10)."% \n");
   
   #
   #YASH PLEASE READ: For roulette wheel if there are more than 10 goals scored, then it shows up as 10 goals scored,
   #    so I was thinking that since the team scored 10 or more goals, it could be used as a metric itself.
   #For example if a team scores 12 and 10 goals in the same roulette line, then it would count as one roulette 
   #    percentage. Meaning they have a 20% chance of scoring 10 goals. This makes sense because that would mean
   #    the team is very good (since they scored 10+ goals) and could count as an additional metric. 
   #    Let me know what you think!
   #
   

}

