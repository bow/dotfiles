#!/usr/bin/env python3

import argparse
from subprocess import check_call
from urllib.parse import urlsplit


def get_repo_name(git_url: str) -> str:
    """Return the repo name of the given git URL."""
    sr = urlsplit(git_url)
    assert sr.scheme == "https", "this script has only been tested with " + \
        "'https' git repos"
    assert sr.path.endswith(".git"), "git repo url must end with '.git'"
    ptok, _ = sr.path.rsplit(".git", 1)
    _, repo_name = ptok.rsplit("/", 1)
    return repo_name


def add_vimplugin(
    git_url: str,
    remote_name: str,
    path: str,
    branch_name: str = "master",
) -> None:
    """Set up a Pathogen plugin or Vim pack using git subtree.

    :param git_url: URL of the remote git repository to add as subtree.
    :param remote_name: Name of the remote git repo.
    :param path: Local directory path to which the repo will be cloned.
    :param branch_name: name of the git branch to use.

    """
    repo_name = get_repo_name(git_url)
    check_call(["git", "remote", "add", "-f", remote_name, git_url])
    path = path or f"vim/.vim/bundle/{repo_name}"
    check_call([
        *("git subtree add --prefix".split(" ")),
        path,
        "--squash",
        f"{remote_name}",
        f"{branch_name}"
    ])


if __name__ == "__main__":

    parser = argparse.ArgumentParser(description="Vim plugin addition script")
    parser.add_argument(
        "-r",
        "--git-url",
        required=True,
        help="Plugin git repo URL.",
    )
    parser.add_argument(
        "-n",
        "--remote-name",
        required=True,
        help="Name of remote.",
    )
    parser.add_argument(
        "-p",
        "--path",
        required=False,
        default="",
        help="Custom path in repo at which the plugin should be located.",
    )
    parser.add_argument(
        "-b",
        "--branch-name",
        required=False,
        default="master",
        help="Remote branch to add as subtree.",
    )

    args = parser.parse_args()

    add_vimplugin(
        args.git_url,
        args.remote_name,
        args.path,
        args.branch_name
    )
