#!/bin/bash

if [[ -f "${HOME}/env.sh ]];then
  pushd ${HOME} >/dev/null
  source env.sh
  popd >/dev/null
fi
