#!/bin/bash
set -u

# Reposync RHEL repositories
# Author: Neal Gompa <ngompa@datto.com>
# SPDX-License-Identifier: Apache-2.0
# WARNING: Requires running on the RHEL host you wish to sync
# REQUIRES: RHEL 9 and dnf-plugins-core

downloaddir="${1:-${SYNC_DIR}}"
max_retries="${2:-${MAX_TRIES}}"

# We can't easily use the version ID from this because it includes the minor version
#source /etc/os-release

VERSION_ID=9
basearch=x86_64

repoids=("rhel-${VERSION_ID}-for-${basearch}-baseos-rpms"
"rhel-${VERSION_ID}-for-${basearch}-baseos-debug-rpms"
"rhel-${VERSION_ID}-for-${basearch}-baseos-source-rpms"
"rhel-${VERSION_ID}-for-${basearch}-appstream-rpms"
"rhel-${VERSION_ID}-for-${basearch}-appstream-debug-rpms"
"rhel-${VERSION_ID}-for-${basearch}-appstream-source-rpms"
"codeready-builder-for-rhel-${VERSION_ID}-${basearch}-rpms"
"codeready-builder-for-rhel-${VERSION_ID}-${basearch}-debug-rpms"
"codeready-builder-for-rhel-${VERSION_ID}-${basearch}-source-rpms")

#ARGS:
# $1 - download path
# $2 - repo
function do-reposync {
	for (( i=1; i<=${MAX_TRIES}; i++ )); do
		dnf reposync --download-path ${1} --download-metadata --repo="${2}"
		if [ $? -eq 0 ]; then
			return 0
		elif [ $i -eq $MAX_TRIES ]; then
			echo "MAX_TRIES reached; reposync has failed."
			return $?
		fi
	done
}

for repoid in ${repoids[@]}; do
	if [[ "$repoid" =~ "baseos" ]]; then
		repodir="BaseOS"
	elif [[ "$repoid" =~ "appstream" ]]; then
		repodir="AppStream"
	elif [[ "$repoid" =~ "codeready-builder" ]]; then
		repodir="CodeReady-Builder"
	fi
	basedir="$downloaddir/RHEL/${VERSION_ID}"
	ln_cmd="ln --symbolic --relative --force --no-target-directory --verbose"
	mkdir -p ${basedir}/${basearch}/.mirror/
	mkdir -p ${basedir}/${basearch}/${repodir}/
	mkdir -p ${basedir}/Source/.mirror
	if [[ "$repoid" =~ "debug" ]]; then
		do-reposync ${basedir}/${basearch}/.mirror ${repoid}
		${ln_cmd} ${basedir}/${basearch}/.mirror/${repoid} ${basedir}/${basearch}/${repodir}/debug
	elif [[ "$repoid" =~ "source" ]]; then
		do-reposync ${basedir}/Source/.mirror ${repoid}
		${ln_cmd} ${basedir}/Source/.mirror/${repoid} ${basedir}/Source/${repodir}
	else
		do-reposync ${basedir}/${basearch}/.mirror ${repoid}
		${ln_cmd} ${basedir}/${basearch}/.mirror/${repoid} ${basedir}/${basearch}/${repodir}/os
	fi
done
