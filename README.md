# Moose_in_porous_media

The steps to compute stokes flow on a given geometry are as follow:

* run *txt_to_png_crop.py*
* run *image_meshing.i*
* run *perm_moose_2d_y.i*

## txt_to_png_crop.py

Python file to convert the image of the flow geometry coded in binary to a png image used to create a finite element mesh.
The user should adapt the lines 52-55 of the input file to his geometry.

## image_meshing.i

This input file create a finite element element mesh of the flow geometry, used for the flow computation.
The user should adapt the input file to his geometry.

## perm_moose_2d_y.i

This input file computes the dimensionless pressure-driven stokes flow on a geometry mesh. Postprocessors should be added to compute permeability on the geometry.
