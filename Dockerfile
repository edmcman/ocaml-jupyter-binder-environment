FROM ocaml/opam:ubuntu-20.10-ocaml-4.06

RUN sudo -E apt-get -y install pkg-config libgmp-dev libzmq3-dev m4 zlib1g-dev python3-pip libcairo2-dev #libgsl-dev libfftw3-dev liblapacke-dev libopenblas-dev libblas-dev liblapack-dev
RUN sudo -E pip3 install --upgrade pip
# Install jupyter
RUN sudo -E pip3 install notebook nbgitpuller

# removed: owl gsl jupyter-archimedes slap fftw3 Core core

# Install the OCaml jupyter kernel
RUN opam install -y jupyter
RUN eval $(opam env) && ocaml-jupyter-opam-genspec
RUN echo "$(opam var share)"
RUN sudo -E jupyter kernelspec install --name ocaml-jupyter "$(opam var share)/jupyter"

RUN echo '#use "topfind";;' > /home/opam/.ocamlinit

# Install these for the demo notebook
RUN opam install -y cairo2 archimedes

COPY --chown=opam . /home/opam
