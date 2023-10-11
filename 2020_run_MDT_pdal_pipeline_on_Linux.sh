#!/bin/bash

# ***************************************************************************
# 2020_run_MDT_pdal_pipeline.sh
# --------------------------------------
# Date                 : May 2020
# Copyright            : © 2020 by CartoLAB
# Email 1              : darango at emapic dot com
# ***************************************************************************
# *                                                                         *
# *   This script runs the 6 step pipeline to classify the LiDAR            *
# *	  Point Cloud and get a Digital Terrain Model.							*
# *   																		*
# *   To run this script you must have the initial data, the 6 .json 		*
# *   scripts of the pipeline and this bash .sh script in the same folder.  *
# *   																		*
# ***************************************************************************


'''
Running script for generate a MDT surface.
'''


# Variables
input_sensor_1_PCL="S1.las"	#sensor 1 LiDAR PCL  
input_sensor_2_PCL="S2.las"	#sensor 2 LiDAR PCL	
script_0="2020_0_merge_two_las_data_files.json"
script_1="2020_1_initial_debug_and_coarse_classification.json"
script_2="2020_2_NormalZ_filter.json"
script_3="2020_3_KDistance_filter.json"
script_4="2020_4_SMRF_HAG.json"
script_5="2020_5_MDT_raster.json"


#Commands


echo "Running step 0/6..."
pdal pipeline -i $script_0 --stage.input1.filename=$input_sensor_1_PCL --stage.input2.filename=$input_sensor_2_PCL

echo "Running step 1/6..."
pdal pipeline -i $script_1 --readers.las.filename="output0_merge_las_files.las" 

echo "Running step 2/6..."
pdal pipeline -i $script_2 --readers.las.filename="output1_initial_debug.las"

echo "Running step 3/6..."
pdal pipeline -i $script_3 --readers.las.filename="output2_NzFilter.las"

echo "Running step 4/6..."
pdal pipeline -i $script_4 --readers.las.filename="output3_KD_filter.las"

echo "Running step 5/6..."
pdal pipeline -i $script_5 --readers.las.filename="output4_SMRF_HAG.las"

echo "Running step 6/6..."
gdal_fillnodata.py -md 50 -b 1 -mask output5_MDT.tif -of GTIFF output5_MDT.tif output6_interpolated_MDT.tif

echo "Finished processing."