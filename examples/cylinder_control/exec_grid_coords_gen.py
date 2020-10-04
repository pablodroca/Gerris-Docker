#!/home/workspace/miniconda3/bin/python 
from griddata_utils import GridData
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("output_filepath")
args = parser.parse_args()

grid_start= [-2,-3]
grid_end= [14, 3]
D = 1.
grid_coord_filepath = args.output_filepath
grid_data = GridData(0.05, grid_start, grid_end, D, grid_coord_filepath)
grid_data.create_grid_coord()
print('Grid Coords file created at={}'.format(grid_coord_filepath))

