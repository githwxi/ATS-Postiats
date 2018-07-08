
## Using ATS-Postiats from a git repo-build


From your ATS-Postiats root directory (NOT this directory)

1.  Clone the ATS-Postiats repo to a desired location
2. `nix-shell nix/shell.nix`
3. `make -f Makefile_devl all`
4.  confirm `patscc` is on your path, and that `PATSHOME` is set!
