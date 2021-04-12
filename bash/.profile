# load own copy of .git-completion.bash if it exists
if [ -f ~/.git-completion.bash ]; then
    # shellcheck source=.git-completion.bash
    source ~/.git-completion.bash
fi

# load own copy of .kubectl-completion.bash if it exists
if [ -f ~/.kubectl-completion.bash ]; then
    # shellcheck source=.kubectl-completion.bash
    source ~/.kubectl-completion.bash
fi

# load own copy of .minikube-completion.bash if it exists
if [ -f ~/.minikube-completion.bash ]; then
    # shellcheck source=.minikube-completion.bash
    source ~/.minikube-completion.bash
fi
