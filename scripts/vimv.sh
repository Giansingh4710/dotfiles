#!/usr/bin/env bash
set -eu

# Lists the current directory's files in Vim, so you can edit it and save to rename them
# USAGE: vimv [file1 file2]
# https://github.com/thameera/vimv

declare -r FILENAMES_FILE=$(mktemp "${TMPDIR:-/tmp}/vimv.XXX")

trap '{ rm -f "${FILENAMES_FILE}" ; }' EXIT

if [ $# -ne 0 ]; then
    src=( "$@" )
else
    IFS=$'\r\n' GLOBIGNORE='*' command eval 'src=($(ls -a))'
fi

for ((i=0;i<${#src[@]};++i)); do
    echo "${src[i]}" >> "${FILENAMES_FILE}"
done

${EDITOR:-nvim} "${FILENAMES_FILE}"

IFS=$'\r\n' GLOBIGNORE='*' command eval 'dest=($(cat "${FILENAMES_FILE}"))'

if (( ${#src[@]} != ${#dest[@]} )); then
    echo "WARN: Number of files changed. Did you delete a line by accident? Aborting.." >&2
    exit 1
fi

declare -i count=0
for ((i=0;i<${#src[@]};++i)); do
    if [ "${src[i]}" != "${dest[i]}" ]; then
        mkdir -p "$(dirname "${dest[i]}")"
        if git ls-files --error-unmatch "${src[i]}" > /dev/null 2>&1; then
            git mv "${src[i]}" "${dest[i]}"
        else
            mv "${src[i]}" "${dest[i]}"
        fi
        ((++count))
    fi
done

echo "$count" files renamed.
