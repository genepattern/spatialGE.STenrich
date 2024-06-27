#!/usr/bin/env Rscript

# Load necessary libraries
library(devtools)
library(spatialGE)

# Parse command line arguments
args <- commandArgs(trailingOnly = TRUE)
if (length(args) < 2) {
  stop("Usage: Rscript run_STenrich.R <input_file> <output_file>")
}

input_file <- args[1]
output_file <- args[2]

# Load the input data
data <- readRDS(input_file)

# Run the STenrich analysis
results <- STenrich(data)

# Save the results to the output file
saveRDS(results, output_file)

cat("STenrich analysis completed successfully.\n")
