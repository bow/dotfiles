#!/usr/bin/env python3

import argparse
from subprocess import check_call
from urllib.parse import urlsplit


def get_repo_name(git_url):
    """Returns the repo name of the given git URL."""
    sr = urlsplit(git_url)
    assert sr.scheme == "https", "this script has only been tested with " + \
        "'https' git repos"
    assert sr.path.endswith(".git"), "git repo url must end with '.git'"
    ptok, _ = sr.path.rsplit(".git", 1)
    _, repo_name = ptok.rsplit("/", 1)
    return repo_name


def add_vimplugin(git_url, remote_name, branch_name="master"):
    """Sets up a Pathogen plugin using git subtree."""
    repo_name = get_repo_name(git_url)
    check_call(["git", "remote", "add", "-f", remote_name, git_url])
    check_call(["git", "subtree", "add", "--prefix",
                f"vim/.vim/bundle/{repo_name}", "--squash",
                f"{remote_name}", f"{branch_name}"])


if __name__ == "__main__":

    parser = argparse.ArgumentParser(description="VIM plugin addition script")
    parser.add_argument("-r", "--git-url", required=True,
                        help="Plugin git repo URL.")
    parser.add_argument("-n", "--remote-name", required=True,
                        help="Name of remote.")
    parser.add_argument("-b", "--branch-name", required=False,
                        default="master",
                        help="Remote branch to add as subtree.")

    args = parser.parse_args()

    add_vimplugin(args.git_url, args.remote_name, args.branch_name)
