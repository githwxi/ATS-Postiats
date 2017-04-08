#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"

#define ATS_DYNLOADFLAG 0

(* 
  Perhaps we can have a package or module system that generates an
  object file including all the needed symbols for a project in a
  standard file.
  
  For example, we are using the json-c ATS2 bindings in this project,
  yet I need to compile all the needed dats files in order to use it.
  The easiest thing to do now is the following, we just use the
  preprocessor to include all the needed symbols in this file, compile
  it, and then link it into our program. This is far from convenient
  and would get incredibly messy and difficult to maintain as more
  external libraries are used.
  
  Instead, we could require a manifest that outlines what libraries
  are used in a project and then develop a tool that generates a file
  like this. Perhaps such a manifest could look something like this.
  
      {
        "project-name": "constraint-solver",
        "required-packages": "json-c",
        "repositories": "contrib",
      }
  
  The default "repository" would simply be contrib, but you can imagine
  remote repos such as websites, git repos, and others could be given as
  well. In this case, things like "contrib" or "libats" would be default
  repositories. Suppose we save the json object above into something like
  manifest.json. A program could read this and set up and manage our 
  "project_libs.dats" file for us.
*)

local
  #include "{$JSONC}/DATS/json.dats"
  #include "{$JSONC}/DATS/json_ML.dats"
in
end