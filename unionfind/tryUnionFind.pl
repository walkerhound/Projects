#!/usr/bin/perl
use strict;
use warnings;
use Graph::UnionFind;
require "readIdentifiers.pl";


my $uf = Graph::UnionFind->new;

#my $identifierArrayRef = readIdentifiers();
#my @identifierArray = @{$identifierArrayRef};
my ($identifierLinkArray1Ref,$identifierLinkArray2Ref) = readIdentifierLinks();
my @identifierLinkArray1 = @{$identifierLinkArray1Ref};
my @identifierLinkArray2 = @{$identifierLinkArray2Ref};

#my $numberIdentifiers = scalar @identifierArray;
my $numberLinks = scalar @identifierLinkArray1;

#for(my $i = 0 ; $i<$numberIdentifiers; $i++){
#	$uf->add($identifierArray[$i]);
#	if($i % 10000 == 0){
#		print " i $i \n";
#	}
#}



for(my $i = 0 ; $i < $numberLinks ; $i++){
	if($uf->has( $identifierLinkArray1[$i] ){
		$uf->add($identifierLinkArray1[$i]);
	}
	if($uf->has( $identifierLinkArray2[$i] ){
		$uf->add($identifierLinkArray2[$i]);
	}
	$uf->union($identifierLinkArray1[$i],$identifierLinkArray2[$i]);
	if($i % 10000 == 0){
		print " i $i \n";
	}
}

#for(my $i = 0 ; $i < $numberLinks ; $i++){
#	$uf->union($identifierLinkArray1[$i],$identifierLinkArray2[$i]);
#	if($i % 10000 == 0){
#		print " i $i \n";
#	}
#}


#my $LargestComponent = 0;
#for(my $i = 0; $i < $numberIdentifiers; $i++){
#	my $currentComponentSize = 0;
#	for (my $j=0; $j < $numberIdentifiers; $j++){
#		my $iOne = $uf->find($identifierArray[$i]);
#		my $jOne = $uf->find($identifierArray[$j]);
#		if ($iOne == $jOne){
#			$currentComponentSize++;
#		}
#
#	}
#	if($i % 10000 == 0){
#			print " i $i $currentComponentSize $LargestComponent $iOne\n";
#	}
#	if($currentComponentSize > $LargestComponent){
#		$LargestComponent = $currentComponentSize;
#	}
#}



#my $u = 'A';
#my $v = 'B';
#my $w = 'C';

#$uf->add($u);
#$uf->add($v);
#$uf->add($w);

#$uf->union($u,$v);

#my $pu = $uf->find($u);
#my $pv = $uf->find($v);
#my $pw = $uf->find($w);

#print " pu $pu\n";
#print " pv $pv\n";
#print " pw $pw\n";