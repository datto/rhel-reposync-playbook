#!/bin/bash

# Reposync RHEL repositories
# Author: Neal Gompa <ngompa@datto.com>
# SPDX-License-Identifier: Apache-2.0
# WARNING: Requires running on the RHEL host you wish to sync
# REQUIRES: RHEL 9 and dnf-plugins-core

downloaddir="${1:-${SYNC_DIR}}"

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

for repoid in ${repoids[@]}; do
	if [[ "$repoid" =~ "baseos" ]]; then
		repodir="BaseOS"
	elif [[ "$repoid" =~ "appstream" ]]; then
		repodir="AppStream"
	elif [[ "$repoid" =~ "codeready-builder" ]]; then
		repodir="CodeReady-Builder"
	fi
	basedir="$downloaddir/RHEL/${VERSION_ID}"
	mkdir -p ${basedir}/${basearch}/${repodir}/
	mkdir -p ${basedir}/Source/
	if [[ "$repoid" =~ "debug" ]]; then
		dnf reposync -p ${basedir}/${basearch}/${repodir} --download-metadata --repo="${repoid}"
		mv ${basedir}/${basearch}/${repodir}/${repoid} ${basedir}/${basearch}/${repodir}/debug
	elif [[ "$repoid" =~ "source" ]]; then
		dnf reposync -p ${basedir}/Source/ --download-metadata --repo="${repoid}"
		mv ${basedir}/Source/${repoid} ${basedir}/Source/${repodir}
	else
		dnf reposync -p ${basedir}/${basearch}/${repodir}/ --download-metadata --repo="${repoid}"
		mv ${basedir}/${basearch}/${repodir}/${repoid} ${basedir}/${basearch}/${repodir}/os
	fi
done
