# input file to create a mesh from image
# This generates the file containing the mesh with 2 or 1 block.

[Mesh]
  type = GeneratedMesh
  dim = 2
  nx = 1666 #833
  ny = 2180 #1090
  #nz = 80
  elem_type = QUAD
  block_name = 'pores grains'
  block_id = '1 0'
[]

[MeshModifiers]
  [./image]
    type = ImageSubdomain
    threshold = 90
    #the image folder and the images selected
    # file_base = ../output_files/mehrdad/image
    # file_range = '32'
    # file_suffix = png
    file = myGeomtry/image.png
  [../]
[]

[Variables]
  [./u]
  [../]
[]

[Problem]
  type = FEProblem
  solve = false
[]

[Postprocessors]
  # postprocessors necessary for permeability computation
  [./vol_pores] # need total volume to know the porosity
    type = VolumePostprocessor
    execute_on = initial
    block = pores
  [../]
[]

[Executioner]
  type = Steady
[]

[Outputs]
  file_base = myGeomtry_fullres
  execute_on = 'timestep_end'
  exodus = true
[]
