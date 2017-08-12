open(INPUT, $ARGV[0]) || die "Cannot open input file";
@data = <INPUT>;
close(INPUT);

for ($i=2 ; $i < @data ; $i++) {
    @line = split(/\s+/, $data[$i]);
    if ($line[1] eq "1") {
	@node = split("_", $line[0]);
	$node[0] =~ s/x(.*)/$1/;
	$edge{$node[0]} = $node[1];
    }
}

foreach $key (keys(%edge)) {
    push(@keySet, $key);
}

$sumNodes = 0;
$sumRealNodes = 0;
$sumDummies = 0;

for ($i=0 ; $i < @keySet ; $i++) {
    $startNode = $keySet[$i];
    while ($visited{$startNode} eq "1") {
	$i++;
	$startNode = $keySet[$i];
    }
    if ($startNode eq "") {
	last;
    }
    print "startNode: '" . $startNode . "'\n";
    $nodes = 0;
    $dummies = 0;
    $nextNode = $startNode;
    while (true) {
	$nodes++;
	print "\t";
	print $edge{$nextNode};
	if ($edge{$nextNode} =~ /^dummy/) {
	    $dummies++;
	    print " (" . $dummies . ")";
	}
	print "\n";
	$visited{$nextNode} = "1";
	$nextNode = $edge{$nextNode};
	if ($nextNode eq $startNode) {
	    $sumNodes += $nodes;
	    $sumRealNodes += ($nodes - $dummies);
	    $sumDummies += $dummies;
	    print "\t\tTotal Nodes: " . $nodes . ", Real Nodes: " . ($nodes - $dummies) . ", Dummies: " . $dummies . "\n\n";
	    last;
	}
    }
}
print "Sum of Nodes: " . $sumNodes . "\n";
print "Sum of Real Nodes: " . $sumRealNodes . "\n";
print "Sum of Dummies: " . $sumDummies . "\n";



