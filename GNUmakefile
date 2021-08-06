# Constants / make settings  {{{1

.ONESHELL:
_MAKEFILE := $(abspath $(lastword $(MAKEFILE_LIST)))


# Configuration  {{{1

_include_dirs := . _config
_exclude_ere := '(^(_|@|\.)|([Mm]akefile|\.md|\.txt|\.swp|~)$$)'


.PHONY: help  # {{{1
help:
	@printf '%s\n' \
	"Usage: $(notdir ${MAKE}) {TARGET}" \
	"Targets:" \
	"  install         Installs symlinks to the configuration files/directories" \
	"                  to \$$HOME" \
	"  dry-run, dry    Lists which commands would be run by \`install\`" \
	"  list, ls        Lists which symlinks would be installed to an empty \$$HOME" \
	"  find-role-dirs  Lists all matching role directories relative to this Makefile" \
	;


.PHONY: install  # {{{1
install: dry_run := 0
install: list := 0
install: _dirs := $(patsubst ./*,*,$(addsuffix /*,${_include_dirs}))
install:
	@set -e
	
	old_ifs=$$IFS
	IFS='
	'
	for i in $$(make -s -f "${_MAKEFILE}" _find_targets); do
	 make -s -f "${_MAKEFILE}" _install_link \
	  src="$$i" \
	  dry_run="${dry_run}" list="${list}"
	done
	IFS=$$old_ifs


.PHONY: dry-run  # {{{1
dry-run:
	@set -e
	make -s -f "${_MAKEFILE}" install dry_run=1

.PHONY: dry  # {{{1
dry: dry-run


.PHONY: list  # {{{1
list:
	@set -e
	make -s -f "${_MAKEFILE}" install list=1

.PHONY: ls  # {{{1
ls: list


.PHONY: find-role-dirs  # {{{1
find-role-dirs: absolute := 0
find-role-dirs: suffix := 
find-role-dirs: _ancestors := 
find-role-dirs:
	@set -e
	NEWLINE='
	'
	
	root=$(if $(filter-out 0,${absolute}),$$(cd "$$(dirname -- "${_MAKEFILE}")" && pwd)/,)
	role_dirs=
	for i in @*; do
	 if [ -d "$$i" ]; then
	  _role_name=$$(printf '%s\n' "$$(basename -- "$$i")" | sed -e '1,1s/^@//')
	  if [ -x "$$i/_if" ]; then
	   _test_cmd=
	  elif [ -f "$$i/_if" ]; then
	   _test_cmd=sh
	  else
	   _test_cmd=true
	  fi
	  if env \
	   ETC_ROLE_DIR="$(if ${_ancestors},${_ancestors}/,)$$i" \
	   ETC_ROLE_NAME="$$_role_name" \
	   $$_test_cmd "./$$i/_if" 1>&2
	  then
	   role_dirs="$$role_dirs$$NEWLINE$$root$(if ${_ancestors},${_ancestors}/,)$$i$(if ${suffix},/${suffix},)"
	   role_dirs="$$role_dirs$$NEWLINE$$(make -s -f "${_MAKEFILE}" \
	    -C "$$(pwd)/$$i" find-role-dirs _ancestors="$$i")"
	  fi
	 fi
	done
	
	role_dirs=$$(printf '%s\n' "$$role_dirs" | sed -e '/^$$/d' | sort)
	printf '%s\n' "$$role_dirs"


.PHONY: _find_targets  #{{{1
_find_targets: _dirs := $(patsubst ./*,*,$(addsuffix /*,${_include_dirs}))
_find_targets: _do_roles := 1
_find_targets: _role_dir := 
_find_targets:
	@set -e
	NEWLINE='
	'
	
	all_reversed=
	for i in ${_dirs}; do
	 if ! printf '%s\n' "$$(basename "$$i")" | egrep -q -e ${_exclude_ere}; then
	  if [ -e "$$i" ]; then
	   all_reversed="$(if ${_role_dir},${_role_dir}/,)$$i$$NEWLINE$$all_reversed"
	  fi
	 fi
	done
	if [ ${_do_roles} -ne 0 ]; then
	 for role_dir in $$(make -s -f "${_MAKEFILE}" find-role-dirs); do
	  role_targets="$$(make -s -f "${_MAKEFILE}" \
	   -C "$$(cd "$$(dirname -- "${_MAKEFILE}")" && pwd)/$$role_dir" \
	   _find_targets \
	    _do_roles=0 \
	    _role_dir="$$role_dir")"
	  all_reversed="$$role_targets$$NEWLINE$$all_reversed"
	 done
	fi
	all_reversed=$$(printf '%s\n' "$$all_reversed" | sed -e '/^$$/d')
	
	targets=
	seen_base_targets=
	old_ifs=$$IFS
	IFS=$$NEWLINE
	for target in $$all_reversed; do
	 base_target=$$(printf '%s\n' "$$target" | sed -e '1,1s|^\(@[^/]*/\)\+||')
	 if ! printf '%s\n' "$$seen_base_targets" | fgrep -q -x -e "$$base_target"; then
	  seen_base_targets="$$seen_base_targets$$NEWLINE$$base_target"
	  targets="$$target$$NEWLINE$$targets"
	 fi
	done
	IFS=$$old_ifs
	targets=$$(printf '%s\n' "$$targets" | sed -e '/^$$/d')
	printf '%s\n' "$$targets"


