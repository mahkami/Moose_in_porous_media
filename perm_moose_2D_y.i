# This input file compute stokes flow on a geometry mesh.

[GlobalParams]
  gravity = '0 0 0'
  laplace = true
  integrate_p_by_parts = false
  pspg = true
  alpha = 1e-1
  convective_term = false
[]

[Mesh]
  type = FileMesh
  file = myGeomtry_by2.e
  block_name = 'pores grains'
  block_id = '1 0'
  boundary_name = grains
  boundary_id = 10
[]

[Variables]
  [./vel_x]
    block = pores
  [../]
  [./vel_y]
    block = pores
  [../]
  [./p]
    block = pores
  [../]
[]

[Kernels]
  [./mass]
    type = INSMass
    variable = p
    u = vel_x
    v = vel_y
    p = p
    block = pores
  [../]
  [./x_momentum_space]
    type = INSMomentumLaplaceForm
    variable = vel_x
    u = vel_x
    v = vel_y
    p = p
    component = 0
    block = pores
  [../]
  [./y_momentum_space]
    type = INSMomentumLaplaceForm
    variable = vel_y
    u = vel_x
    v = vel_y
    p = p
    component = 1
    block = pores
  [../]
[]

[Materials]
  [./const]
    type = GenericConstantMaterial
    block = pores
    prop_names = 'rho mu'
    prop_values = '1  1'
  [../]
[]

[BCs]
  [./x_no_slip]
    type = DirichletBC
    variable = vel_x
    boundary = 'grains left right bottom top' #keeps flow vertical at inlet and outlet
    value = 0.0
  [../]
  [./y_no_slip]
    type = DirichletBC
    variable = vel_y
    boundary = 'grains left right'
    value = 0.0
  [../]
  [./outlet]
    type = DirichletBC
    variable = p
    boundary = bottom
    value = 0
  [../]
  [./inlet]
    type = DirichletBC
    variable = p
    boundary = top
    value = 1
  [../]
[]

[Postprocessors]
  # postprocessors necessary for permeability computation
  [./vol_pores] # need total volume to know the porosity
    type = VolumePostprocessor
    execute_on = initial
    block = pores
  [../]
  [./vel_avg]
    type = ElementAverageValue
    variable = vel_y
    block = pores
  [../]
[]

[Executioner]
  type = Steady
[]

[Preconditioning]
  [./asm_ilu]
    type = SMP
    full = true
    solve_type = PJFNK
    petsc_options = '-ksp_converged_reason -snes_converged_reason' #-snes_monitor -snes_linesearch_monitor -ksp_monitor'
    petsc_options_iname = '-ksp_type -pc_type  -snes_atol -snes_rtol -snes_max_it -ksp_max_it -ksp_atol -sub_pc_type -sub_pc_factor_shift_type'
    petsc_options_value = 'gmres        asm        1E-8      1E-15        200        100         1e-8        lu                   NONZERO'
  [../]
[]

[Outputs]
  file_base = perm_moose_2D_y
  csv = true
  exodus = true
  print_perf_log = true
[]
