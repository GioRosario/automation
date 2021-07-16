FROM quay.io/condaforge/linux-anvil-comp7:latest as build

ENV PATH="opt/conda/bin/:$PATH"
ENV env_name="nsls2-analysis-2021-1.2"
ENV python_version="3.7"
ENV pkg=""
ENV extra_packages="nsls2-analysis=2021C1.2=*_1"
ENV channels="-c nsls2forge -c defaults"
ENV OMPI_MCA_opal_cuda_support=true

RUN yum install curl mesa-libGL -y && yum clean all && \
    conda config --set allow_conda_downgrades true && \
    conda install conda -y && \
    conda create -n ${env_name} ${channels} --override-channels -y python=${python_version} conda-pack ${pkg} ${extra_packages} && \
    conda init "bash"

RUN bash -lc "conda activate ${env_name} && conda remove perl --force -y"
