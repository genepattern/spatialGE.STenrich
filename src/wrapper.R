library('optparse')
library('spatialGE')

# Parse the command line options
parser = OptionParser()
parser <- add_option(parser, "-f", type = 'character', help = "input.file")
parser <- add_option(parser, "-g", type = 'character', help = "gene.sets.database")
parser <- add_option(parser, "-p", type = "integer", help = "permutations")
parser <- add_option(parser, "-r", type = "integer", help = "random.seed")
parser <- add_option(parser, "-s", type = "integer", help = "minimum.spots")
parser <- add_option(parser, "-m", type = "integer", help = "minimum.genes")
parser <- add_option(parser, "-d", type = "double", help = "standard.deviations")
args <- parse_args(parser)

# Load the RDS file
data <- readRDS(args$f)

# Load the gene sets
raw_file = readLines(args$g)
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
    reps=args$p,
    seed=args$s,
    min_units=args$s,
    min_genes=args$m,
    num_sds=args$d)
#    cores=1)

# Write dataframes to disk
for (i in seq_along(stenrich_out)) {
    write.csv(stenrich_out[[i]], file = paste0(names(stenrich_out)[i], ".csv"), row.names = F)
}