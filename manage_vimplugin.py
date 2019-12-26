#!/usr/bin/env python3

import argparse
from pathlib import Path
from subprocess import check_call, run, PIPE
from typing import List, Optional
from urllib.parse import urlsplit


# Path to repo directory.
DIR = Path(__file__).resolve().parent


def get_repo_name(git_url: str) -> str:
    """Return the repo name of the given git URL."""
    sr = urlsplit(git_url)
    assert sr.scheme == "https", "this script has only been tested with " + \
        "'https' git repos"
    assert sr.path.endswith(".git"), "git repo url must end with '.git'"
    ptok, _ = sr.path.rsplit(".git", 1)
    _, repo_name = ptok.rsplit("/", 1)

    return repo_name


def get_changed() -> List[str]:
    """Return a list of tracked and changed files"""
    cmd_toks = ["git", "-C", str(DIR), "diff", "--name-only", "HEAD"]
    proc = run(cmd_toks, stdout=PIPE)
    ret = proc.stdout.strip().split()

    return ret


def update(
    remote_name: str,
    path: Path,
    branch_name: Optional[str] = "master",
) -> None:
    """Update an existing Pathogen plugin or Vim pack subtree.

    :param remote_name: Name of the remote git repo.
    :param path: Path to the plugin directory.
    :param branch_name: Name of the git branch to use.

    """
    dirty_files = get_changed()
    if dirty_files:
        raise RuntimeError("Can not add new subtree remote when repo is dirty")

    cmd_toks = [
        "git",
        "subtree",
        "pull",
        "--prefix",
        f"{path}",
        remote_name,
        branch_name,
        "--squash",
    ]
    check_call(cmd_toks)


def add(
    git_url: str,
    remote_name: str,
    branch_name: str = "master",
    path: Optional[Path] = None,
) -> None:
    """Set up a Pathogen plugin or Vim pack using git subtree.

    :param git_url: URL of the remote git repository to add as subtree.
    :param remote_name: Name of the remote git repo.
    :param path: Local directory path to which the repo will be cloned.
    :param branch_name: Name of the git branch to use.

    """
    dirty_files = get_changed()
    if dirty_files:
        raise RuntimeError("Can not add new subtree remote when repo is dirty")

    # TODO: Check if we need to add -C for git here.
    add_remote_toks = ["git", "remote", "add", "-f", remote_name, git_url]
    check_call(add_remote_toks)

    # TODO: Check if we need to add -C for git here.
    path = path or Path(f"vim/.vim/bundle/{get_repo_name(git_url)}")
    add_subtree_toks = [
        "git",
        "subtree",
        "add",
        "--prefix",
        f"{path}",
        "--squash",
        f"{remote_name}",
        f"{branch_name}"
    ]
    check_call(add_subtree_toks)


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

    update_parser = subparsers.add_parser(
        "update",
        description="Update an existing vim plugin subtree",
        help="Update a vim plugin",
    )
    update_parser.add_argument(
        "-n",
        "--remote-name",
        required=True,
        help="Name of remote.",
    )
    update_parser.add_argument(
        "-p",
        "--path",
        required=False,
        default=None,
        help="Custom path in repo at which the plugin is located.",
    )
    update_parser.add_argument(
        "-b",
        "--branch-name",
        required=False,
        default="master",
        help="Remote branch to use as source.",
    )

    args = parser.parse_args()

    if args.subcommand == "add":
        add(
            git_url=args.git_url,
            remote_name=args.remote_name,
            branch_name=args.branch_name,
            path=Path(args.path),
        )
    elif args.subcommand == "update":
        update(
            remote_name=args.remote_name,
            path=Path(args.path),
            branch_name=args.branch_name,
        )
