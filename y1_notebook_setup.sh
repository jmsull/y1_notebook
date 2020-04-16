#!/bin/bash

#source cosmosis, you can change this if you have it already and use your own setup environment
source ./cosmosis/config/setup-cosmosis-nersc
if [[ -z "${COSMOSIS_SRC_DIR}" ]]; then
  echo 'Exiting without executing. Make sure you source setup-cosmosis-nersc please!'
  exit 1
fi
COSMOSIS_SRC_DIR_copy=$COSMOSIS_SRC_DIR
conda deactivate
conda deactivate
conda env create -f environment.yml
source activate cosmosis-nb-y1
python -m ipykernel install --user --name cosmosis-nb-y1 --display-name Cosmosis-nb-y1
#edit kernel spec and helper script
kernelshell="${PWD}/kernel_cosmosis.sh"
python add_line.py ./kernel.json $kernelshell 
cp kernel.json $HOME/.local/share/jupyter/kernels/cosmosis-nb-y1/kernel.json
chmod u+x kernel_cosmosis.sh
python add_line.py ./kernel_cosmosis.sh $COSMOSIS_SRC_DIR_copy 
#get bayesfast
git clone https://github.com/HerculesJack/bayesfast
cd bayesfast
LDSHARED="cc -shared" CC=gcc python -m pip install -e .
#pip install -e 
cd examples 
echo 'Moving notebook to bayesfast example directory so it can run properly.'
mv ../../edited-y1-notebook.ipynb .
echo 'Done'
