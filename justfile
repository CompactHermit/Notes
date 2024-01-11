# NOTE:: Typst is already wrapped by default
# NOTE:: Overly engineered, just to look cool .....

####################################################################################################
# VARIABLES::

open := "TODO!"
project_dir   := justfile_directory()
typst_version := "typst -V"
project_name  := file_stem(justfile_directory())
####################################################################################################

####################################################################################################
# COMMANDS::

@default:
	@just --choose


@info:
	echo "Environment Informations\n------------------------\n"
	echo "    OS          : NixOS::({{arch()}}){{os()}}"
	echo "    Open        : {{open}}"
	echo "    Typst       : `{{typst_version}}`"
	echo "    Projectdir  : {{project_dir}}"
	echo "    Projectname : {{project_name}}"


@show:
	echo "Buildable Projects::"
	echo "    test        :  SANITY TEST (Univalent)            [Testing]"
	echo "    hott        :  Homotopy Type Theory (Univalent)   [Self Study]"
	echo "    abs         :  Abstract Algebra (Dummit & Footes) [Course Notes]"
	echo "    anal1       :  Analysis (Rudins)                  [Course Notes]"
	echo "    alg         :  Algebra (Serge Grad. Algebra)      [Self Study]"
	echo "    cat         :  Category Theory (MacLane/Avodey)   [Self Study] "
####################################################################################################
# FUNCTIONS::

test:
	typst compile --root ./src ./src/test/main.typ ./main.pdf


Homotopy_Type_Theory:
	typst compile --root ./src ./src/HoTT/main.typ ./main.pdf

Abstract_Algebra:
	typst compile --root ./src ./src/Abs_Alg/main.typ ./main.pdf

Analysis_1:
	typst compile --root ./src ./src/Analysis/Anal/main.typ ./main.pdf

watch: 
	typst watch --root ./. ./src/test/main.typ 	./target/test/main.pdf
##################################################
##### Aliases ####
alias hott := Homotopy_Type_Theory
alias abs := Abstract_Algebra
alias anal1 := Analysis_1

## vim: ft=make
