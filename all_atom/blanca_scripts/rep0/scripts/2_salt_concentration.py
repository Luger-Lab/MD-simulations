#!/usr/bin/env python

import os,sys
import argparse
import numpy as np

parser=argparse.ArgumentParser()
parser.add_argument("--wat",help="Number of waters")
parser.add_argument("--conc",help="Desired Ion Concentration (in M)")
parser.add_argument("--q",help="Charge of solute",dest="Q")
parser.set_defaults(Q=0)

args=parser.parse_args()

wat=int(args.wat)
C=float(args.conc)
Q=int(args.Q)
q=abs(Q)
K=0.01867

N=0.5*((K*C)/(1+K*C))*wat


if Q>0:
	Ncation=int(N-q/2)
	Nanion=int(N+q/2)
elif Q<0:
	Ncation=int(N+q/2)
	Nanion=int(N-q/2)
else:
	Ncation=int(N)
	Nanion=int(N)

print("\n\nAdd "+str(Ncation)+" Na+ and "+str(Nanion)+" Cl-\n\n")

print("Copy/paste the lines below into a tleap script:")

if Q>0: ION="Cl-"
elif Q<0: ION="Na+"
else: ION=""

Nrand=np.amin([Ncation,Nanion])

print("\n\taddions unit "+ION+" 0")
print("\taddionsrand unit Na+ %i Cl- %i\n\n" % (Nrand,Nrand))

