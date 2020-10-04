#!/home/workspace/miniconda3/bin/python 
from griddata_utils import GridData
import argparse
import sys

parser = argparse.ArgumentParser()
parser.add_argument("gridcoords_filepath")
parser.add_argument("u_filepath")
parser.add_argument("v_filepath")
args = parser.parse_args()

grid_start= [-2,-3]
grid_end= [14, 3]
D = 1.
grid_coord_filepath = args.gridcoords_filepath
grid_data = GridData(0.05, grid_start, grid_end, D, grid_coord_filepath)
u_filepath = args.u_filepath
v_filepath = args.v_filepath
grid_data.convert_grid_to_csv_from_stdin(u_filepath, v_filepath)

