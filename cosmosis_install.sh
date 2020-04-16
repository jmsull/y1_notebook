#!/bin/bash
git clone https://bitbucket.org/joezuntz/cosmosis
cd cosmosis
git checkout develop
git clone https://bitbucket.org/joezuntz/cosmosis-standard-library
cd cosmosis-standard-library
git checkout develop
cd ..
source config/setup-cosmosis-nersc
make
cd ..
