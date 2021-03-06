#!/usr/bin/perl
use strict;
use warnings;
use Graph;
require "readIdentifiers.pl";


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
	$g->add_edge($identifierLinkArray1[$i],$identifierLinkArray2[$i]);
}
$end = time();
printf(" Finished adding edges to graph %.2f\n", $end - $start);



my @totalVertices = $g->vertices;
my $numberVertices =  scalar @totalVertices;
my @totalEdges = $g->edges;
my $numberEdges =  scalar @totalEdges;

print " Total Vertices $numberVertices \n";
print " Total Edges $numberEdges \n";


my @vertexArray;
$vertexArray[0]=4310056;
$vertexArray[1]=4310122;
$vertexArray[2]=4310172;
$vertexArray[3]=4307511;
$vertexArray[4]=4307573;
$vertexArray[5]=4310146;
$vertexArray[6]=4326013;
$vertexArray[7]=4326093;
$vertexArray[8]=4327280;
$vertexArray[9]=4327333;

my $currentVertex1;
my $currentVertex2;
my $checkVertex;
print " checking if all vertices are in graph\n";
for(my $i=0;$i<10;$i++){
	$currentVertex1=$vertexArray[$i];
	print " Vertex: $currentVertex1\n";
	print " is vertex? "; 
	$checkVertex = $g->has_vertex($currentVertex1);
	print $checkVertex;
	print "\n";
}

my @path;
my $linksInPath;
for(my $i=0;$i<10;$i++){
	for(my $j=0;$j<10;$j++){
		if($i!=$j){		
			$currentVertex1=$vertexArray[$i];
			$currentVertex2=$vertexArray[$j];			
			print " Vertices: $currentVertex1 $currentVertex2\n";
			@path = $g->SP_Dijkstra($currentVertex1,$currentVertex2);
			$linksInPath = scalar @path;
			print " Length of path $linksInPath \n";
			for(my $l=0; $l < $linksInPath; $l++){
				print $path[$l];
				print "\n";
			}
		}
	}
}