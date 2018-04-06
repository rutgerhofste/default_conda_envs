FROM rutgerhofste/docker_conda_jupyter:latest
MAINTAINER Rutger Hofste <rutgerhofste@gmail.com>

RUN apt-get update && \
	apt-get -y install \
	dialog \
	apt-utils \
	libffi-dev \
	libssl-dev  
  
# Docker uses POSIX which causes conflicts with TMUX, install en_US locale UTF-8
RUN apt-get install --reinstall -y locales
RUN sed -i 's/# en_US.UTF-8 en_US.UTF-8/en_US.UTF-8-8 UTF-8/' /etc/locale.gen 
RUN locale-gen en_US.UTF-8 
RUN apt-get install tmux -y

# Create python virtualenv in Conda
RUN conda create -n python27 python=2.7 jupyter -y
RUN conda create -n python35 python=3.5 jupyter -y
RUN conda create -n python36 python=3.6 jupyter -y
RUN conda create -n python36arc python=3.6 jupyter -y

# Installing KernelSpecs
RUN /opt/anaconda3/envs/python27/bin/python -m ipykernel install --name python27 --display-name "Python 27"
RUN /opt/anaconda3/envs/python35/bin/python -m ipykernel install --name python35 --display-name "Python 35"
RUN /opt/anaconda3/envs/python36/bin/python -m ipykernel install --name python36 --display-name "Python 36"
RUN /opt/anaconda3/envs/python36arc/bin/python -m ipykernel install --name python36arc --display-name "Python 36 Arc"

