FROM akabe/ocaml-jupyter-datascience:debian8_ocaml4.05.0

RUN sudo pip3 install --upgrade pip
RUN sudo pip3 install nbgitpuller

COPY --chown=opam . /home/opam
