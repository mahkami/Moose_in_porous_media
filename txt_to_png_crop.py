#!/usr/bin/env python

''' script to convert raw binary file to png
    Requirements: Python Imaging Library (PIL) or pillow (more recent)
    $ sudo easy_install pip
    $ sudo pip install pillow
'''

import os, sys, shutil, struct
from PIL import Image

def convertDatToPng(input_filename, output_dir, x_start, nx, y_start, ny, z_start, nz):
  ''' Convert raw data to stack of png images
      @param[in] input_filename - string, name of raw input file
      @param[in] output_base_dir - string, name of base directory in which
        a subdirectory will be created with all png files
  '''
  # Check user input
  if not os.path.isfile(input_filename):
    raise Exception, 'Input file "{0}" not found!'.format(input_filename)
  if not os.path.isdir(output_dir):
    os.makedirs(output_dir)

  # Get base filename from input to create subdirectory
  root, last = os.path.split(input_filename)
  base, ext = os.path.splitext(last)
  assert ext.lower() == '.txt', "Converter needs .txt file as input!"
  if not os.path.isdir(output_dir):
    os.makedirs(output_dir)

  # Read raw data
  with open(input_filename, "rb") as f:
    file_content = f.read().splitlines()
    n_bit = 0
    data = []
    for j in range(y_start,y_start+ny):
      line_index = j
      full_line = []
      try:
        full_line = [int(elt) for elt in file_content[line_index].split()]
      except:
        print 'the data probably does not start at the first line'
      data.extend(full_line[x_start:x_start+nx])
    # write image to file
    im = Image.new("1", (nx, ny))
    im.putdata(map(int, data))
    out_filename = os.path.join(output_dir, 'image.png')
    im.save(out_filename)


if __name__ == "__main__":
  input_filename = 'myGeomtry.txt'
  output_dir = 'myGeomtry'
  convertDatToPng(input_filename, output_dir,
    x_start=5, nx=1666, y_start=0, ny=2180, z_start=0, nz=1) # these dimensions remove the black borders on the sides
  print 'Finished'
