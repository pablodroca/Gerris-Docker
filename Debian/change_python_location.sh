#! /bin/bash

PY_FILES=$(cat <<EOF
exec_grid_convert_to_csv.py 
exec_grid_coords_gen.py
python/main.py
EOF
)

if [ $# -lt 3 ]; then
  echo 'Missing arguments.'
  echo 'Expected syntax: ./change_python_location.sh <SIM_ROOT_FILEPATH> <NEW_HOME_FOLDER> <NEW_CONDA_SUBFOLDER>'
  exit 1
fi
SIM_ROOT_FILEPATH=$1
HOME_FOLDER=$2
CONDA_SUBFOLDER=$3

echo "Changing python location. NEW_HOME_FOLDER=$HOME_FOLDER - NEW_CONDA_SUBFOLDER=$CONDA_SUBFOLDER"
for PY_FILE in $PY_FILES; do
    FILE=$SIM_ROOT_FILEPATH/$PY_FILE
    sed -i "s,^#! */.*/bin/python,#!$HOME_FOLDER/$CONDA_SUBFOLDER/bin/python,g" $FILE
done
