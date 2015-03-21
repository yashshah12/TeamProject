#!/usr/bin/perl
use strict;
use warnings;

	use Text::CSV;
	my $csvTeams   = Text::CSV->new({ sep_char => ',' });
	my @teamsGame; #A 2d Array that will store all the teamname and the years
	my $numTeams;
	
	my $gamesToPlay;
	my @gamesSchedule; #A 2D array that will hold the schedule based on team number.Ex. Team 3 Vs Team 2- the number corresponds to elements in the @teamsGame array
	my $teamChoice;
	my $userChoice = 0;	
	my $year;
	my $numOpponents;
	my $i = 0;
	my $teamName;
	my $teamYear;
	my $randTeam1;
	my $randTeam2;
	my $homeTeam;
	my $homeTeamYear;
	my $visitorTeam;
	my $visitorTeamYear;
	                                                    
	                                                     
	
	print "What year will you like to choose (Ex. 1920 not 1920-1921)\n";
	chomp ($teamYear = <>);
	$teamName = chooseTeamFromYear($teamYear);
	
	$teamsGame[0][0] = $teamName;
	$teamsGame[0][1] = $teamYear;
	$numTeams = 1;
	# print "User Selected: ".$teamsGame[0][1]."-".$teamsGame[0][0]."\n";
	
	print "How many teams do you want to face again\n";
	chomp ($numOpponents = <>);
	$numTeams+=$numOpponents;
	print $numOpponents;
	for ($i = 1;$i<=$numOpponents;$i++) {
		print "Opponent:".$i."- What year will you like to choose (Ex. 1920 not 1920-1921)\n";
		chomp ($year = <>);
		$teamsGame[$i][0] = chooseTeamFromYear($year);
		$teamsGame[$i][1] = $year;
		# print "Opponent ".$i.":".$teamsGame[$i][1]."-".$teamsGame[$i][0]."\n";
	}
	print "\n";
	print "User Selected: ".$teamsGame[0][1]."-".$teamsGame[0][0]."\n";
        for ($i = 1; $i<=$#teamsGame;$i++) {
        	print "Opponent ".$i.":".$teamsGame[$i][1]."-".$teamsGame[$i][0]."\n";
	}
	print "How many games do you want to play:\n";
	chomp ($gamesToPlay = <>);
	print "Games In Season: ".$gamesToPlay."\n";
        print "Total teams: ".$numTeams."\n"; #Total teams in the fantasy league
	
	#Make a random schdule
	for ($i = 1; $i<=$gamesToPlay; $i++) {
		$randTeam1 = int(rand($numTeams)) + 1; #Choose a random team between 1 and the number of teams we have
                $randTeam2 = int(rand($numTeams)) + 1; #Choose a random team between 1 and the number of teams we have
		while ($randTeam1 ==$randTeam2) {
			$randTeam1 = int(rand($numTeams)) + 1; #Choose a random team between 1 and the number of teams we have
                        $randTeam2 = int(rand($numTeams)) + 1; #Choose a random team between 1 and the number of teams we have
		}
		$gamesSchedule[$i-1][0] = $randTeam1;
		$gamesSchedule[$i-1][1] = $randTeam2;
                # print $randTeam1." - ".$randTeam2."\n";
	}
	for ($i = 0;$i<=$#gamesSchedule;$i++) {
                  print $gamesSchedule[$i][0]."VS".$gamesSchedule[$i][1]."\n";
	}
	my $team1 = $gamesSchedule[0][0]; #Just doing 1 matchup to see if metrics work. Choose the first matchup and store the number into variables
	my $team2 = $gamesSchedule[0][1];
	#Since $team1 and $team2 are numbers that correspond to elements of the teams array, we just subtract it by 1 since elements start with 0 
	$homeTeam = $teamsGame[$team1-1][0];
	$homeTeamYear = $teamsGame[$team1-1][1];
	$visitorTeam = $teamsGame[$team2-1][0];
	$visitorTeamYear = $teamsGame[$team2-1][1];
	
	findScore($homeTeam,$homeTeamYear,$visitorTeam,$visitorTeamYear);	
	# print "Teams Chosen\n";
	# print "User Selected: ".$teamYear.$teamName."\n";
	# # getGoalsOfTeams($teamName,$teamYear);
	# for ($i = 1;$i<=$numOpponents;$i++) {
		# print "Opponent:".$i."-".$opponents[$i-1][1].$opponents[$i-1][0]."\n";
		# # getGoalsOfTeams($opponents[$i-1][0],$opponents[$i-1][1]);
	# }
	

