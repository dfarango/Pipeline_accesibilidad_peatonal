

rem ***************************************************************************
rem Run_MDT_pdal_pipeline_PCL_in_Windows.bat
rem --------------------------------------
rem Date                 : Oct 2022
rem Date                 : Oct 2022
rem Copyright            : © 2022 by SusMobLab
rem Email 1              : d.arango at udc dot es
rem ***************************************************************************
rem This script runs the 6 step pipeline to segment the LiDAR Point Cloud and get a Digital Terrain Model. To run this script you must have the initial .las data, the .json scripts of the pipeline and this .cmd script in the same folder. 
rem ***************************************************************************


echo Running LiDAR Point Cloud Segmentation Program...
pause

ECHO %TIME%

echo "Running step 1/7: Merging two las files..."
pdal pipeline -i 03_Merge_two_las_data_files.json --stage.input1.filename=S1.las   --stage.input2.filename=S2.las  
echo "Finished step 1/7..."

echo "Running step 2/7: Initial debug and coarse classification..."
pdal pipeline -i 04_Initial_debug_and_coarse_classification.json --readers.las.filename=output0_merge_las_files.las
echo "Finished step 2/7..."

echo "Running step 3/7: Normal Z filter..."
pdal pipeline -i 05_NormalZ_filter.json --readers.las.filename=output1_initial_debug.las
echo "Finished step 3/7..."

echo "Running step 4/7: Neighbor classifier..."
pdal pipeline -i 06_NeighborClassifier.json --readers.las.filename=output2_NzFilter.las
echo "Finished step 4/7..."

echo "Running step 5/7: Simple Morpholigical Filter..."
pdal pipeline -i 07_SMRF.json --readers.las.filename=output3_NeighborClassifier.las
echo "Finished step 5/7..."

echo "Running step 6/7: Create DTM Raster..."
pdal pipeline -i 08_Create_MDT_raster.json --readers.las.filename=output4_SMRF.las
echo "Finished step 6/7..."

echo "Running step 7/7: Create Pedestrian Obstacles Raster..."
pdal pipeline -i 09_create_pedestrian_obstacles_raster.json --readers.las.filename=output4_SMRF.las
echo "Finished step 7/7..."

rem echo "Running step 7/7..."
rem gdal_fillnodata.py -md 50 -b 1 -mask output5_DTM.tif -of GTIFF output5_DTM.tif output6_interpolated_DTM.tif
rem echo "Finished step 7/7..."

 
echo "Finished processing."