.PHONY: _install_link  # {{{1
_install_link: src := 
_install_link: dest := ${HOME}
_install_link: dry_run := 0
_install_link: list := 0
_install_link:
	@set -e
	
	_base_src=$$(printf '%s\n' "${src}" | sed -e '1,1s|^\(@[^/]*/\)\+||')
	_dest_prefix=$$({ printf '%s\n' "$$_base_src" | grep -q -e '^_'; } && echo || echo .)
	_link_relpath="$$_dest_prefix$$(printf '%s\n' "$$_base_src" | sed -e '1,1s/^_/./')"
	_link_path="${dest}/$$_link_relpath"
	_relpwd=$$(make -s -f "${_MAKEFILE}" _relpwd ref="${dest}")
	_root_relpwd=$$(cd "$$(dirname -- "${_MAKEFILE}")" && make -s -f "${_MAKEFILE}" _relpwd ref="${dest}")
	_dotdots=
	_target=$$_relpwd/${src}
	if printf '%s\n' "$$_target" | head -n 1 | grep -q -e '^[^/]'; then
	 _dotdots=$$(printf '%s\n' "$$_link_relpath" | sed -e 's|[^/]||g; s|/|../|g')
	 _target=$$_dotdots$$_target
	fi
	
	echo_run() {
	 echo + "$$@" >&2
	 [ x"${dry_run}" = x"1" ] && true || command "$$@"
	}
	
	if [ x"${list}" = x"1" ]; then
	 printf '%s\n' "$$_link_path -> $$_target"
	else
	 _old_target=$$(readlink "$$_link_path" 2>/dev/null || true)
	 if [ x"$$_old_target" != x"$$_target" ]; then
	  if [ -e "$$_link_path" ] || [ -h "$$_link_path" ]; then
	   if ! $$(2>/dev/null make -s -f "${_MAKEFILE}" _starts_with \
	           haystack="$$_old_target" needle="$$_dotdots$$_root_relpwd/")
	   then
	    _timestamp=$$(date -u +%Y-%m-%dT%H-%M-%S_%NZ)
	    echo_run mv "$$_link_path" "$$_link_path.$$_timestamp.bak"
	   fi
	  fi
	  if ! [ -d "$$(dirname -- "$$_link_path")" ]; then
	   echo_run mkdir -p "$$(dirname -- "$$_link_path")"
	  fi
	  echo_run ln -sf "$$_target" "$$_link_path"
	 else
	  true
	 fi
	fi


.PHONY: _starts_with  #{{{1
_starts_with: haystack := 
_starts_with: needle := 
_starts_with:
	   @set -e
	   awk \
	    -v string="$$haystack" \
	    -v starts_with="$$needle" \
	    'BEGIN { r = (index(string, starts_with)) == 1 ? 0 : 1; exit r }' >&2


.PHONY: _relpwd  # {{{1
_relpwd: path := 
_relpwd: ref := 
_relpwd:
	@set -e
	
	relpwd() {
	 if [ x"$$1" = x"-h" ] || [ x"$$1" = x"--help" ]; then
	  cat >&2 <<USAGE
	 Usage: $$(basename -- "$$0") [reference-directory]
	 
	 Prints the current working directory relative to \$$HOME or to
	 \`reference-directory\`.
	 
	 If \`reference-directory\` is a literal tilde (~), then '~/' will be
	 prepended to paths relative to \$$HOME.
	USAGE
	  return 2
	 fi
	 
	 local home arg1 pwd ref
	 
	 home="$$(cd "$$HOME" && pwd)"
	 [ $$? -ne 0 ] && return 1
	 
	 arg1="$$1"
	 if (printf '%s' "$$arg1" | grep -q -e '^-'); then
	  arg1="./$$arg1"
	 fi
	 
	 pwd="$$(pwd)"
	 [ $$? -ne 0 ] && return 1
	 
	 if [ x"$$arg1" = x"~" ]; then
	  ref="$$(cd "$$HOME" && pwd)"
	  [ $$? -ne 0 ] && return 1
	 else
	  ref="$$(cd "$${arg1:-$$HOME}" && pwd)"
	  [ $$? -ne 0 ] && return 1
	 fi
	 
	 export __relpath_home="$$home"
	 export __relpath_arg1="$$arg1"
	 export __relpath_pwd="$$pwd"
	 export __relpath_ref="$$ref"
	 
	 awk -e '
	  BEGIN {
	   home = ENVIRON["__relpath_home"]
	   arg1 = ENVIRON["__relpath_arg1"]
	   pwd = ENVIRON["__relpath_pwd"]
	   ref = ENVIRON["__relpath_ref"]
	   
	   is_home = (ref == home)
	   use_tilde = (is_home && arg1 == "~")
	   
	   if (pwd == ref) {
	    print (use_tilde) ? "~" : "."
	   } else if (ref == "/") {
	    print pwd
	   } else if (startswith(pwd, ref)) {
	    rel = substr(pwd, length(ref) + 2)
	    print (use_tilde) ? "~/" rel : rel
	   } else {
	    print pwd
	   }
	  }
	  
	  function startswith(str, prefix) {
	   return substr(str, 0, length(prefix)) == prefix
	  }
	 '
	 local r=$$?
	 
	 unset __relpath_pwd __relpath_ref __relpath_home __relpath_arg1
	 return $$r
	}
	
	
	relpwd "${ref}"


# vim: set fdm=marker:
