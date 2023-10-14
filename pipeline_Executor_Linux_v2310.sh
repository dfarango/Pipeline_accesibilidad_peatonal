# **************************************************************************************
# pipeline_Executor_Linux_v2310.sh
# --------------------------------------
# Date                 : oct 2023
# Copyright            : © 2023 by darango
# Email 1              : davidfernandezarango at hotmail dot com
# **************************************************************************************
#                                                                                      *
#   This script runs the following pipeline to classify the LiDAR Poing Cloud *.las    *
#	and get a Digital Terrain Model and other geographic products.						                	                   *
#   																		           *
#   To run this script you must have the initial data (S1.las and S2.las), the .json   *
#   script files of the pipeline and this bash .sh file in the same folder.            *
#  												                                       *
# **************************************************************************************



#!/bin/bash

'''
Running script for generate a DTM surface.
'''


# Variables
input_sensor_1_PCL="S1.las"	#sensor 1 LiDAR PCL  # si se quiere tener como input "S1.laz" en vez de "S1.las", solamente hay que sustituirlo en esta línea
input_sensor_2_PCL="S2.las"	#sensor 2 LiDAR PCL	 # si se quiere tener como input "S2.laz" en vez de "S2.las", solamente hay que sustituirlo en esta línea
script_1="s03_Merge_two_las_data_files.json"
script_2="s04_Initial_debug_and_coarse_classification.json"
script_3="s05_NormalZ_filter.json"
script_4="s06_NeighborClassifier.json"
script_5="s07_SMRF.json"
script_6="s08_Create_DTM_raster.json"
script_7="s08b_Create_DSM_raster.json"
script_8="s09_create_pedestrian_obstacles_raster.json"
script_9="s10_Create_intensity_raster.json"


#Commands

echo Running LiDAR PCL segmentation program...
 
echo "Running step 1: Merging two las files..."
pdal pipeline -i $script_1 --stage.input1.filename=$input_sensor_1_PCL --stage.input2.filename=$input_sensor_2_PCL
echo "Finished step 1"

echo "Running step 2: Initial debug and coarse classification..."
pdal pipeline -i $script_2 --readers.las.filename="outputS03_merge_las_files.las" 
echo "Finished step 2"

echo "Running step 3: Normal Z filter..."
pdal pipeline -i $script_3 --readers.las.filename="outputS04_initial_debug.las"
echo "Finished step 3"

echo "Running step 4: Neighbor classifier..."
pdal pipeline -i $script_4 --readers.las.filename="outputS05_NzFilter.las"
echo "Finished step 4..."

echo "Running step 5: Simple Morpholigical Filter..."
pdal pipeline -i $script_5 --readers.las.filename="outputS06_NeighborClassifier.las"
echo "Finished step 5"

echo "Running step 6: Creating DTM Raster..."
pdal pipeline -i $script_6 --readers.las.filename="outputS07_SMRF.las"
echo "Finished step 6."

echo "Running step 7: Creating DSM Raster..."
pdal pipeline -i $script_7 --readers.las.filename="outputS07_SMRF.las"
echo "Finished step 7"

echo "Running step 8: Creating Pedestrian Obstacles raster..."
pdal pipeline -i $script_8 --readers.las.filename="outputS07_SMRF.las"
echo "Finished step 8"

echo "Running step 9: Creating intensity raster..."
pdal pipeline -i $script_9 --readers.las.filename="outputS07_SMRF.las"
echo "Finished step 9"

echo "Running step 10: Creating interpolated DTM raster..."
gdal_fillnodata.py -md 50 -b 1 -mask outputS08_DTM.tif -of GTIFF outputS08_DTM.tif outputS08_interpolated_DTM.tif
echo "Finished step 10"

echo "Running step 11: Convert intensity raster from tif formato to jpg format"
sh s11_convert_tif_to_png.sh
echo "Finished step 11"

echo "Process completed."
