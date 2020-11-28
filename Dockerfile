FROM ocaml/opam:ubuntu-20.10-ocaml-4.06

RUN sudo apt-get -y install pkg-config libgmp-dev libzmq3-dev m4 zlib1g-dev python3-pip
RUN sudo pip3 install --upgrade pip
# Install jupyter
RUN sudo pip3 install notebook nbgitpuller
# Install the OCaml jupyter kernel
RUN opam install -y jupyter
RUN eval $(opam env) && ocaml-jupyter-opam-genspec
RUN sudo jupyter kernelspec install --name ocaml-jupyter /home/opam/.opam/4.06/share/jupyter

COPY --chown=opam . /home/opam