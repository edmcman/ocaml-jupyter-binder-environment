FROM ocaml/opam:ubuntu-20.10-ocaml-4.06

RUN sudo -E apt-get -y install pkg-config libgmp-dev libzmq3-dev m4 zlib1g-dev python3-pip libcairo2-dev libgsl-dev libfftw3-dev liblapacke-dev libopenblas-dev libblas-dev liblapack-dev
RUN sudo -E pip3 install --upgrade pip
# Install jupyter
RUN sudo -E pip3 install notebook nbgitpuller

# Install the OCaml jupyter kernel
RUN opam install -y jupyter
RUN eval $(opam env) && ocaml-jupyter-opam-genspec
RUN sudo jupyter kernelspec install --name ocaml-jupyter "$(sudo -E -u opam opam var share)/jupyter"
#RUN sudo echo /home/opam/.opam/4.06/share/jupyter $(sudo -E -u opam opam var share)/jupyter
#RUN jupyter kernelspec list
#RUN sudo -E jupyter kernelspec list

RUN echo '#use "topfind";;' > /home/opam/.ocamlinit

# Install these for the demo notebook
RUN opam install -y cairo2 archimedes owl gsl jupyter-archimedes slap fftw3 Core core

COPY --chown=opam . /home/opam
