$csvDelimeter = ";";

# read in data file
open(INPUT, $ARGV[0]) || die "Cannot open input file";
@data = <INPUT>;
close(INPUT);

for ($i=2 ; $i < @data ; $i++) {
    @line = split(/$csvDelimeter/, $data[$i]);
    if ($line[1] eq "1") {
	@node = split("_", $line[0]);
	$node[0] =~ s/x(.*)/$1/;
	$edge{$node[0]} = $node[1];
    }
}

# build a keySet list
foreach $key (keys(%edge)) {
    push(@keySet, $key);
}

# initialize sum variables
$sumNodes = 0;
$sumRealNodes = 0;
$sumDummies = 0;

# iterate through all the keys and for each key find the cycle that it is a part of keeping track of cycle size in terms of nodes
for ($i=0 ; $i < @keySet ; $i++) {
    $startNode = $keySet[$i];
    while ($visited{$startNode} eq "1") { # a node may already have bene visited, if so skip it until we find an unvisited one
	$i++;
	$startNode = $keySet[$i];
    }
    if ($startNode eq "") { # might wind up with an empty startNode because we've skipped to the end of the list of keys
	last;
    }
    print "startNode: '" . $startNode . "'\n";
    $nodes = 0;
    $dummies = 0;
    $nextNode = $startNode; # initialize nextNode
    while (true) {
	$nodes++;
	print "\t";
	print $edge{$nextNode};
	if ($edge{$nextNode} =~ /^dummy/) { # found a dummy
	    $dummies++;
	    print " (" . $dummies . ")";
	}
	print "\n";
	$visited{$nextNode} = "1"; # mark this node as 'visited'
	$nextNode = $edge{$nextNode}; # advance to the next node in the cycle
	if ($nextNode eq $startNode) { # we've come to the end of the cycle because we're looking at the startNode again.
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



