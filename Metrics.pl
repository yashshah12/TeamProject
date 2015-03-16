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
	getGoalsOfTeams($teamName,$teamYear);
	for ($i = 1;$i<=$numOpponents;$i++) {
		print "Opponent:".$i."-".$opponents[$i-1][1].$opponents[$i-1][0]."\n";
		getGoalsOfTeams($opponents[$i-1][0],$opponents[$i-1][1]);
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

close ($leagueFH);
#print $team." Goals \n";
my $j = 0;
for ($j = 0;$j<$i;$j++) {
	print $goals[$j]."\n";
}



}

