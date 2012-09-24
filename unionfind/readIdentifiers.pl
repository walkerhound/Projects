#!/usr/bin/perl
# Subroutine to read information from pre-loaded database files
# This routine reads from Identifiers and Identifier_links3
# 


# PERL MODULES WE WILL BE USING


use strict; 
use DBI;
use Sys::Hostname;
use List::Util qw[min max];




sub readIdentifiers{
	#Set up to read the Identifiers information from three tables in the database.
	my @identifierArray;
	my $host = '//phenogen.ucdenver.edu';
	my $port = '1521';
	my ($service_name, $platform, $usr, $passwd);
	my $hostname = hostname;
	if($hostname eq 'amc-kenny.ucdenver.pvt'){
		$service_name = 'dev.ucdenver.pvt';
		$platform = 'Oracle';
		$usr = 'INIA';
		$passwd = 'INIA_dev';
	}
	elsif($hostname eq 'compbio.ucdenver.edu'){
		$service_name = 'test.ucdenver.pvt';
		$platform = 'Oracle';
		$usr = 'INIA';
		$passwd = 'INIA_test';
	}
	elsif($hostname eq 'phenogen.ucdenver.edu'){
		$service_name = 'prod.ucdenver.pvt';
		$platform = 'Oracle';
		$usr = 'INIA';
		$passwd = 'INIA_olleH';
	}
	else{
		die("Unrecognized Hostname:",$hostname,"\n");
	}

		$service_name = 'test.ucdenver.pvt';
		$platform = 'Oracle';
		$usr = 'INIA';
		$passwd = 'INIA_test';

	
	# DATA SOURCE NAME
	my $dsn = "dbi:$platform:$service_name";
	print "dsn $dsn \n";
	# PERL DBI CONNECT
	my $connect = DBI->connect($dsn, $usr, $passwd) or die ($DBI::errstr ."\n");

	# PREPARE THE QUERY for pvalues

	my $query = "select ID_NUMBER from IDENTIFIERS where ID_NUMBER < 50000";
		      
	my $query_handle = $connect->prepare($query) or die (" Identifier query prepare failed $!");

# EXECUTE THE QUERY
	$query_handle->execute() or die ( "IDENTIFIER query execute failed $!");


# BIND TABLE COLUMNS TO VARIABLES
	my $identifierNumber;
	$query_handle->bind_columns(\$identifierNumber);
	my $counter = -1;

# Loop through results, adding to array of hashes.	
	while($query_handle->fetch()) {
			$counter++;
			$identifierArray[$counter]=$identifierNumber;
	}

	$query_handle->finish();
	$connect->disconnect();
	print " Total number of identifiers read $counter \n";
	return (\@identifierArray);
}

sub readIdentifierLinks{
	#Set up to read the Locus Specific Pvalue information from three tables in the database.
	my @identifierLinkArray1;
	my @identifierLinkArray2;
	my @identifierTypeArray1;
	my @identifierTypeArray2;
	my $host = '//phenogen.ucdenver.edu';
	my $port = '1521';
	my ($service_name, $platform, $usr, $passwd);
	my $hostname = hostname;
	if($hostname eq 'amc-kenny.ucdenver.pvt'){
		$service_name = 'dev.ucdenver.pvt';
		$platform = 'Oracle';
		$usr = 'INIA';
		$passwd = 'INIA_dev';
	}
	elsif($hostname eq 'compbio.ucdenver.edu'){
		$service_name = 'test.ucdenver.pvt';
		$platform = 'Oracle';
		$usr = 'INIA';
		$passwd = 'INIA_test';
	}
	elsif($hostname eq 'phenogen.ucdenver.edu'){
		$service_name = 'prod.ucdenver.pvt';
		$platform = 'Oracle';
		$usr = 'INIA';
		$passwd = 'INIA_olleH';
	}
	else{
		die("Unrecognized Hostname:",$hostname,"\n");
	}

	
	# DATA SOURCE NAME
	my $dsn = "dbi:$platform:$service_name";
	#print "dsn $dsn \n";
	# PERL DBI CONNECT
	my $connect = DBI->connect($dsn, $usr, $passwd) or die ($DBI::errstr ."\n");

	# PREPARE THE QUERY for pvalues

	#my $query = "select ab.ID_NUMBER1,ab.ID_NUMBER2,a.IDENT_TYPE_ID, b.IDENT_TYPE_ID from IDENTIFIER_LINKS3 ab, IDENTIFIERS a, IDENTIFIERS b ";
	#$query = $query . " where ab.ID_NUMBER1 = a.ID_NUMBER and ab.ID_NUMBER2 = b.ID_NUMBER and (ab.ID_NUMBER1 < 300000 or ab.ID_NUMBER2 < 300000) and  a.IDENT_TYPE_ID not in (7,8) and b.IDENT_TYPE_ID not in (7,8)";
	#my $query = "select ab.ID_NUMBER1,ab.ID_NUMBER2 from IDENTIFIER_LINKS3 ab, IDENTIFIERS a, IDENTIFIERS b";
	#my $query = "select ab.ID_NUMBER1,ab.ID_NUMBER2 from IDENTIFIER_LINKS_LEC ab ";
	my $query = "select ab.ID_NUMBER1,ab.ID_NUMBER2 from IDENTIFIER_LINKS_LEC3 ab ";
	#$query = $query . " where (ab.ID_NUMBER1 < 200000 or ab.ID_NUMBER2 < 200000) ";
	#$query = $query . " where (ab.ID_NUMBER1 < 500000 or ab.ID_NUMBER2 < 500000) and ab.organism = 'Mm'";
	$query = $query . " where ab.organism = 'Mm'";
	print " query: $query \n";
	#$query = $query . " where (ab.ID_NUMBER1 < 20000 or ab.ID_NUMBER2 < 20000) ";	
	my $query_handle = $connect->prepare($query) or die (" Identifier link query prepare failed $!");

# EXECUTE THE QUERY
	$query_handle->execute() or die ( "IDENTIFIER LINK query execute failed $!");


# BIND TABLE COLUMNS TO VARIABLES
	my ($identifierNumber1,$identifierNumber2);
	$query_handle->bind_columns(\$identifierNumber1,\$identifierNumber2);
	my $counter = -1;

# Loop through results, adding to array of hashes.	
	while($query_handle->fetch()) {
			$counter++;
			$identifierLinkArray1[$counter]=$identifierNumber1;
			$identifierLinkArray2[$counter]=$identifierNumber2;
	}

	$query_handle->finish();
	$connect->disconnect();
	#print " Total number of identifiers Links read $counter \n";
	return (\@identifierLinkArray1,\@identifierLinkArray2);
}


1;


