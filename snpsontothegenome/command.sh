##require
## faidx
#sudo pip3 install pyfaidx
##bedtools
#sudo apt-get install bedtools
## bdops
#wget https://github.com/bedops/bedops/releases/download/v2.4.35/bedops_linux_x86_64-v2.4.35.tar.bz2
#tar jxvf bedops_linux_x86_64-v2.4.35.tar.bz2 
#sudo cp bin/* /usr/local/bin

## global variables
GENOME_FASTA="genomes/sar_genome_lgt6000.fasta"
VCF_INIT="/media/superdisk/reservebenefit/working/rerun1/snakemake_stacks2/06-populations/iter3/diplodus/populations.snps.vcf"
SPECIES="diplodus"

GENOME_FASTA="genomes/mullus_genome_lgt6000.fasta"
VCF_INIT="/media/superdisk/reservebenefit/working/rerun1/snakemake_stacks2/06-populations/iter4/mullus/populations.snps.vcf"
SPECIES="mullus"

GENOME_FASTA="genomes/serran_genome_lgt3000.fasta"
VCF_INIT="/media/superdisk/reservebenefit/working/rerun1/snakemake_stacks2/06-populations/iter2/serran/populations.snps.vcf"
SPECIES="serran"



## shuf 30 individuals subsample
shuf -n 30 /media/superdisk/reservebenefit/working/rerun1/snakemake_stacks2/01-info_files/"$SPECIES"_population_map.txt | awk '{ print $1}' > "$SPECIES"_indv.txt
vcftools --vcf "$VCF_INIT" --keep "$SPECIES"_indv.txt --recode --recode-INFO-all --out "$SPECIES"_subset30
VCF_FILTERED="$SPECIES"_subset30.recode.vcf

## convert genome FASTA into BED format
faidx --transform bed $GENOME_FASTA > "$SPECIES"_genome.bed
sort -k 3 -nr "$SPECIES"_genome.bed > "$SPECIES"_genome.sort.bed
## decompose genome into SLIDING WINDOWS
bedtools makewindows -b "$SPECIES"_genome.sort.bed -w 400000 > "$SPECIES"_genome.win.sort.bed

## convert VCF into BED format
vcf2bed < $VCF_FILTERED > "$SPECIES"_pop.snps.bed
## coverage value for each window
bedtools coverage -a "$SPECIES"_genome.win.sort.bed -b "$SPECIES"_pop.snps.bed > "$SPECIES"_coverage.bed


## mean depth
vcftools --site-mean-depth --vcf $VCF_FILTERED --out "$SPECIES"
#### remove header
tail -n +2 "$SPECIES".ldepth.mean > "$SPECIES"_depth


## genotype depth
vcftools --geno-depth --vcf $VCF_FILTERED --out "$SPECIES"
####### convert into .bed
paste <(tail -n +2 "$SPECIES".gdepth | awk '{print $1"\t"($2-1)"\t"$2}') <(tail -n +2 "$SPECIES".gdepth | cut -f 3-) | sed 's/-1/NA/g' | sed 's/-/NA/g' > "$SPECIES".gdepth.bed
######### attribute genome windows to each loci
bedtools intersect -wa -wb \
    -a "$SPECIES"_genome.win.sort.bed \
    -b "$SPECIES".gdepth.bed > "$SPECIES"_meandepth.bed