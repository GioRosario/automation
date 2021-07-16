#!/bin/bash

bash -lc 'conda activate ${env_name} && conda remove perl --force -y && \
    while read requirement;do conda install --yes ${channels} --override-channels ${requirement};done < /requirements.txt && \
    mkdir /build && \
    conda env export -n ${env_name} -f /build/${env_name}.yml ${channels} --override-channels && \
    conda-pack -o /build/${env_name}.tar.gz && \
    openssl sha256 /build/${env_name}.tar.gz > /build/${env_name}-sha256sum.txt && \
    chmod -v 664 /build/${env_name}[.-]* && \
    conda deactivate'
