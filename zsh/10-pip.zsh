pip_env_vars='PIP_USER=true PIP_BREAK_SYSTEM_PACKAGES=true'

alias pip="env $pip_env_vars pip"
alias pip3="env $pip_env_vars pip3"

unset pip_env_vars
