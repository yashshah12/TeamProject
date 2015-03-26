#!/usr/bin/perl
use strict;
use warnings;

# Created By Yash Shah
# CIS 2250 Fantasy Game Project
# Created Saturday March 14 2015

#
#Functions 
#
makeChoice();


#
# This function basically is the first question we ask the user, if they would like to do research or start simulation or quit
# I made it a simple module so we can call it again if they want to repeat 
# Choosing 1(doing research) will call anohter functon
# Choosing 2(starting simulation) will lead to anohter function and 
# Choosing 3(quit) will exit the program
#
sub makeChoice {
	
	my $userChoice = 0;
	#Keep asking until an appropriate answer is achieved
	do {
		print "Will you like to do research (1) or go ahead and choose a team(2) or quit(3)";
		chomp ($userChoice = <>);
			
		if($userChoice !=1 && $userChoice !=2 && $userChoice!=3) {
			print "Incorrect Input"."\n";
		}
		
	} while(($userChoice!= 1) && ($userChoice!=2) && ($userChoice!=3));

	print "CHOICE:".$userChoice."\n";

	if($userChoice==1) {
		Research();
	} elsif($userChoice==2) {
		print "Metrics Option Coming Soon\n";
		exit;
	}elsif($userChoice==3) {
		print "Exited Game\n";
		exit;
	}

}
#
# This function will start the dashboard, allowing user to view stats about a team for one year or multiple years
#
sub Research{

	my $userChoice = 0;
      

	#Repeat until the user gives appropriate answer
	do {
		print "View Statistics of a team at a specific year(1) or view statistics of a team over a range of years(2)";
		chomp ($userChoice = <>);
		if($userChoice !=1 && $userChoice !=2) {
			print "Incorrect Input"."\n";
		}
	} while(($userChoice!= 1) && ($userChoice!=2));

	# Choosing 1 will allow the user to view stats about one team for a particular year. It will call another function that will do this.
	if($userChoice==1){
		 ResearchSpecificYear();
	} elsif($userChoice==2){
               
                 ResearchRangeYear();
        }

}

# Function definition to do Research on a team
sub ResearchSpecificYear{
	#Start the CSV module
	
	use Text::CSV;
	my $csvTeams   = Text::CSV->new({ sep_char => ',' });
	
	#Variables
	my @teams;
	my $teamChoice;
	my $userChoice = 0;	
	my $year;
	
	my $i = 0;
	#
	#Asking user for a year. Add error checking to this like above code. Loop until a year in the appropriate ranges is given
	#
	print "What year will you like to choose (Ex. 1920 not 1920-1921)";
	chomp ($year = <>);
	
	#Creating the path name to opening the teams.csv for a particular year in the sub folder, OtherData
	my $teamsFName   = "OtherData/".$year."/teams.csv";
	print $teamsFName."\n";
	
	#Check if the file exists, 
	open my $teamsFH, '<', $teamsFName
		or die "Unable to open teams file: $teamsFName";
	
	
	my $teamRecord = <$teamsFH>;
	#Loop through the file until there is something to be read
	while ( $teamRecord = <$teamsFH> ) {
	   chomp ( $teamRecord );	
	   if ( $csvTeams->parse($teamRecord) ) {
	      my @teamFields = $csvTeams->fields();
	      #Store the team name and put it into teams array
	      $teams[$i] = $teamFields[1];
	     
	      #Encoding the teams with a number so user does not have to type the whole name. Ex. Montreal Canadiens (1). 
	      print $teams[$i]."(".($i+1).")\n";

	   } else {
	      warn "Line/record could not be parsed: $teamRecord\n";
	   }
	   $i++;
	}
	close ($teamsFH);
	#Asking what team the user will like to choose based on the teams we listed above. 
	#Keep asking until they enter appropriate number given the range - Error checking 
	$userChoice = 0;
	do {
		print "What team will you like to choose (ex. For Hamilton Tigers, press 1):\n";
		chomp ($userChoice = <>);
		if($userChoice <1 || $userChoice >(@teams)) {
			print "Incorrect Input"."\n";
		}
	} while ($userChoice < 1 || $userChoice >(@teams)); # Checking if the number they entered is in the range of the array
	print "User Selected: ".$userChoice."-".$teams[$userChoice-1]."\n";

	$teamChoice = $teams[$userChoice-1];
	#printf $teamChoice."\n";
	
	#Caling this function to create the first chart of goal differntial. 
	GoalDifferential($teamChoice, $year);
	
	#This function will collect other information on that team such as games played, wins, losses, goalsscoredfor, goalsscoredagainst
	#Pass the team name and the year to the function
	Stats($teamChoice, $year);
}

