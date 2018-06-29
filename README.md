# Moose_in_porous_media

The steps to compute stokes flow on a given geometry are as follow:

* run *txt_to_png_crop.py*
* run *image_meshing.i*
* run *perm_moose_2d_y.i*

The steps to compute stokes flow on a given geometry with precipitation are as follow:

* run *txt_to_png_crop.py*
* run *erosion_image_meshing.i*
* run *erosion_permeability_2D.i*

Note that the precipitation simulation needs to be run on the branch *21_erosion* of REDBACK (soon to be merged in the master branch).

## txt_to_png_crop.py

Python file to convert the image of the flow geometry coded in binary to a png image used to create a finite element mesh.
The user should adapt the lines 52-55 of the input file to his geometry.

## image_meshing.i / erosion_image_meshing.i

This input file create a finite element element mesh of the flow geometry, used for the flow computation.
The user should adapt the input file to his geometry.

## perm_moose_2d_y.i / erosion_permeability_2D.i

This input file computes the dimensionless pressure-driven stokes flow on a geometry mesh without or with precipitation. Postprocessors should be added to compute permeability on the geometry.
