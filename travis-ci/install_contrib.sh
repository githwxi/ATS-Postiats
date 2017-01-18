#!/usr/bin/env sh

git clone https://github.com/githwxi/ATS-Postiats-contrib

echo "Skip the build until it is fixed."

# ######
# #
# # For parsing constraints 
# #
# (cd ${PATSHOMERELOC}/projects/MEDIUM/ATS-extsolve && make DATS_C)
# #
# # For building patsolve_z3
# (cd ${PATSHOMERELOC}/projects/MEDIUM/ATS-extsolve/ATS-extsolve-z3 && make build)
# (cd ${PATSHOMERELOC}/projects/MEDIUM/ATS-extsolve/ATS-extsolve-z3 && mv -f patsolve_z3 ${PATSHOME}/bin)
# #
# # For building patsolve_smt2
# (cd ${PATSHOMERELOC}/projects/MEDIUM/ATS-extsolve/ATS-extsolve-smt2 && make build)
# (cd ${PATSHOMERELOC}/projects/MEDIUM/ATS-extsolve/ATS-extsolve-smt2 && mv -f patsolve_smt2 ${PATSHOME}/bin)
# #
# ######
# #
# # For parsing C code
# # generated from ATS source
# #
# (cd ${PATSHOMERELOC}/projects/MEDIUM/CATS-parsemit && make DATS_C)
# #
# # For building atscc2js
# #
# (cd ${PATSHOMERELOC}/projects/MEDIUM/CATS-atsccomp/CATS-atscc2js && make build)
# (cd ${PATSHOMERELOC}/projects/MEDIUM/CATS-atsccomp/CATS-atscc2js && mv -f atscc2js ${PATSHOME}/bin)
# (cd ${PATSHOMERELOC}/contrib/libatscc/libatscc2js && make all && make all_in_one)
# #
# # For building atscc2py3
# #
# (cd ${PATSHOMERELOC}/projects/MEDIUM/CATS-atsccomp/CATS-atscc2py3 && make build)
# (cd ${PATSHOMERELOC}/projects/MEDIUM/CATS-atsccomp/CATS-atscc2py3 && mv -f atscc2py3 ${PATSHOME}/bin)
# (cd ${PATSHOMERELOC}/contrib/libatscc/libatscc2py3 && make all && make all_in_one)
# #
# # For building atscc2scm
# #
# (cd ${PATSHOMERELOC}/projects/MEDIUM/CATS-atsccomp/CATS-atscc2scm && make build)
# (cd ${PATSHOMERELOC}/projects/MEDIUM/CATS-atsccomp/CATS-atscc2scm && mv -f atscc2scm ${PATSHOME}/bin)
# (cd ${PATSHOMERELOC}/contrib/libatscc/libatscc2scm && make all && make all_in_one)
# #
# # For building atscc2clj
# #
# (cd ${PATSHOMERELOC}/projects/MEDIUM/CATS-atsccomp/CATS-atscc2clj && make build)
# (cd ${PATSHOMERELOC}/projects/MEDIUM/CATS-atsccomp/CATS-atscc2clj && mv -f atscc2clj ${PATSHOME}/bin)
# (cd ${PATSHOMERELOC}/contrib/libatscc/libatscc2clj && make all && make all_in_one)
# #
# # For building atscc2erl
# #
# (cd ${PATSHOMERELOC}/projects/MEDIUM/CATS-atsccomp/CATS-atscc2erl && make build)
# (cd ${PATSHOMERELOC}/projects/MEDIUM/CATS-atsccomp/CATS-atscc2erl && mv -f atscc2erl ${PATSHOME}/bin)
# (cd ${PATSHOMERELOC}/contrib/libatscc/libatscc2erl && make all && make all_in_one)
# (cd ${PATSHOMERELOC}/contrib/libatscc/libatscc2erl/Session && make all && make all_in_one)