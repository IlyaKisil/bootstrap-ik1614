#!/usr/bin/env bash
# vim: ft=sh softtabstop=2 tabstop=2 shiftwidth=2 expandtab autoindent cc=90

set -euo pipefail

. import_ik1614_module utils


utils::check_software jq gh

__SCRIPT_NAME=$(basename ${BASH_SOURCE[0]})

__show_help() {
  cat << HELP_USAGE

Description:

Usage: $__SCRIPT_NAME [-h] REPO

Examples:
  $__SCRIPT_NAME IlyaKisil/bootstrap-ik1614

Arguments:
  REPO
   Name of the respository in the [HOST/]OWNER/REPO format

Options:
  -h
    Show this message.

HELP_USAGE
}


while getopts ':h' opt; do
  case "$opt" in
    h)
      __show_help
      exit 0
      ;;
    \?)
      utils::echo_warn "Invalid option: '-$OPTARG'. Skipping." 1>&2
      ;;
    :)
      utils::echo_err "Invalid option: '-$OPTARG' requires an argument." 1>&2
      exit 1
      ;;
  esac
done
shift $((OPTIND -1))

REPO="${1:-}"
DELIMITER='|'

if [[ -z "$REPO" ]]; then
  if [[ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" == "true" ]]; then
      REPO="$(git remote get-url origin | awk -F'/' '{print $(NF-1) "/" $NF}' | awk -F'.' '{print $1}')"
    else
      utils::echo_err "You need to explicity specify name of the repo when you are not inside Git directory."
      exit 1
  fi
fi

SELECTED="$(
  gh pr list \
    --json 'number,url,author,title' \
    --repo "$REPO" \
  | jq \
    -r \
    --arg delimiter "$DELIMITER" \
    '.[] | "\(.number)" + $delimiter + " \(.url) " + $delimiter + " \((if .author.name != "" then .author.name else .author.login end)) " + $delimiter + " \(.title)"' \
    | sort --numeric-sort --reverse \
    | utils::fzf_select "PR you want to approve"
)"

if [[ -z "$SELECTED" ]]; then
  utils::echo_info "Nothing selected. Exiting."
  exit 0
fi

IFS="$DELIMITER" read PR_NUMBER PR_URL REST <<< "$SELECTED"
utils::echo_info "Approving PR #${PR_NUMBER} -> ${PR_URL}"

gh pr review "$PR_NUMBER" \
  --approve \
  --repo "$REPO"