sub ResearchRangeYear{

	
	#Start the CSV module
        use Text::CSV;
	my $csvTeams   = Text::CSV->new({ sep_char => ',' });
	
	#Variables
	my @teams;
        my @teamError;
	my $teamChoice;
	my $userChoice = 0;	
	my $yearStart;
        my $yearEnd;
        my $tempYear;
        my $range;
        my $valid = 0;
        my $error = 0;

	my $i = 0;
	my $k = 0;
        my $j = 0;
	
	my $teamInYear = 1;
	my @arrayMultiPlotInfo;
	my $currentYear;
        #
	#Asking user for a year. Add error checking to this like above code. Loop until a year in the appropriate ranges is given
	#
               
        while($valid == 0)
        {
	print "What year will you like to start at (Ex. 1920 not 1920-1921)";
	chomp ($yearStart = <>);
        print "What year will you like to end at (Ex. 1922 not 1922-1923)";
	chomp ($yearEnd = <>);
        
        $valid = 1;

        if($yearEnd > $yearStart && $yearStart >1916)
        {
            $range=$yearEnd - $yearStart +1;
        }
        elsif ($yearStart > $yearEnd && $yearEnd > 1916)
        {
            $tempYear = $yearStart;
            $yearStart = $yearEnd;
            $yearEnd = $tempYear;
            $range = $yearEnd - $yearStart+1;
        }
        elsif ($yearStart == $yearEnd && $yearStart > 1916)  
        {
            $range = 1;
        }
        else 
        {
            print "Invalid year, please try again\n";
            $valid = 0;
        }
        }
        
	#Creating the path name to opening the teams.csv for a particular year in the sub folder, OtherData
            my $teamsFName   = "OtherData/".$yearStart."/teams.csv";	
	    print $teamsFName."\n";
	    #Check if the file exists, 
	    open my $teamsFH, '<', $teamsFName
	        or die "Unable to open teams file: $teamsFName";
		
	    my $teamRecord = <$teamsFH>;
	    #Loop through the file until there is something to be read
	    while ( $teamRecord = <$teamsFH> ) {
	       chomp ( $teamRecord );	
	       if ( $csvTeams->parse($teamRecord) ) {
	          my @teamFields = $csvTeams->fields();
	          #Store the team name and put it into teams array
	          $teams[$i] = $teamFields[1];
	     
	          #Encoding the teams with a number so user does not have to type the whole name. Ex. Montreal Canadiens (1). 
	          print $teams[$i]."(".($i+1).")\n";

	       } else {
	          warn "Line/record could not be parsed: $teamRecord\n";
	       }
	       $i++;
	    }
	    close ($teamsFH);
	    #Asking what team the user will like to choose based on the teams we listed above. 
	    #Keep asking until they enter appropriate number given the range - Error checking 
	    $userChoice = 0;
	    do {
	            print "What team will you like to choose (ex. For Hamilton Tigers, press 1):\n";
		    chomp ($userChoice = <>);
		    if($userChoice <1 || $userChoice >(@teams)) {
		 	    print "Incorrect Input"."\n";
		    }
	    } while ($userChoice < 1 || $userChoice >(@teams)); # Checking if the number they entered is in the range of the array
	    print "User Selected: ".$userChoice."-".$teams[$userChoice-1]."\n";

	    $teamChoice = $teams[$userChoice-1];
	    # printf $teamChoice."\n";
	    my $isSuccess;
		$j = 0;
        	for ($currentYear= $yearStart;$currentYear<=$yearEnd;$currentYear++) {
        		
			 #Caling this function to create the first chart of goal differntial. 
			$isSuccess = GoalDifferential($teamChoice, $currentYear);
			if($isSuccess==1) {
				print "Successfully created the".$currentYear."csv\n";
				$arrayMultiPlotInfo[$j] = "DashboardGoalDifferential-".$currentYear.$teamChoice.".csv";
				print $arrayMultiPlotInfo[$j]."\n";
				$j++;
			} else {
				last;
			}
		}
		
		#create multi goal diff plots
		hockeyMultiplot(@arrayMultiPlotInfo);
	
	
        
        
        
        
    makeChoice();
}