sub findScore {
	#just printing out who plays with who; Just hardcoded 1 matchup
        my ($homeTeam,$homeTeamYear,$visitorTeam,$visitorTeamYear) = @_;
        print "Finding Scores Now\n";
        print $homeTeamYear." ".$homeTeam." VS ".$visitorTeamYear." ".$visitorTeam."\n";
        
        my @goalsHome; 
        my @goalsAway;
        my $avgGoalsScoredForHome;
        my $avgGoalsScoredForAway;
        my $avgGoalsScoredAgainstHome;
        my $avgGoalsScoredAgainstAway;
        
        #METRICS VARIABLES
        my $metricGoalsForA;
        my $metricGoalsAgainstA;
        my $metricGoalsForB;
        my $metricGoalsAgainstB;
        my $metricTotalA;
        my $metricTotalB;
        
        my $totalHomeGoals;
        my $totalVisitorGoals;
        my $totalGoalsHomeLeague;
        my $totalGoalsAwayLeague;

        
        # @goalsHome =  @{getGoalsOfTeams($homeTeam,$homeTeamYear)};
        # @goalsAway = @{getGoalsOfTeams($visitorTeam,$visitorTeamYear)};
        
        # #printing out goals for home team
        # print $homeTeamYear."-".$homeTeam." Goals\n";
        # for (my $j = 0; $j<=$#goalsHome ;$j++) {
               # print $goalsHome[$j]."\n";
               # $totalHomeGoals+=$goalsHome[$j];
        # }
        # print $homeTeamYear."-".$homeTeam." Total Goals: ".$totalHomeGoals."\n";
        
        # #printing out goals for away team
        # print $visitorTeamYear."-".$visitorTeam." Goals\n";
        # for (my $j = 0; $j<=$#goalsAway ;$j++) {
               # print $goalsAway[$j]."\n";
               # $totalVisitorGoals+=$goalsAway[$j];
        # }
        # print $visitorTeamYear."-".$visitorTeam." Total Goals: ".$totalVisitorGoals."\n";
        
        @goalsHome = @{getGoalsForAgainst($homeTeam,$homeTeamYear)};
        @goalsAway = @{getGoalsForAgainst($visitorTeam,$visitorTeamYear)};
        print $homeTeamYear."-".$homeTeam." Total Goals Scored For: ".$goalsHome[0]."\n";
        print $homeTeamYear."-".$homeTeam." Total Goals Scored Against: ".$goalsHome[1]."\n";
        print "Average Goals Scored for  in the ".$homeTeamYear." league = ".$goalsHome[2]."\n";

        print $visitorTeamYear."-".$visitorTeam." Total Goals Scored For: ".$goalsAway[0]."\n";
        print $visitorTeamYear."-".$visitorTeam." Total Goals Scored Against: ".$goalsAway[1]."\n";
        print "Average Goals Scored for in the ".$visitorTeamYear." league = ".$goalsAway[2]."\n";
        
        
       $avgGoalsScoredForHome = $goalsHome[0] / $goalsHome[2];
       # print $avgGoalsScoredForHome;
       $avgGoalsScoredAgainstHome = $goalsHome[1] / $goalsHome[2];
       # print $avgGoalsScoredAgainstHome;
       $avgGoalsScoredForAway = $goalsHome[0] / $goalsHome[2];
       # print $avgGoalsScoredForAway;
       $avgGoalsScoredAgainstAway = $goalsHome[1] / $goalsHome[2];
       # print $avgGoalsScoredAgainstAway;

        print "----METRICS----\n";
        $metricGoalsForA = $avgGoalsScoredForHome / $avgGoalsScoredForAway; #its not dividing properly
        $metricGoalsAgainstA = $avgGoalsScoredAgainstHome / $avgGoalsScoredAgainstAway;
        #Since the greater the metricGoalsAgainstA, the worst, so divide $metricGoalsAgainstA by 0.50
        $metricGoalsAgainstA = 0.50 / $metricGoalsAgainstA;
         
        print "Goals Scored For A: ".$metricGoalsForA."\n";
        print "Goals Scored Against A: ".$metricGoalsAgainstA."\n";
        
        $metricGoalsForB = $avgGoalsScoredForAway / $avgGoalsScoredForHome;
        $metricGoalsAgainstB = $avgGoalsScoredAgainstAway / $avgGoalsScoredAgainstHome;
        #Since the greater the metricGoalsAgainstA, the worst, so divide $metricGoalsAgainstA by 0.50
        $metricGoalsAgainstB = 0.50 / $metricGoalsAgainstB;
        print "Goals Scored For B: ".$metricGoalsForB."\n";
        print "Goals Scored Against B: ".$metricGoalsAgainstB."\n";
        
        $metricTotalA = $metricGoalsForA + $metricGoalsAgainstA;
        $metricTotalB = $metricGoalsForB + $metricGoalsAgainstB;
        print "Total Metrics Multiplier A: ".$metricTotalA."\n";
        print "Total Metrics Multiplier B: ".$metricTotalB."\n";
        
        
        
        
}

