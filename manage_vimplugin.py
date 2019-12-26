#!/usr/bin/env python3

import argparse
from subprocess import check_call
from typing import Optional
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


def add(
    git_url: str,
    remote_name: str,
    branch_name: str = "master",
    path: Optional[str] = None,
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

    parser = argparse.ArgumentParser(
        description="Vim plugin management script"
    )
    subparsers = parser.add_subparsers(
        dest="subcommand",
        required=True,
    )

    add_parser = subparsers.add_parser(
        "add",
        description="Add a new git remote to be used as a vim plugin",
        help="Add a vim plugin",
    )
    add_parser.add_argument(
        "-r",
        "--git-url",
        required=True,
        help="Plugin git repo URL.",
    )
    add_parser.add_argument(
        "-n",
        "--remote-name",
        required=True,
        help="Name of remote.",
    )
    add_parser.add_argument(
        "-p",
        "--path",
        required=False,
        default=None,
        help="Custom path in repo at which the plugin should be located.",
    )
    add_parser.add_argument(
        "-b",
        "--branch-name",
        required=False,
        default="master",
        help="Remote branch to add as subtree.",
    )

    args = parser.parse_args()

    if args.subcommand == "add":
        add(
            git_url=args.git_url,
            remote_name=args.remote_name,
            branch_name=args.branch_name,
            path=args.path,
        )
