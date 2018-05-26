#!/bin/bash
# Commit Script for Phishing.Database
# REPO: https://github.com/mitchellkrogza/Phishing.Database
# Copyright Mitchell Krog - mitchellkrog@gmail.com

# ***********************************
# Copy tested files into root of repo
# ***********************************

cat ${TRAVIS_BUILD_DIR}/dev-tools/output/domains/ACTIVE/list | grep -v "^$" | grep -v "^#" > ${TRAVIS_BUILD_DIR}/phishing-domains-ACTIVE.txt
cat ${TRAVIS_BUILD_DIR}/dev-tools/output/domains/INACTIVE/list | grep -v "^$" | grep -v "^#" > ${TRAVIS_BUILD_DIR}/phishing-domains-INACTIVE.txt
cat ${TRAVIS_BUILD_DIR}/dev-tools/output/domains/INVALID/list | grep -v "^$" | grep -v "^#" > ${TRAVIS_BUILD_DIR}/phishing-domains-INVALID.txt

# *********************************************************
# Pull Fresh Data for our Next Tests and Modify Readme File
# *********************************************************

bash ${TRAVIS_BUILD_DIR}/dev-tools/pulldata.sh
bash ${TRAVIS_BUILD_DIR}/dev-tools/modify-readme.sh

# ***************
# Exit our Script
# ***************

exit ${?}