sub AverageGoalsInLeague {
         my ($year) = @_;
         use Text::CSV;
         my $csvLeague   = Text::CSV->new({ sep_char => ',' });
     
         my $totalGoals;
         my $totalTeams;
         my $AverageGoals;
         my $leagueFName = "OtherData/".$year."/teams.csv";
         print $leagueFName."\n";

         open my $leagueFH, '<', $leagueFName
                 or die "Unable to open leagues file: $leagueFName";     

         my $leagueRecord = <$leagueFH>;
         while ( $leagueRecord = <$leagueFH> ) {
            chomp ( $leagueRecord );
            if ( $csvLeague->parse($leagueRecord) ) {
               my @leagueFields = $csvLeague->fields();
                  $totalTeams = $leagueFields[0];
                  $totalGoals+= $leagueFields[9];
                  
                  
            } else {
               warn "Line could not be parsed: $leagueRecord\n";
            }
         }
         
         close ($leagueFH);
         $AverageGoals = $totalGoals/$totalTeams;
         return $AverageGoals;
   
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
sub getGoalsForAgainst{
         my ($team, $year) = @_;
         use Text::CSV;
         my $csvLeague   = Text::CSV->new({ sep_char => ',' });
         my $goalsScoredFor;
         my $goalsScoredAgainst;
         my $totalGoals;
         my $totalTeams;
         my $AverageGoals;
         my @goals;
         my $i = 0;
         my $currentTeam;
         my $leagueFName = "OtherData/".$year."/teams.csv";
         print $leagueFName."\n";

         open my $leagueFH, '<', $leagueFName
                 or die "Unable to open leagues file: $leagueFName";     

         my $leagueRecord = <$leagueFH>;
         while ( $leagueRecord = <$leagueFH> ) {
            chomp ( $leagueRecord );
            if ( $csvLeague->parse($leagueRecord) ) {
               my @leagueFields = $csvLeague->fields();
               $currentTeam = $leagueFields[1];
               $totalTeams = $leagueFields[0];
               $totalGoals+= $leagueFields[9];
               if ($currentTeam eq $team) {
                  $goalsScoredFor = $leagueFields[9];
                  $goalsScoredAgainst = $leagueFields[10];
                                                     
               }
               
            } else {
               warn "Line could not be parsed: $leagueRecord\n";
            }
         }
         close ($leagueFH);
         $AverageGoals = $totalGoals/$totalTeams;
         $goals[0] = $goalsScoredFor;
         $goals[1] = $goalsScoredAgainst;
         $goals[2] = $AverageGoals;
         return \@goals;
   
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
         return \@goals;

         # #print $team." Goals \n";
         # my $j = 0;
         # for ($j = 0;$j<$i;$j++) {
                 # print $goals[$j]."\n";
         # }



}

