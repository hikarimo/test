#!/bin/perl

while(<>) {
	if (isS0Record() == 1) {
		printf("FileName : %s\n", $FileName);
	}
	if (isS2Record() == 1) {
		printf("%08x : %s\n", $LoadAddress, $Code);
	}
	if (isS3Record() == 1) {
		printf("%08x : %s\n", $LoadAddress, $Code);
	}
	if (isS7Record() == 1) {
		printf("Entry : %08x\n", $EntryPointAddress);
	}
	if (isS8Record() == 1) {
	}
}

sub isS0Record {
	if (/^S0(\w\w)(.+)/) {
		$FileName = $2;
		return 1;
	}
	else {
		$FileName = "";
		return 0;
	}
}

sub isS2Record {

	if (/^S2(\w\w)(\w\w\w\w\w\w)(.+)/) {
		$LoadAddress = oct("0x" . $2);
		$Code = $3;
		return 1;
	}
	else{
		$LoadAddress = 0;
		$Code = 0;
		return 0;
	}
}

sub isS3Record {
	if (/^S3(\w\w)(\w\w\w\w\w\w\w\w)(.+)/) {
		$LoadAddress = oct("0x" . $2);
		$Code = $3;
		return 1;
	}
	else {
		$LoadAddress = oct("0x" . $2);
		$Code = $3;
		return 0;
	}
}

sub isS7Record {
	if (/^S7(\w\w)(\w\w\w\w\w\w\w\w)\w\w/) {
		$EntryPointAddress = oct("0x" . $2);
		return 1;
	}
	else {
		$EntryPointAddress = 0;
		return 0;
	}
}

sub isS8Record {
	if (/^S8(\w\w)(\w\w\w\w\w\w)\w\w/) {
		$EntryPointAddress = oct("0x" . $2);
	}
	else {
		$EntryPointAddress = 0;
		return 0;
	}
}
