#!/usr/bin/env bash
#
# Install 1password

# -----------------------------------------------------------------------------
# | Errors                                                                     |
# -----------------------------------------------------------------------------

declare -r E_DOWNLOAD_FAILURE=101
declare -r E_COPY_FAILURE=102
declare -r E_REMOVE_FAILURE=103

# -----------------------------------------------------------------------------
# | Global variables                                                           |
# -----------------------------------------------------------------------------

# Dowload
declare -r NAME="1Password 5"
declare -r URL="https://d13itkw33a7sus.cloudfront.net/dist/1P/mac4/1Password-5.1.zip"

# -----------------------------------------------------------------------------
# | Main                                                                       |
# -----------------------------------------------------------------------------

main() {
    # switch path to script source
    cd "$(dirname "${BASH_SOURCE}")" \
        && source "../../../script/utils.sh" \
        && source "./util.sh"

    download_zip "${NAME}" "${URL}"
    status "Downloading ${NAME}" "${E_DOWNLOAD_FAILURE}"
    mv "${NAME}.app" /Applications
    status "${NAME} → /Applications" "${E_COPY_FAILURE}"
    remove_zip "${NAME}"
    status "Removed ${NAME} archive" "${E_REMOVE_FAILURE}"
    print_separator
}

main
