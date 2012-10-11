#!/usr/bin/perl

#use gameBase;

print "Welcome to Lord of the Shell game:\n";
my $levels = getNumOfLevels();
#cleanLevels($levels);
startGame("/home/viggy/ShellGame/Game/",$levels);
#playAllLevels();
#finishGame();

sub startGame()
{
	my($gameDir,$levels) = @_;
        for($level=1;$level<=$levels;$level++)
	{
		my $cleanScript = getCleanScript($gameDir,$level);
#		print "CleanScript = $cleanScript";
		clean($cleanScript);
		my $prepareScript = getPrepareScript($gameDir,$level);
		prepare($prepareScript);
		my $instructionScript = getInstructionScript($gameDir,$level);
		displayInstructions($instructionScript);
		my $completeFlag = "1";
		while($completeFlag != "0")
		{
			my $waitLevelInput = waitForLevelCompletion($level);
			if($waitLevelInput==0)
			{
				exitGame($gameDir,$level);
				next;
			}
			my $verifyCompletion = getVerifyCompletionScript($gameDir,$level);
			$completeFlag = verifyCompletion($verifyCompletion);
		
		}
		if($completeFlag=~"1")
		{
			printCompletetionGreetings($level);
		}
	}
	finalGreetings();
}


sub finalGreetings()
{
	print "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n";
	print "<<<    Congratulations!!!. You have cleared all levels.    >>>\n";
	print "<<<          You are now the LORD OF THE SHELL             >>>\n";
	print "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n";
}


sub waitForLevelCompletion()
{
	my($level) = @_;
	print "Level $level Complete (y/n) :";
	while(defined($input=<STDIN>))
	{
		if($input=~"y"|| $input=~"Y")
		{
			return 1;
		}
		else
		{
			return 0;
		}
	}
}

sub exitGame()
{
	my($gameDir,$level) = @_;
	print "Want to exit game (y/n) :";
        while(defined($input=<STDIN>))
	{
		if($input=~"y"|| $input=~"Y")
		{
			exit();
		}
		else
		{
			return;
		}
	}
}


sub printCompletetionGreetings()
{
	my($level) = @_;
	print "Congratulations!!! You have cleared level $level\n";

}

sub runScript()
{
	my ($script) = @_;
##	print "Executing $script\n";
	return system($script);
}
sub verifyCompletion()
{
	my($script) = @_;
	my $pass = &runScript($script);	
	if($pass!= "0")
	{
		print "Level verification failed. Play again!!!\n";
		return 1;
	}
	return 0;
	
}

sub displayInstructions()
{
	my($script) = @_;
	return &runScript($script);	
}

sub prepare()
{
	my($script) = @_;
	return &runScript($script);	
}


sub clean()
{
	my($script) = @_;
	return &runScript($script);	
}

sub getScript()
{
	my ($gameDir,$level,$scriptName) = @_;
	my $script = "$gameDir"."/"."$level"."/"."$scriptName";
	return $script;
}

sub getVerifyCompletionScript()
{
	my($gameDir,$level) = @_;
	return &getScript($gameDir,$level,"verify");
}

sub getInstructionScript()
{
	my($gameDir,$level) = @_;
	return &getScript($gameDir,$level,"instruction");
}

sub getPrepareScript()
{
	my($gameDir,$level) = @_;
	return &getScript($gameDir,$level,"prepare");
}

sub getCleanScript()
{
	my($gameDir,$level) = @_;
	return &getScript($gameDir,$level,"clean");
}



sub cleanLevels()
{
	my $i = $_[0];
	for($level=0;$level<$i;$level++)
	{
		print "cleaning $level\n";
		&clean($level);
	}

}

sub getNumOfLevels()
{
	
	return 6;

}
