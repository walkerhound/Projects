#!/usr/bin/perl
use strict;
use warnings;
use Graph;
require "readIdentifiers.pl";

# perl script to find connected components based on identifiers and identifier links

my $start = time();


my $g = Graph->new(undirected => 1);
my $end = time();
printf(" Getting ready to read links from database %.2f\n", $end - $start);

my ($identifierLinkArray1Ref,$identifierLinkArray2Ref) = readIdentifierLinks();
my @identifierLinkArray1 = @{$identifierLinkArray1Ref};
my @identifierLinkArray2 = @{$identifierLinkArray2Ref};
$end = time();
printf(" Finished reading links from database %.2f\n", $end - $start);

my $numberLinks = scalar @identifierLinkArray1;
$end = time();
printf(" Number of Links $numberLinks %.2f\n", $end - $start);


$end = time();
printf(" Getting ready to add edges to graph %.2f\n", $end - $start);

for(my $i = 0 ; $i < $numberLinks ; $i++){
	if($identifierLinkArray1[$i] == 1011481){
		print "Got Link: $identifierLinkArray1[$i] $identifierLinkArray2[$i] \n"
	}
	if($identifierLinkArray1[$i] == 619045){
		print "Got Link: $identifierLinkArray1[$i] $identifierLinkArray2[$i] \n"
	}
	$g->add_edge($identifierLinkArray1[$i],$identifierLinkArray2[$i]);
}
$end = time();
printf(" Finished adding edges to graph %.2f\n", $end - $start);


my @totalVertices = $g->vertices;
my $numberVertices =  scalar @totalVertices;
for (my $i = 0; $i < $numberVertices; $i++){
	#print "$i $totalVertices[$i]\n";
}
$end = time();
printf(" Number of Vertices $numberVertices %.2f\n", $end - $start);




$end = time();
printf(" Before subgraphs calculation %.2f\n", $end - $start);
my @subgraphs = $g->connected_components;
$end = time();
printf(" After subgraphs calculation %.2f\n", $end - $start);
my $filename = "connectedComponents.txt";
open FILE,'>',$filename || die ("Can't open $filename:$!");
my $filename2 = "connectedComponentCounts.txt";
open FILE2,'>',$filename2 || die ("Can't open $filename2:$!");
my $numberConnectedComponents = scalar @subgraphs;
print " Number of connected components $numberConnectedComponents \n";
$end = time();
my @componentSizeArray;
my $maxArraySize = 500000;
for(my $i=0;$i<$maxArraySize;$i++){
	$componentSizeArray[$i]=0;
}
my $maxComponentSize=0;
my $countComponents=0;
printf(" Before printing Connected components to file %.2f\n", $end - $start);
for my $subgraph( @subgraphs){
	my $numberOfNodes = scalar @$subgraph;
	if($numberOfNodes < $maxArraySize){
		$componentSizeArray[$numberOfNodes] = $componentSizeArray[$numberOfNodes] + 1;
	}
	if($numberOfNodes > $maxComponentSize){
		$maxComponentSize=$numberOfNodes;
	}
	print FILE "$numberOfNodes ";
	print FILE2 "$countComponents $numberOfNodes \n";
	for my $node (@$subgraph){
		 print FILE " $node ";
	}
	print FILE "\n";
	$countComponents++;
}
$end = time();
printf(" After printing Connected components to file %.2f\n", $end - $start);
close FILE;
close FILE2;
print " max component size $maxComponentSize \n";
my $checkCount = 0;
for(my $i=0;$i<=$maxComponentSize;$i++){
	$checkCount = $checkCount + $componentSizeArray[$i]*$i;
}
print " $checkCount should match $numberVertices \n";


$filename = "counts.txt";
open FILE,'>',$filename || die ("Can't open $filename:$!");

for(my $i=0;$i<=$maxComponentSize;$i++){
	if($componentSizeArray[$i] > 0){
		print FILE " $i $componentSizeArray[$i] \n";
	}
}
close FILE;

$filename = "biggestComponent.txt";
open FILE,'>',$filename || die ("Can't open $filename:$!");
printf(" Before printing Largest Connected component to file %.2f\n", $end - $start);
for my $subgraph( @subgraphs){
	my $numberOfNodes = scalar @$subgraph;
	if($numberOfNodes == $maxComponentSize){
		for my $node (@$subgraph){
		 	print FILE "$node \n";
		}
	}
}
$end = time();

printf(" After printing Largest Connected component to file %.2f\n", $end - $start);
close FILE;


$filename = "connectedComponentsLong.txt";
open FILE,'>',$filename || die ("Can't open $filename:$!");
$countComponents=0;
printf(" Before printing Connected components to file  in a different format %.2f\n", $end - $start);
for my $subgraph( @subgraphs){
	for my $node (@$subgraph){
		 print FILE "$countComponents $node \n";
	}
	$countComponents++;
}
$end = time();
printf(" After printing Connected components to file  in a different format %.2f\n", $end - $start);


my $u=1011481;
my $v=619045;
my $w=124716;
#$u=5878768;
#$v=16727;
#$u=19239; 
#$v=582571;

#$u=19795;  
#$v=863376;
print " checking if both vertices are in graph\n";
print $u;
print "\n";
print $g->has_vertex($u);
print "\n";
print $v;
print "\n";
print $g->has_vertex($v);
print "\n";
print $w;
print "\n";
print $g->has_vertex($w);
print "\n";

