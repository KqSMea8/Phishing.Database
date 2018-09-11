#!/bin/bash
# Generator Script for Phishing.Database
# REPO: https://github.com/mitchellkrogza/Phishing.Database
# Copyright Mitchell Krog - mitchellkrog@gmail.com

input=${TRAVIS_BUILD_DIR}/dev-tools/phishing-domains-IDNA.list
pyfuncebleConfigurationFileLocation=${TRAVIS_BUILD_DIR}/dev-tools/.PyFunceble.yaml

# **********************
# Run PyFunceble Testing
# **********************************************************
# Find PyFunceble at: https://github.com/funilrys/PyFunceble
# **********************************************************

# Update README to keep stats more current
cat ${TRAVIS_BUILD_DIR}/dev-tools/output/domains/ACTIVE/list | grep -v "^$" | grep -v "^#" > ${TRAVIS_BUILD_DIR}/phishing-domains-ACTIVE.txt
cat ${TRAVIS_BUILD_DIR}/dev-tools/output/domains/INACTIVE/list | grep -v "^$" | grep -v "^#" > ${TRAVIS_BUILD_DIR}/phishing-domains-INACTIVE.txt
cat ${TRAVIS_BUILD_DIR}/dev-tools/output/domains/INVALID/list | grep -v "^$" | grep -v "^#" > ${TRAVIS_BUILD_DIR}/phishing-domains-INVALID.txt
bash ${TRAVIS_BUILD_DIR}/dev-tools/modify-readme.sh

RunFunceble () {

    yeartag=$(date +%Y)
    monthtag=$(date +%m)
    #sudo chown -R travis:travis ${TRAVIS_BUILD_DIR}/

    cd ${TRAVIS_BUILD_DIR}/dev-tools

    hash PyFunceble

    if [[ -f "${pyfuncebleConfigurationFileLocation}" ]]
    then
        rm "${pyfuncebleConfigurationFileLocation}"
    fi

    PyFunceble --travis -dbr 5 --cmd-before-end "bash ${TRAVIS_BUILD_DIR}/dev-tools/commit.sh" -ex --plain --autosave-minutes 10 --commit-autosave-message "V0.1.${TRAVIS_BUILD_NUMBER} [PyFunceble]" --commit-results-message "V0.1.${TRAVIS_BUILD_NUMBER}" -f ${input}

}

RunFunceble

# **********************
# Exit With Error Number
# **********************

exit ${?}