#This function parses goal differntial for a teams games and creates a chart
sub GoalDifferential {
	#This is how you receive parameters, 
	my ($teamName, $year) = @_;
	my $toPlot = 0;
	#set up the module to parse a csv file
	use Text::CSV;
	my $csvLeague   = Text::CSV->new({ sep_char => ',' });
	
	#Variables
	my $home = " ";
	my $visitor = " ";
	my $homeG = " ";
	my $visitorG = " ";
	my @games;
	my $gamesNumber = 0;
	my $i = 0;

	#Creating the path name to open the results.csv for a given year in the subfolder of OtherData
	my $leagueFName = "OtherData/".$year."/results.csv";
	print $leagueFName."\n";
	
	#Opening the file
	open my $leagueFH, '<', $leagueFName
		or die "Unable to open leagues file: $leagueFName";     

	my $leagueRecord = <$leagueFH>;
	while ( $leagueRecord = <$leagueFH> ) {
	   chomp ( $leagueRecord );
	   if ( $csvLeague->parse($leagueRecord) ) {
	      my @leagueFields = $csvLeague->fields();
		 #Parsing in the home team,visitor team, home teams score and visitors score
		 $visitor = $leagueFields[1];
		 $visitorG = $leagueFields[3];
		 $home = $leagueFields[4];
		 $homeG = $leagueFields[6];
		 $games[$i][4] = 0;
		 #Mathcing the visitor team name with the team the user selected. If its a match then parse the score
		 if($visitor eq $teamName){
		    $toPlot = 1;
		    $games[$i][0] = $visitor;
		    $games[$i][1] = $visitorG;
		    $games[$i][2] = $home;
		    $games[$i][3] = $homeG;
		    #Check first if the scores are not blank, because u cant subtract blank spaces or will give you an error
		    if($games[$i][1] =~ /^[0-9,.E]+$/ &&  $games[$i][3] =~ /^[0-9,.E]+$/) {
			$games[$i][4] = $games[$i][1] - $games[$i][3];
		    }
		    
		    if($games[$i][4] >= 0){
			  $games[$i][5] = "Wins";
		    }else{
		       $games[$i][5] = "Losses";
		       }
		      $i++;
		 }
		 #Mathcing the home team name with the team the user selected. If its a match then parse the score
		 elsif($home eq $teamName){
		    $toPlot = 1;
		    $games[$i][0] = $home;
		    $games[$i][1] = $homeG;
		    $games[$i][2] = $visitor;
		    $games[$i][3] = $visitorG;
		    #Check first if the scores are not blank, because u cant subtract blank spaces or will give you an error
		    if($games[$i][1] =~ /^[0-9,.E]+$/ &&  $games[$i][3] =~ /^[0-9,.E]+$/) {
			$games[$i][4] = $games[$i][1] - $games[$i][3];
		    }
		    
		    if($games[$i][4] >= 0){
			  $games[$i][5] = "Wins";
		    }else{
		       $games[$i][5] = "Losses";
		       }
		      $i++;
		    }else{
		    $games[$i][0] = "";
		    $games[$i][1] = "";
		    $games[$i][2] = "";
		    $games[$i][3] = "";
		    $games[$i][5] = "";
		    }
		    
			

	   } else {
	      warn "Line could not be parsed: $leagueRecord\n";
	   }
	   $gamesNumber = $i;
	}
	close ($leagueFH);
	#if the team is not found in that year, then dont create the .csv and dont plot, exit the subroutine
	if ($toPlot==0) {
		return 0 ;
	}
	#
	#writting the game number and the goal differential and if that team won or not to a csv file which will be used to create the charts
	#
	
	#Creating a name for the csv file for Goal Differential Stats
	my $outputFName = "DashboardGoalDifferential-".$year.$teamName.".csv";
	
	#Opening the file handle to write 
	open my $outputFH, '>', $outputFName;
	
	print $outputFH "Game".","."Differential".","."Performance"."\n";
	
	for(my $i = 1; $i<=$gamesNumber;$i++){
	      print $outputFH $i.",".$games[$i-1][4].",".$games[$i-1][5]."\n";
	}
	close($outputFH);
	#this function will create the pdf, we are passing in the name of the csv file, the name we want for the pdf, and the title 
	plotHockeyData($outputFName, "DashboardGoalDifferential-".$year.$teamName.".pdf", $teamName."-".$year);
	print "Goal Differential PDF created\n";
	return 1;
	}
	
