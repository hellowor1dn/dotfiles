#!/usr/bin/env bash
#
# Install google chrome canary

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
declare -r NAME="googlechromecanary"
declare -r URL="https://storage.googleapis.com/chrome-canary/GoogleChromeCanary.dmg"
# Dmg
declare -r PATH="/Volumes/Google Chrome Canary"
declare -r APP="Google Chrome Canary.app"

# -----------------------------------------------------------------------------
# | Main                                                                       |
# -----------------------------------------------------------------------------

main() {
    # switch path to script source
    cd "$(dirname "${BASH_SOURCE}")" \
        && source "../../../script/utils.sh" \
        && source "./util.sh"

    start_spinner "Downloading ${NAME}"
    download_dmg "${NAME}" "${URL}"
    status_stop_spinner "Finished downloading ${NAME}"
    exit_on_fail "${NAME} download failed" "${E_DOWNLOAD_FAILURE}"
    cp -R "${PATH}/${APP}" /Applications
    status "${NAME} → /Applications" "${E_COPY_FAILURE}"
    remove_dmg "${NAME}" "${PATH}"
    status "Removed ${NAME} archive" "${E_REMOVE_FAILURE}"
    print_separator
}

main
