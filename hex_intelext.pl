#!/bin/perl

while(<>) {
	if (isStartRecord() == 1) {
		$startAddress = ($EntryPointAddressParagraph << 4) + $EntryPointAddressOffset;
		printf("Start Address : %04x\n", $startAddress);
	}
	if (isExtAddressRecord() == 1) {
		printf("ExtAddress : %04x\n", $SegmentParagraph);
	}
	if (isDataRecord() == 1) {
		printf("%05x : %s\n", ($SegmentParagraph << 4) + $LocationAddress, $Code);
	}
	if (isEndRecord() == 1) {
		printf("End\n");
	}
}

sub isStartRecord {
	if (/^:04000003(\w\w\w\w)(\w\w\w\w)\w\w/) {
		$EntryPointAddressParagraph = oct("0x". $1);
		$EntryPointAddressOffset = oct("0x" . $2);
		return 1;
	}
	else {
		$EntryPointAddressParagraph = 0;
		$EntryPointAddressOffset = 0;
		return 0;
	}
}

sub isExtAddressRecord {

	if (/^:02000002(\w\w\w\w)\w\w/) {
		$SegmentParagraph = oct("0x" . $1);
		return 1;
	}
	else{
		$SegPara = 0;
		return 0;
	}
}

sub isDataRecord {
	if (/^:(\w\w)(\w\w\w\w)00(\w+)/) {
		$ByteNum = oct("0x" . $1);
		$LocationAddress = oct("0x" . $2);
		$Code = $3;
		return 1;
	}
	else {
		$ByteNum = 0;
		$LocationAddress = 0;
		$Code = 0;
		return 0;
	}
}

sub isEndRecord {
	if (/^:00000001FF/) {
		return 1;
	}
	else {
		return 0;
	}
}
