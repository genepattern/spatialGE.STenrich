FROM bioconductor/bioconductor_docker:RELEASE_3_14

RUN R -e "BiocManager::install('spatialGE')" \
    && R -e "install.packages(c('getopt', 'optparse'))"

ADD wrapper.R /home/wrapper.R