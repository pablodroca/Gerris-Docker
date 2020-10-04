#! /bin/bash
if [ $# -lt 1 ]; then
  echo 'Missing arguments.'
  echo 'Expected syntax: ./exec.sh <SIM_FOLDER>'
  exit 1
fi
SIM_ROOT_FILEPATH=/home/workspace/gerris/$1
HOME_FOLDER=/home/workspace
CONDA_SUBFOLDER=miniconda3

echo "Executing simulation: $SIM_ROOT_FILEPATH..."

./change_python_location.sh "$SIM_ROOT_FILEPATH" "$HOME_FOLDER" "$CONDA_SUBFOLDER" && \
cd $SIM_ROOT_FILEPATH && \
./exec_all.sh
STATUS=$?
if [ $STATUS -eq 0 ]; then
    echo "Finished executing simulation: $SIM_ROOT_FILEPATH"
else
    echo "Error detected executing simulation: $SIM_ROOT_FILEPATH"
    exit 1
fi
