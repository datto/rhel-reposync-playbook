{% set protocol = "https://" if use_https is true else "http://" %}
{% set baseurl = protocol ~ mirror_fqdn %}
[baseos]
name=Red Hat Enterprise Linux $releasever - BaseOS
baseurl={{ baseurl }}/RHEL/$releasever/$basearch/BaseOS/os/
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
gpgcheck=1
repo_gpgcheck=0
metadata_expire=6h
countme=1
enabled=1

[baseos-debuginfo]
name=Red Hat Enterprise Linux $releasever - BaseOS - Debug
baseurl={{ baseurl }}/RHEL/$releasever/$basearch/BaseOS/debug/
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
gpgcheck=1
repo_gpgcheck=0
metadata_expire=6h
enabled=0

[baseos-source]
name=Red Hat Enterprise Linux $releasever - BaseOS - Source
baseurl={{ baseurl }}/RHEL/$releasever/Source/BaseOS/
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
gpgcheck=1
repo_gpgcheck=0
metadata_expire=6h
enabled=0

[appstream]
name=Red Hat Enterprise Linux $releasever - AppStream
baseurl={{ baseurl }}/RHEL/$releasever/$basearch/AppStream/os/
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
gpgcheck=1
repo_gpgcheck=0
metadata_expire=6h
countme=1
enabled=1

[appstream-debuginfo]
name=Red Hat Enterprise Linux $releasever - AppStream - Debug
baseurl={{ baseurl }}/RHEL/$releasever/$basearch/AppStream/debug/
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
gpgcheck=1
repo_gpgcheck=0
metadata_expire=6h
enabled=0

[appstream-source]
name=Red Hat Enterprise Linux $releasever - AppStream - Source
baseurl={{ baseurl }}/RHEL/$releasever/Source/AppStream/
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
gpgcheck=1
repo_gpgcheck=0
metadata_expire=6h
enabled=0

[codeready-builder]
name=Red Hat Enterprise Linux $releasever - CodeReady Builder
baseurl={{ baseurl }}/RHEL/$releasever/$basearch/CodeReady-Builder/os/
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
gpgcheck=1
repo_gpgcheck=0
metadata_expire=6h
countme=1
enabled=0

[codeready-builder-debuginfo]
name=Red Hat Enterprise Linux $releasever - CodeReady Builder - Debug
baseurl={{ baseurl }}/RHEL/$releasever/$basearch/CodeReady-Builder/debug/
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
gpgcheck=1
repo_gpgcheck=0
metadata_expire=6h
enabled=0

[codeready-builder-source]
name=Red Hat Enterprise Linux $releasever - CodeReady Builder - Source
baseurl={{ baseurl }}/RHEL/$releasever/Source/CodeReady-Builder/
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
gpgcheck=1
repo_gpgcheck=0
metadata_expire=6h
enabled=0
