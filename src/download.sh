#!/bin/bash
#
# Download "Software Foundations" tarballs

set -eu -o pipefail +o posix

curl -fSL -o "lf-$(date +%Y-%m-%d).tgz"  https://softwarefoundations.cis.upenn.edu/lf-current/lf.tgz
curl -fSL -o "plf-$(date +%Y-%m-%d).tgz" https://softwarefoundations.cis.upenn.edu/current/plf-current/plf.tgz
curl -fSL -o "vfa-$(date +%Y-%m-%d).tgz" https://softwarefoundations.cis.upenn.edu/current/vfa-current/vfa.tgz
