FROM continuumio/miniconda3:latest

MAINTAINER Jeremy Volkening <jdv@base2bio.com>

# Install dependencies
WORKDIR /nf
COPY environment.yml .

# procps provides 'ps' for nextflow
RUN apt-get update && apt-get install -y \
      procps \
      vim \
    && conda env create -f environment.yml \
    && rm -rf /opt/conda/pkgs/* \
    && rm -rf /nf \
    && useradd -m -U nf


# Create regular user
USER nf
WORKDIR /home/nf/

# activate the conda environment
ENV PATH /opt/conda/envs/nf/bin:$PATH
ENV CONDA_PREFIX /opt/conda/envs/nf

# set entrypoint
CMD [ "/bin/bash" ]
