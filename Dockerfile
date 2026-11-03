FROM cschranz/gpu-jupyter:v1.10_cuda-12.9_ubuntu-24.04

# 1. Install system packages
USER root
RUN apt-get update && apt-get -y install apt-utils

# 2. Install Python packages
RUN pip install qutip matplotlib seaborn qutip-qip 

# 3. Keep the default user or set a GENERIC one (e.g., 'researcher')
# Do not use 'darsh' or any specific person's name here.
ENV NB_USER=researcher
ENV NB_UID=1000
ENV HOME=/home/${NB_USER}

# Rename default user to generic 'researcher'
RUN usermod -l ${NB_USER} -d ${HOME} -m jovyan && \
    chown -R ${NB_USER}:users ${HOME}

WORKDIR ${HOME}

# Start as the internal generic user
USER ${NB_UID}
