# ORF Finder Perl Script

## Introduction

This Perl script is designed to search for and identify Open Reading Frames (ORFs) in a DNA sequence. It works by reading a DNA sequence from a file, searching for start codons (ATG), and then identifying stop codons (TGA, TAA, TAG) to determine ORF locations and lengths. If an ORF has at least a minimum number of codons (defined by the `$minimum_codons` variable), the script will print its position, length, and the corresponding amino acid sequence.

## Prerequisites

- **Perl**: Ensure that you have Perl installed on your system.
- **DNA Sequence**: You need a DNA sequence file to analyze. In the script, it attempts to open and read from a file named `chr03.pl`. Make sure you have this file or replace it with the name of your DNA sequence file.

## Usage

1. Save your DNA sequence to a file (e.g., `chr03.pl`), or modify the script to point to the correct file.
2. Open your terminal or command prompt.
3. Navigate to the directory where the script is located.
4. Run the script using the following command: `perl ORF_Find.txt`

## Script Explanation

- The script begins by opening the DNA sequence file and reading the sequence into a variable.
- It then searches for ORFs in all three reading frames (frame +1, +2, and +3). The start codon (ATG) initiates the search for an ORF, and stop codons (TGA, TAA, TAG) mark the end of the ORF.
- If an ORF is found with at least the minimum number of codons specified by the `$minimum_codons` variable, the script will print its position, length, and the corresponding amino acid sequence.
- If no ORFs are found, the script will print a message indicating that no ORFs were found.

## License

This project is licensed under the [MIT LICENSE](https://github.com/IvanPedroza/ORF-Finder/blob/main/LICENSE.md).

