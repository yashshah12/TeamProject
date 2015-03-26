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
	my @finalScores;                                                
	                                                     
	
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
	
      #-----SCHEDULE--------
         # my @teamsGame;
         # my @gamesSchedule;

         my $totalGames;
         my @currentTeamGames;
         # $teamsGame[0][0] = "Montreal Canadians";
         # $teamsGame[0][1] = 1922;
         # $teamsGame[1][0] = "Hamilton Tigers";
         # $teamsGame[1][1] = 1922;
         # $teamsGame[2][0] = "Ottawa Senators";
         # $teamsGame[2][1] = 1922;

         $totalGames =($numTeams*$gamesToPlay)/2;
         if ($totalGames%2!=0) {
                  $totalGames = $totalGames+ 0.5;
         }

         print "total games to be played in the season is: ".$totalGames."\n";

         my $i = 0;
         my $j = 0;
         my $totalCurrentGames = 0;
         #loop through each team
         for ($i = 1;$i<=$numTeams;$i++) {
                 for ($j =$i+1;$j<=$numTeams;$j++) {
                         $gamesSchedule[$totalCurrentGames][0] = $i;
                         $gamesSchedule[$totalCurrentGames][1] = $j;
                         $totalCurrentGames++;
                 }
                 
         }

         for ($i = 0;$i<$totalCurrentGames;$i++) {
                 print $gamesSchedule[$i][0]."v".$gamesSchedule[$i][1]."\n";
         }
         print $totalCurrentGames."\n";
         $i = 0;
         my $currentTeam1;

         my $gamesPlayedByTeam1 = 0;
          for ($i = 1;$i<=$numTeams;$i++) {
                 
                 for ($j = 0;$j<=$#gamesSchedule;$j++) {
                         if ($i == $gamesSchedule[$j][0] || $i == $gamesSchedule[$j][1]) {
                                 $currentTeamGames[$i]++;
                                 
                         }
                 }
                 print "team ".$i." played ".$currentTeamGames[$i]."\n";
                 
         }
         my $gamesRequired;
         my $team1;
         my $randTeam2;
         for ($i = 1;$i<=$numTeams;$i++) {
                 if($currentTeamGames[$i] < $gamesToPlay) {
                         $gamesRequired = $gamesToPlay - $currentTeamGames[$i];
                         print "Games Required for team: ".$i." is ".$gamesRequired."\n";
                         for ($j = 1; $j<=$gamesRequired; $j++) {
                                 $team1 = $i;
                                 $randTeam2 = int(rand($numTeams)) + 1; #Choose a random team between 1 and the number of teams we have
                                 while ($team1 == $randTeam2) {
                                         $team1 = $i;
                                         $randTeam2 = int(rand($numTeams)) + 1; #Choose a random team between 1 and the number of teams we have
                                 }
                                 $gamesSchedule[$totalCurrentGames-1][0] = $team1;
                                 $gamesSchedule[$totalCurrentGames-1][1] = $randTeam2;
                                 $totalCurrentGames++;
                                 $currentTeamGames[$i]++;
                                 # print $randTeam1." - ".$randTeam2."\n";
                         }
                 }
         }

         my $t1;
         my $t2;
         for ($i = 0;$i<$totalCurrentGames-1;$i++) {
                 $t1 = $gamesSchedule[$i][0];
                 $t2 = $gamesSchedule[$i][1];
                  print $gamesSchedule[$i][0]."v".$gamesSchedule[$i][1]."\n";
                 print $teamsGame[$t1-1][1]." ".$teamsGame[$t1-1][0]."VS".$teamsGame[$t2-1][1]." ".$teamsGame[$t2-1][0]."\n";
                 # $teamsGame[0][0]
         }
         print $#gamesSchedule."VS".$totalCurrentGames."\n";
	# #Make a random schdule
	# for ($i = 1; $i<=$gamesToPlay; $i++) {
		# $randTeam1 = int(rand($numTeams)) + 1; #Choose a random team between 1 and the number of teams we have
                # $randTeam2 = int(rand($numTeams)) + 1; #Choose a random team between 1 and the number of teams we have
		# while ($randTeam1 ==$randTeam2) {
			# $randTeam1 = int(rand($numTeams)) + 1; #Choose a random team between 1 and the number of teams we have
                        # $randTeam2 = int(rand($numTeams)) + 1; #Choose a random team between 1 and the number of teams we have
		# }
		# $gamesSchedule[$i-1][0] = $randTeam1;
		# $gamesSchedule[$i-1][1] = $randTeam2;
                # # print $randTeam1." - ".$randTeam2."\n";
	# }
	
	
	
	# for ($i = 0;$i<=$#gamesSchedule;$i++) {
                  # print $gamesSchedule[$i][0]."VS".$gamesSchedule[$i][1]."\n";
	# }
	
	
	
	#------Schedule----------------
	for ($i = 0;$i<=$#gamesSchedule;$i++) {
           my $team1 = $gamesSchedule[$i][0]; #Just doing 1 matchup to see if metrics work. Choose the first matchup and store the number into variables
           my $team2 = $gamesSchedule[$i][1];
           #Since $team1 and $team2 are numbers that correspond to elements of the teams array, we just subtract it by 1 since elements start with 0 
           $homeTeam = $teamsGame[$team1-1][0];
           $homeTeamYear = $teamsGame[$team1-1][1];
           $visitorTeam = $teamsGame[$team2-1][0];
           $visitorTeamYear = $teamsGame[$team2-1][1];
           @finalScores = @{findScore($homeTeam,$homeTeamYear,$visitorTeam,$visitorTeamYear)};	
           $gamesSchedule[$i][2] = $finalScores[0]; #storing home score which is team 1 score
           $gamesSchedule[$i][3] = $finalScores[1]; #storing visitor score which is $team 2score;
           

	}
	print "---Season Scores---\n";
	for ($i = 0;$i<=$#gamesSchedule;$i++) {
	   my $team1 = $gamesSchedule[$i][0]; #Just doing 1 matchup to see if metrics work. Choose the first matchup and store the number into variables
           my $team2 = $gamesSchedule[$i][1];
           #Since $team1 and $team2 are numbers that correspond to elements of the teams array, we just subtract it by 1 since elements start with 0 
           $homeTeam = $teamsGame[$team1-1][0];
           $homeTeamYear = $teamsGame[$team1-1][1];
           $visitorTeam = $teamsGame[$team2-1][0];
           $visitorTeamYear = $teamsGame[$team2-1][1];
           print $homeTeamYear." ".$homeTeam." - ".$gamesSchedule[$i][2]." VS ".$visitorTeamYear." ".$visitorTeam." - ".$gamesSchedule[$i][3]."\n";
	}
	
	
	# my $team1 = $gamesSchedule[0][0]; #Just doing 1 matchup to see if metrics work. Choose the first matchup and store the number into variables
	# my $team2 = $gamesSchedule[0][1];
	# #Since $team1 and $team2 are numbers that correspond to elements of the teams array, we just subtract it by 1 since elements start with 0 
	# $homeTeam = $teamsGame[$team1-1][0];
	# $homeTeamYear = $teamsGame[$team1-1][1];
	# $visitorTeam = $teamsGame[$team2-1][0];
	# $visitorTeamYear = $teamsGame[$team2-1][1];
	
	# findScore($homeTeam,$homeTeamYear,$visitorTeam,$visitorTeamYear);	
	
	# print "Teams Chosen\n";
	# print "User Selected: ".$teamYear.$teamName."\n";
	# # getGoalsOfTeams($teamName,$teamYear);
	# for ($i = 1;$i<=$numOpponents;$i++) {
		# print "Opponent:".$i."-".$opponents[$i-1][1].$opponents[$i-1][0]."\n";
		# # getGoalsOfTeams($opponents[$i-1][0],$opponents[$i-1][1]);
	# }
	

