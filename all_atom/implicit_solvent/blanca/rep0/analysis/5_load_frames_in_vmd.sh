#!/bin/bash

source /programs/sbgrid.shrc

vmd *.prmtop -e vmd_movie_cmds.tcl *.nc

