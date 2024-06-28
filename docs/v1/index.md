# spatialGE.STenrich (v1)

Detect genes showing spatial expression patterns (e.g., hotspots). Tests if spots/cells with high average expression of a gene set shows evidence of spatial aggregation.

**Authors**: Thorin Tabor; UCSD - Mesirov Lab

**Contact**: [Forum Link](https://groups.google.com/forum/?utm_medium=email&utm_source=footer#!forum/genepattern-help)

**Algorithm Version**: [spatialGE 1.2.0](https://fridleylab.github.io/spatialGE/)

## Summary

The package [spatialGE](https://fridleylab.github.io/spatialGE/) can be used to detect spatial patterns in gene expression at the gene and gene set level. Data from multiple spatial transcriptomics platforms can be analyzed, as long as gene expression counts per spot or cell are associated with spatial coordinates of those spots/cells.

This module accepts an RDS file containing a normalized STlist object, such as output by the [spatialGE.Preprocessing](https://github.com/genepattern/spatialGE.Preprocessing) module.

Each row of the output CSV files represents a test for the null hypothesis of no spatial aggregation in the expression of the set in the “gene_set” column. The column “size_test” is the number of genes of a gene set that were present in the FOV. The larger this number the better, as it indicates a better representation of the gene set in the sample. The “adj_p_value” is the multiple test adjusted p-value, which is the value used to decide if a gene set shows significant indications of a spatial pattern (adj_p_value < 0.05).

## References

Ospina, O. E., Wilson C. M., Soupir, A. C., Berglund, A. Smalley, I., Tsai, K. Y., Fridley, B. L. 2022. spatialGE: quantification and visualization of the tumor microenvironment heterogeneity using spatial transcriptomics. Bioinformatics, 38:2645-2647. https://doi.org/10.1093/bioinformatics/btac145

## Source Links
* [The GenePattern ExampleModule v2 source repository](https://github.com/genepattern/ExampleModule/tree/v2)
* ExampleModule v2 uses the [genepattern/example-module:2 Docker image](https://hub.docker.com/layers/150060459/genepattern/example-module/2/images/sha256-ae4fffff67672e46b251f954ad226b7ad99403c456c1c19911b6ac82f1a27f2f?context=explore)
* [The Dockerfile used to build that image is here.](https://github.com/genepattern/ExampleModule/blob/v2/Dockerfile)

## Parameters
<!-- short description of the module parameters and their default values, as well as whether they are required -->

| Name                 | Description                                                                                                                                                                              | Default Value |
----------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------|
| input file *         | Normalized spatial transcriptomics data coming from the spatialGE.Preprocessing module.                                                                                                  |
| gene sets database * | Select a gene set database to test for spatial enrichment. Upload a gene set if your gene set is not listed as a choice from MSigDB.                                                     |               |
| permutations *       | The number of permutations to estimate the null distribution (no-spatial pattern). The more permutations, the longer STenrich takes to complete, but p-values may be more accurate.      | 100           |
| random seed *        | A seed number to replicate results. It is advisable to run STenrich with different seed values to check for consistency. Different seed values could yield slightly different p-values. | 12345         |
| minumum spots * | The minimum number of high expression ROIs/spots/cells required for a gene set to be tested. If a sample has less than this number of high expression ROIs/spots/cells, the gene set is not tested in that sample. | 5 |
| minimum genes * | The minimum number of genes of a set required to be present in a sample, for that gene set to be tested in that sample. If a sample has less genes of a set than this number, the gene set is ignored in that sample. | 5 |
| standard deviations * | The number of standard deviations to define the high expression threshold. If an ROI/spot/cell has average gene set expression larger than the entire sample average plus this many standard deviations, it will be considered a high-expression ROI/spot/cell. | 1.0 |
| filter p values * | Plot only gene sets whose multiple test adjusted p-value is less than this threshold. | 0.05 |
| filter gene proportion * | Plot only gene sets where the proportional number genes in the set present in the field of view equals or exceeds this threshold. | 0.3 |

\*  required

## Input Files
1. input.file  
   Accepts an RDS file containing a normalized STlist object, such as output by the [spatialGE.Preprocessing](https://github.com/genepattern/spatialGE.Preprocessing) module.

    
## Output Files
1. **\*.csv**  
   Each row of the output CSV files represents a test for the null hypothesis of no spatial aggregation in the expression of the set in the “gene_set” column. The column “size_test” is the number of genes of a gene set that were present in the FOV. The larger this number the better, as it indicates a better representation of the gene set in the sample. The “adj_p_value” is the multiple test adjusted p-value, which is the value used to decide if a gene set shows significant indications of a spatial pattern (adj_p_value < 0.05).
2. **genes_in_fov.png**  
    A visual summary of the gene sets with an adjusted p-value below the specified threshold and with the number of genes of a gene set that were present in the FOV being equal to or greater than the specified proportion.

## Example Data
<!-- provide links to example data so that users can see what input & output should look like and so that they and we can use it to test -->

Input:  
[lung.rds](https://github.com/genepattern/spatialGE.STenrich/blob/main/data/lung.rds)

## Requirements

Requires the [genepattern/spatialge-stenrich:0.4 Docker image](https://hub.docker.com/layers/genepattern/spatialge-stenrich/0.4/images/sha256-11d9de50d721c27fd02edd8f65f0bd17fe4d5e8ea7c99b13236b8daf092c2c10?context=explore).

## License

`spatialGE.STenrich` is distributed under a BSD-style license available at [https://github.com/genepattern/spatialGE.STenrich/blob/main/LICENSE.](https://github.com/genepattern/spatialGE.STenrich/blob/main/LICENSE)

## Version Comments

| Version | Release Date  | Description                       |
----------|---------------|-----------------------------------|
| 1 | June 28, 2024 | Initial version |