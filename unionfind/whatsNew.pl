#!/usr/bin/perl
use strict;
use warnings;
my @filename; 
my @newFilename; 
$filename[0] = "./save_200000/sortedBig.txt";
$filename[1] = "./save_205000/sortedBig.txt";
$filename[2] = "./save_210000/sortedBig.txt";
$filename[3] = "./save_215000/sortedBig.txt";
$filename[4] = "./save_220000/sortedBig.txt";
$filename[5] = "./save_225000/sortedBig.txt";
$filename[6] = "./save_250000/sortedBig.txt";

$newFilename[0] = "./save_200000/bigNew.txt";
$newFilename[1] = "./save_205000/bigNew.txt";
$newFilename[2] = "./save_210000/bigNew.txt";
$newFilename[3] = "./save_215000/bigNew.txt";
$newFilename[4] = "./save_220000/bigNew.txt";
$newFilename[5] = "./save_225000/bigNew.txt";
$newFilename[6] = "./save_250000/bigNew.txt";

my @Array1;
my $value2;
my $count;
my $fileLine;
for(my $i=1; $i<7; $i++){
	open SECONDFILE,'<',$filename[$i] || die ("Can't open $filename[$i]:$!");
	open FIRSTFILE,'<',$filename[$i-1] || die ("Can't open $filename[$i-1]:$!");
	open NEWFILE,'>',$newFilename[$i] || die ("Can't open $newFilename[$i]:$!");
	$count=0;
	while(<FIRSTFILE>){
		chomp;
		$fileLine = $_;
		$Array1[$count]=$fileLine;
		$count++
	}
	close(FIRSTFILE);
	while(<SECONDFILE>){
		chomp;
		$fileLine=$_;
		my $gotit=0;
		for(my $j=0;$j<$count;$j++){
			if($_ eq $Array1[$j]){
				$gotit=1;
			}
		}
		if($gotit == 0){
			print NEWFILE $fileLine;
			print NEWFILE "\n";
		}
	}
	close(SECONDFILE);
	close(NEWFILE);
}
