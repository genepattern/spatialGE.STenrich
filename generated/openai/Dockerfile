FROM bioconductor/bioconductor_docker:RELEASE_3_14

RUN R -e "BiocManager::install('spatialGE')" && \
    R -e "install.packages('getopt')" && \
    R -e "install.packages('optparse')"

ADD wrapper.R /home/wrapper.R