#Plotting Data for Goal Differential
sub plotHockeyData {
		
	my ($in_filename, $out_filename,$title) = @_;


	#!/usr/bin/perl
	use strict;
	use warnings;
	#
	#  Use the R Perl module for the ggplot2 graphics
	#
	use Statistics::R;

	#
	#  plotHockeyData.pl
	#  Author: 
	#  Date of Last Update: 
	#  Synopsis: bar plot of hockey game goal differential using R
	#



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
	
}
#
#FIX
#This function will parse other information of a team and will create a chart. 
#Ask the Prof how to create a chart with only two columns. Write now,i created a third column in the csv that is used to create the chart
#I followed the same format for the Goal Diferrential, but we dont need a third column
#
sub Stats {
	#Receieve parameters
	my ($teamName, $year) = @_;
	#Initilizing the module to read CSV
	use Text::CSV;
	my $csvTeams   = Text::CSV->new({ sep_char => ',' });
		
	#print $teamName."\n";
	#print $year."\n";
	my $currentTeam;
	#Get all information for that team such as wins, losses, goals scored etc.
	my $goalsScoredFor;
	my $goalsScoredAgainst;
	my $rank;
	my $gamesPlayed;
	my $gamesWon;
	my $gamesLoss;
	my $gamesTied;
	my $teamCode;
        my $i;	
        my $k;

	#Creating the path name so we can open the teams.csv for a particular year in the subfolder, OtherData
	my $teamsFName   = "OtherData/".$year."/teams.csv";
	print $teamsFName."\n";
	open my $teamsFH, '<', $teamsFName
		or die "Unable to open teams file: $teamsFName";
		
	my $teamRecord = <$teamsFH>;
	while ( $teamRecord = <$teamsFH> ) {
		chomp ( $teamRecord );	
		if ( $csvTeams->parse($teamRecord) ) {
			my @teamFields = $csvTeams->fields();
			#parse the team name 
			$currentTeam = $teamFields[1];
			#Match the team you parsed with the team the user choice, if its a match, then parse other information
			if($currentTeam eq $teamName) {
				$teamCode = $teamFields[2];
				$gamesPlayed = $teamFields[3];
				$gamesWon = $teamFields[4];
				$gamesLoss = $teamFields[5];
				$gamesTied = $teamFields[6];
				$goalsScoredFor = $teamFields[9];
				$goalsScoredAgainst = $teamFields[10];
				
		      }
		} else {
		      warn "Line/record could not be parsed: $teamRecord\n";
		}
	}
	
	close ($teamsFH);
		
	#writting to a file
	#Get rid of the third column "Performance";
	my $outputFName = "DashboardStats-".$teamName."-".$year.".csv";
	print $outputFName."\n";
	open my $outputFH, '>', $outputFName;
	print $outputFH "Stats".","."Result".","."Performance"."\n";
	print $outputFH "1.Games Played".",".$gamesPlayed.","."wins"."\n";
	print $outputFH "2.Games Won".",".$gamesWon.","."wins"."\n";
	print $outputFH "3.Games Loss".",".$gamesLoss.","."wins"."\n";
	print $outputFH "4.Games Tied".",".$gamesTied.","."wins"."\n";
	print $outputFH "5.Goals Scored For".",".$goalsScoredFor.","."wins"."\n";
	print $outputFH "6.Goals Scored Against".",".$goalsScoredAgainst.","."wins"."\n";
	close($outputFH);
	
	#Drawing the Graph
	my $title = $teamName."-".$year;
	use Statistics::R;
	
	# Create a communication bridge with R and start R
	my $R = Statistics::R->new();

	# Name the PDF output file for the plot  
	my $Rplots_file = "DashboardStats-".$teamName."-".$year.".pdf";

	# Set up the PDF file for plots
	$R->run(qq`pdf("$Rplots_file" , paper="letter")`);

	# Load the plotting library
	$R->run(q`library(ggplot2)`);

	# Read in data from the CSV file named on the command line
	$R->run(qq`data <- read.csv("$outputFName")`);

	#
	# Plot the data as a bar plot using blue for wins and red for losses
	#
	$R->run(qq`ggplot(data, aes(x=Stats, y=Result)) + 
	geom_bar(aes(fill=Performance),stat="identity", binwidth=3) + 
	scale_fill_manual(values=c("red")) + 
	ggtitle("$title") + ylab("Results") + xlab("Statistics") + 
	theme(axis.text.x=element_text(angle=50, size=10, vjust=0.5)) `);

	# Close down the PDF device
	$R->run(q`dev.off()`);

	$R->stop();
	
	

}
sub hockeyMultiplot {
	my (@multiPlotInfo) = @_;
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

# my $teamName = $multiPlotInfo[$#multiPlotInfo-2];
# my $startYear = $multiPlotInfo[$#multiPlotInfo-1];
# my $endYear = $multiPlotInfo[$#multiPlotInfo];

# print $teamName;
# print $startYear;
# print $endYear;
#this works
 my @in_file;
# $in_file[0] = $multiPlotInfo[0];
# $in_file[1] = $multiPlotInfo[1];
# $in_file[2] = $multiPlotInfo[2];
# $in_file[3] = $multiPlotInfo[3];
# my $count = 4;
#
my $k = 0;
print "".($#multiPlotInfo)."\n";
my $count;
for ($k = 0;$k<=$#multiPlotInfo;$k++) {
	$in_file[$k]= $multiPlotInfo[$k];
	
}	
$count = $k;
print $count."\n";

# my $count = $#multiPlotInfo - 3;
# for ( my $i=0; $i<$count; $i++ ) {
   # $in_file[$i]  = $multiPlotInfo[$i];
# }
my $out_file  = "MultiGoalDifferential.pdf";
my $cols      = 2;

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
}