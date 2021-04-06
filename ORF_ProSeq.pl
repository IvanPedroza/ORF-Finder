#!/usr/bin/perl
# ORF_Find.txt -> finds long orfs in a DNA sequence
use feature "switch";

open (CHROM, "chr03.pl");	# Open file chr03.pl containing yeast chromosome 3
$DNA = "";				# start with an empty DNA sequence
$header = <CHROM>;		# Get header of sequence

# Read a line from the file, join to end of $DNA, and then repeat until end of file
while ( $current_line = <CHROM> )
{
	chomp($current_line);		# remove newline from end of current_line
	$DNA = $DNA . $current_line;
}

# length of DNA sequence
$DNA_length = length($DNA);

# flag for ORF finder
$inORF = 0;

# number of ORFs found
$numORFs = 0;

# minimum length of ORF
$minimum_codons = 100;

$ORF_length = 0;

# Holds amino Sequence
$amino_seq = "";

# search each reading frame (+1, +2, +3)
for ( $frame = 0; $frame < 3; $frame++ )
{
	print "\nFinding ORFs in frame: +" . ($frame + 1) . "\n";

	# Search for sequence match and print position of match if found.
	for ($i = $frame; $i <= ($DNA_length - 3); $i += 3)
	{
		# get current codon from DNA sequence
		$codon = substr( $DNA, $i, 3 );

		# If not in ORF search for ATG, else search for stop codon
		if ( $inORF == 0 )
		{
			# If current codon is an ATG, start ORF
			if ( $codon eq "ATG")
			{
				$inORF = 1;
				$ORF_length = 1;
				$ORF_start = $i;
			}
		}
		elsif ( $inORF == 1 )
		{
            $amino = "";
            given ($codon) {
                when (/(ATG)/) { $amino = "M" }
                when (/(TTT)|(TTC)/) { $amino = "F" }
                when (/(TTA)|(TTG)/) { $amino = "L" }
				when (/(CTT)|(CTC)|(CTA)|(CTG)/) { $amino = "L" }
				when (/(ATT)|(ATC)|(ATA)/) { $amino = "I" }
				when (/(GTT)|(GTC)|(GTA)|(GTG)/) { $amino = "V" }
				when (/(TCT)|(TCC)|(TCA)|(TCG)/) { $amino = "S" }
				when (/(CCT)|(CCC)|(CCA)|(CCG)/) { $amino = "P" }
				when (/(ACT)|(ACC)|(ACA)|(ACG)/) { $amino = "T" }
				when (/(TAT)|(TAC)/) { $amino = "Y" }
				when (/(CAT)|(CAC)/) { $amino = "H" }
				when (/(CAA)|(CAG)/) { $amino = "Q" }
				when (/(AAT)|(AAC)/) { $amino = "N" }
				when (/(AAA)|(AAG)/) { $amino = "K" }
				when (/(GAT)|(GAC)/) { $amino = "D" }
				when (/(GAA)|(GAG)/) { $amino = "E" }
				when (/(TGT)|(TGC)/) { $amino = "C" }
				when (/(TGG)/) { $amino = "W" }
				when (/(CGT)|(CGC)|(CGA)|(CGG)/) { $amino = "R" }
				when (/(AGT)|(AGC)/) { $amino = "S" }
				when (/(AGA)|(AGG)/) { $amino = "R" }
				when (/(GCT)|(GCC)|(GCA)|(GCG)/) { $amino = "A" }
				when (/(GGT)|(GGC)|(GGA)|(GGG)/) { $amino = "G" }
            }
            $amino_seq = ($amino_seq . $amino);
			
			# If current codon is a stop codon (TGA, TAA, TAG), end ORF
			if ( $codon eq "TGA" | $codon eq "TAG" | $codon eq "TAA" )
			{
				#If ORF has at least minimum num. of codons, print location
				if ( $ORF_length >= $minimum_codons )
				{
					print "Found ORF at position $ORF_start,";
					print " length = $ORF_length\n";
                    print "Amino Acid Sequence: M$amino_seq\n";
					$numORFs++;
				}
				# reset ORF variables
				$inORF = 0;
				$ORF_length = 0;
                $amino_seq = "";
			}
			else
			{
				# Increase length of ORF by one codon
				$ORF_length++;
			}
		}

	}
}
# If no ORFS are found, print message
if ( $numORFs == 0)
{
	print ("No ORFs found\n");
}
else
{
	print ("\n$numORFs ORFs were found\n");
}
