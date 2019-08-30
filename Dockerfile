FROM jupyter/datascience-notebook

LABEL maintainer="Chris Fonnesbeck <fonnesbeck@gmail.com>"

USER root

# for dynamic linking to the development version of theano
RUN apt-get update && \
    apt-get install -y --no-install-recommends libatlas-base-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER $NB_USER 

RUN conda install --quiet --yes numpy pandas scikit-learn

RUN pip install git+https://github.com/Theano/Theano.git
COPY config/.theanorc "$HOME"/.theanorc 
RUN pip install git+https://github.com/pymc-devs/pymc3

RUN pip install pystan

RUN pip install black

RUN pip install dash dash-renderer dash-html-components dash-core-components
RUN pip install bokeh altair seaborn
RUN pip install tf-nightly tfp-nightly

RUN conda install --quiet --yes basemap dask
RUN conda install -c conda-forge geopandas
RUN conda install --quiet --yes \
    boto \
    pyqt \
    toolz \
    xlrd

# Import matplotlib the first time to build the font cache.
RUN python -c "import matplotlib.pyplot"
