#!/usr/bin/perl
use strict;
use warnings;
my @filename; 
my @newFilename; 
my @newerFilename; 
my @newestFilename; 
$filename[0] = "./save_200000/connectedComponents.txt";
$filename[1] = "./save_205000/connectedComponents.txt";
$filename[2] = "./save_210000/connectedComponents.txt";
$filename[3] = "./save_215000/connectedComponents.txt";
$filename[4] = "./save_220000/connectedComponents.txt";
$filename[5] = "./save_225000/connectedComponents.txt";
$filename[6] = "./save_250000/connectedComponents.txt";

$newFilename[0] = "./save_200000/bigNew.txt";
$newFilename[1] = "./save_205000/bigNew.txt";
$newFilename[2] = "./save_210000/bigNew.txt";
$newFilename[3] = "./save_215000/bigNew.txt";
$newFilename[4] = "./save_220000/bigNew.txt";
$newFilename[5] = "./save_225000/bigNew.txt";
$newFilename[6] = "./save_250000/bigNew.txt";


$newerFilename[0] = "./save_200000/newComponents.txt";
$newerFilename[1] = "./save_205000/newComponents.txt";
$newerFilename[2] = "./save_210000/newComponents.txt";
$newerFilename[3] = "./save_215000/newComponents.txt";
$newerFilename[4] = "./save_220000/newComponents.txt";
$newerFilename[5] = "./save_225000/newComponents.txt";
$newerFilename[6] = "./save_250000/newComponents.txt";

$newestFilename[0] = "./save_200000/newVertices.txt";
$newestFilename[1] = "./save_205000/newVertices.txt";
$newestFilename[2] = "./save_210000/newVertices.txt";
$newestFilename[3] = "./save_215000/newVertices.txt";
$newestFilename[4] = "./save_220000/newVertices.txt";
$newestFilename[5] = "./save_225000/newVertices.txt";
$newestFilename[6] = "./save_250000/newVertices.txt";

my @Array1;
my $value2;
my $count;
my $count1;
my $fileLine;
my @component;
my @newVerticesArray;
for(my $i=3; $i<7; $i++){
	open NEWFILE,'<',$newFilename[$i] || die ("Can't open $newFilename[$i]:$!");
	open COMPONENTFILE,'<',$filename[$i-1] || die ("Can't open $filename[$i-1]:$!");
	open NEWERFILE,'>',$newerFilename[$i] || die ("Can't open $newerFilename[$i]:$!");
	open NEWESTFILE,'>',$newestFilename[$i] || die ("Can't open $newestFilename[$i]:$!");
	print $newFilename[$i];
	print "\n";
	print $filename[$i-1];
	print "\n";
	print $newerFilename[$i];
	print "\n";
	print $newestFilename[$i];
	print "\n";
	$count=0;
	while(<COMPONENTFILE>){
		chomp;
		$fileLine = $_;
		$Array1[$count]=$fileLine;
		$count++
	}
	close(COMPONENTFILE);
	print " Count of components $count \n";
	$count1=0;
	while(<NEWFILE>){
		chomp;
		$fileLine=$_;
		$newVerticesArray[$count1]=$fileLine;	
		$count1++
	}
	close(NEWFILE);
	print " Count of new vertices in biggest component $count1 \n";
	my $currentVertex;
	my @gotitArray;
	my @gotitComponentArray;
	my $componentCount;
	for(my $l=0; $l<$count1; $l++){
		$gotitArray[$l]=0;
	}
	for(my $j=0; $j<$count; $j++){
		$gotitComponentArray[$j]=0;
	}
	print " Setting gotits \n";
	for(my $j = 0; $j<$count;$j++){
	#for(my $j = 19102; $j<19103; $j++){
		if($j % 10000 ==0){
			print "j $j \n";
		}
		$fileLine = $Array1[$j];
		#print $fileLine . "\n";
		@component = split(' ',$fileLine);
		$componentCount = scalar @component;
		# loop through components to see which have been added to the largest component
		for(my $k=1; $k< $componentCount; $k++){
			$currentVertex=$component[$k];
			#for(my $l=2820; $l < 2828; $l++){
			for(my $l=0; $l < $count1; $l++){
					#print " $i $j $k in sortedBig: $newVerticesArray[$l] in previous conncomp: $currentVertex";
					#print "\n";
				if($newVerticesArray[$l] == $currentVertex){
					print " i $i j $j k $k Found a match \n";
					print $newVerticesArray[$l];
					print "\n";
					print $currentVertex;
					print "\n";
					$gotitComponentArray[$j]=1;
					$gotitArray[$l]=1;
				}
			}
		}
	}
	print " Done with big loops \n";
	for(my $j=0; $j < $count; $j++){
		if($gotitComponentArray[$j] == 1){
			print NEWERFILE $Array1[$j]."\n";
		}
	}
	close(NEWERFILE);
	for(my $l=0; $l < $count1; $l++){
		if($gotitArray[$l] == 0){
			print NEWESTFILE $newVerticesArray[$l]."\n";
		}
	}
	close(NEWESTFILE);
}