sub findScore {
        use POSIX;
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
        #Team A= home Team;
        #Team B = visitor Team, 
        my $metricGoalsForA = 0.00;
        my $metricGoalsAgainstA = 0.00;
        my $metricGoalsForB = 0.00;
        my $metricGoalsAgainstB = 0.00;
        my $metricTotalA = 0.00;
        my $metricTotalB= 0.00;
        
        my $totalHomeGoals;
        my $totalVisitorGoals;
        my $totalGoalsHomeLeague;
        my $totalGoalsAwayLeague;
        
        my $homeGoal; #Based on the roulette line
        my $visitorGoal; #based on the roulette line
        my $homeScore; #Final Score
        my $visitorScore;#Final Score
        my @finalScores;
        
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
       print $homeTeam."Numbers\n";
       print  $goalsHome[0]."\n";
       print  $goalsHome[2]."\n";
        print $avgGoalsScoredForHome."\n";
       $avgGoalsScoredAgainstHome = $goalsHome[1] / $goalsHome[2];
       print $avgGoalsScoredAgainstHome."\n";
       print $visitorTeam."Numbers\n";
       $avgGoalsScoredForAway = $goalsAway[0] / $goalsAway[2];
       print  $goalsAway[0]."\n";
       print  $goalsAway[2]."\n";
       print $avgGoalsScoredForAway."\n";
       $avgGoalsScoredAgainstAway = $goalsAway[1] / $goalsAway[2];
       print $avgGoalsScoredAgainstAway."\n";

        print "----METRICS----\n";
        $metricGoalsForA = $avgGoalsScoredForHome / $avgGoalsScoredForAway; #its not dividing properly
        print ($avgGoalsScoredForHome / $avgGoalsScoredForAway);
        $metricGoalsAgainstA = $avgGoalsScoredAgainstHome / $avgGoalsScoredAgainstAway;
        #Since the greater the metricGoalsAgainstA, the worst, so divide $metricGoalsAgainstA by 0.50
        $metricGoalsAgainstA = 0.5 / $metricGoalsAgainstA;
         
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
        
        $homeGoal = goalDistribution($homeTeam,$homeTeamYear);
        $visitorGoal = goalDistribution($visitorTeam,$visitorTeamYear);
        $homeScore = ceil($homeGoal *$metricTotalA);
        $visitorScore = ceil($visitorGoal * $metricTotalB);
        print "---FINAL SCORE---\n";
        print $homeTeamYear." ".$homeTeam." - ".$homeScore."\n";
        print $visitorTeamYear." ".$visitorTeam." - ".$visitorScore."\n";
        $finalScores[0] = $homeScore;
        $finalScores[1] = $visitorScore;
        return \@finalScores;
        
        
        
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
sub goalDistribution {
   
   my ($team, $year) = @_;
   my $randGoal;
   use Text::CSV;
   my $csvLeague   = Text::CSV->new({ sep_char => ',' });

   my $visitor;
   my $home;
   my $visitorG;
   my $homeG;
   my @goals;
   my $i = 0;
   my $leagueFName = "OtherData/".$year."/results.csv";

   open my $leagueFH, '<', $leagueFName
           or die "Unable to open leagues file: $leagueFName";     

   my $leagueRecord = <$leagueFH>;
   while ( $leagueRecord = <$leagueFH> ) {
      chomp ( $leagueRecord );
      if ( $csvLeague->parse($leagueRecord) ) {
         my @leagueFields = $csvLeague->fields();
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
   # for ($j = 0;$j<$i;$j++) 
   # {
           # print $goals[$j]."\n";
   # }

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
   my @goalDist;
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
      #print ("Amount of times ".$p." goal(s) was scored: ".$group[$p]. "--> ".($group[$p]*10)."% \n");
      if($p ==0) 
      {
         $goalDist[$p] = $group[$p]*10;
      } 
      else 
      {
         $goalDist[$p] = $group[$p]*10 + $goalDist[$p-1];
      }
         
      if($goalDist[$p] ==100) 
      {
           last;
      }
   }
   
   for ($p=0;$p<$#goalDist;$p++) 
   {      
         print $goalDist[$p]."\t";
   }
   print("\n");
   print join(", ", @goalDist);
   print("\n");
   $randGoal = getGoal(@goalDist);
   
   return $randGoal;
   
   
}
sub getGoal {
   my (@goalDist) = @_;
   my $range = 100;
   my $i = 0;
   my $randGoal = rand($range) +0.5;
   my $goal;
   for ($i = 0;$i<$#goalDist;$i++) {
      if ($i==0) 
      {
         if ($goalDist[0] != 0)
         {
            if ($randGoal <=$goalDist[0]) 
            {
               $goal = $i;
               last;
            } 
         }
      } 
      elsif($i >0 && $i <$#goalDist-1)
      {
         if($randGoal>$goalDist[$i] && $randGoal <=$goalDist[$i+1]) 
         {
               $goal = $i+1;
               last;
         }    
      } 
      else 
      {
         $goal = $i+1;
         last;
        }
    }
    print $randGoal."\n";
    print $goal."\n";
   
   return $goal;
   
}
