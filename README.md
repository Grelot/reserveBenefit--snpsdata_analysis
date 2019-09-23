<a href="https://www.biodiversa.org/1023"><img align="right" width="100" height="100" src="reservebenefit.jpg"></a>

# Codes for the paper : "Genomic resources for Mediterranean fishes"

[![https://www.singularity-hub.org/static/img/hosted-singularity--hub-%23e32929.svg](https://www.singularity-hub.org/static/img/hosted-singularity--hub-%23e32929.svg)](https://singularity-hub.org/collections/3566)

_______________________________________________________________________________



#### Pierre-Edouard Guerin, Stephanie Manel

Montpellier, 2017-2019

Submited to Molecular Ecology Ressources, 2019


_______________________________________________________________________________

# Prerequisites

## Softwares

- [R Version 3.6.0](https://cran.r-project.org/)
	* R packages: ggplot2, plyr, reshape, gridExtra

- [faidx](http://www.htslib.org/doc/faidx.html)

- [bedtools](https://bedtools.readthedocs.io/en/latest/)

- [vcftools](http://vcftools.sourceforge.net/)

- [samtools](http://www.htslib.org/download/)

- [htslib](http://www.htslib.org/download/)

- [bcftools](http://www.htslib.org/download/)



## Singularity container

See https://www.sylabs.io/docs/ for instructions to install Singularity.

#### Download the container

```
singularity pull --name snpsdata_analysis.simg shub://Grelot/.................
```

#### Run the container

```
singularity run snpsdata_analysis.simg
```