#!/usr/bin/env Rscript

# Load necessary libraries
library(devtools)
library(spatialGE)

# Function to parse command line arguments
parse_args <- function() {
  args <- commandArgs(trailingOnly = TRUE)
  if (length(args) < 2) {
    stop("Usage: script.R <input_file> <output_file>")
  }
  list(input_file = args[1], output_file = args[2])
}

# Main function to run STenrich analysis
run_STenrich <- function(input_file, output_file) {
  # Load the input data
  data <- readRDS(input_file)

  # Run the STenrich analysis
  result <- STenrich(data)

  # Save the result to the output file
  saveRDS(result, output_file)
}

# Parse the command line arguments
args <- parse_args()

# Run the STenrich analysis with the provided arguments
run_STenrich(args$input_file, args$output_file)
