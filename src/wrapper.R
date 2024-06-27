library('optparse')
library('spatialGE')

# Parse the command line options
parser = OptionParser()
parser <- add_option(parser, c("-f", "--file"), type = 'character', help = "input.file")
parser <- add_option(parser, c("-g", "--genesets"),  type = 'character', help = "gene.sets.database")
parser <- add_option(parser, c("-p", "--permutations"),  type = "integer", help = "permutations")
parser <- add_option(parser, c("-r", "--seed"),  type = "integer", help = "random.seed")
parser <- add_option(parser, c("-s", "--spots"),  type = "integer", help = "minimum.spots")
parser <- add_option(parser, c("-m", "--genes"),  type = "integer", help = "minimum.genes")
parser <- add_option(parser, c("-d", "--deviations"),  type = "double", help = "standard.deviations")
args <- parse_args(parser)

# Load the RDS file
data <- readRDS(args$file)

# Load the gene sets
raw_file = readLines(args$genesets)
gene_sets <- lapply(raw_file, function(i) {
    pw_tmp = unlist(strsplit(i, split='\\t'))
    pw_name_tmp = pw_tmp[1]
    pw_genes_tmp = pw_tmp[-c(1:2)]
    return(list(pw_name=pw_name_tmp,
                pw_genes=pw_genes_tmp))
})
pws_names = c()
for(i in 1:length(gene_sets)) {
    pws_names = append(pws_names, gene_sets[[i]][['pw_name']])
    gene_sets[[i]] = gene_sets[[i]][['pw_genes']]
}
names(gene_sets) = pws_names

# Call STenrich
stenrich_out <- STenrich(data,
    gene_sets=gene_sets,
    reps=args$permutations,
    seed=args$seed,
    min_units=args$spots,
    min_genes=args$genes,
    num_sds=args$deviations)
#    cores=1)

# Write dataframes to disk
for (i in seq_along(stenrich_out)) {
    write.csv(stenrich_out[[i]], file = paste0(names(stenrich_out)[i], ".csv"), row.names = F)
}