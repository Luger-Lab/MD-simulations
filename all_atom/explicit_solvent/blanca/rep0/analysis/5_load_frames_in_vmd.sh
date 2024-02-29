#!/bin/bash

source /programs/sbgrid.shrc

vmd s*.prmtop -e vmd_movie_cmds.tcl s*.nc

