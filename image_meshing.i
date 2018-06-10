# input file to create a mesh from image
# This generates the file containing the mesh with 2 or 1 block.

[Mesh]
  type = GeneratedMesh
  dim = 2
  nx = 833
  ny = 1090
  nz = 80
  elem_type = QUAD
  block_name = 'pores grains'
  block_id = '1 0'
  boundary_name = grains_edges
  boundary_id = 10
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
  #tags the interface pore-grain
  #the interface's normal points outward from pore to grains
  [./interface]
    type = SideSetsBetweenSubdomains
    master_block = 1
    paired_block = 0
    new_boundary = 10
    depends_on = image
  [../]
  #deletes one of the blocks
  [./delete]
    type = BlockDeleter
    depends_on = interface
    block_id = 0
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

[Executioner]
  type = Steady
[]

[Outputs]
  file_base = myGeomtry_by2
  execute_on = 'timestep_end'
  exodus = true
[]
