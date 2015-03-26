#!/usr/bin/perl
use strict;
use warnings;
my $numOfTeams = 3;
my $numOfGames = 3;

my @teamsGame;
my @gamesSchedule;

my $totalGames;
my @currentTeamGames;
$teamsGame[0][0] = "Montreal Canadians";
$teamsGame[0][1] = 1922;
$teamsGame[1][0] = "Hamilton Tigers";
$teamsGame[1][1] = 1922;
$teamsGame[2][0] = "Ottawa Senators";
$teamsGame[2][1] = 1922;

$totalGames =($numOfTeams*$numOfGames)/2;
if ($totalGames%2!=0) {
	 $totalGames = $totalGames+ 0.5;
}

print "total games to be played in the season is: ".$totalGames."\n";

my $i = 0;
my $j = 0;
my $totalCurrentGames = 0;
#loop through each team
for ($i = 1;$i<=$numOfTeams;$i++) {
	for ($j =$i+1;$j<=$numOfTeams;$j++) {
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
 for ($i = 1;$i<=$numOfTeams;$i++) {
 	
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
for ($i = 1;$i<=$numOfTeams;$i++) {
	if($currentTeamGames[$i] < $numOfGames) {
		$gamesRequired = $numOfGames - $currentTeamGames[$i];
		print "Games Required for team: ".$i." is ".$gamesRequired."\n";
		for ($j = 1; $j<=$gamesRequired; $j++) {
			$team1 = $i;
			$randTeam2 = int(rand($numOfTeams)) + 1; #Choose a random team between 1 and the number of teams we have
			while ($team1 == $randTeam2) {
				$team1 = $i;
				$randTeam2 = int(rand($numOfTeams)) + 1; #Choose a random team between 1 and the number of teams we have
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