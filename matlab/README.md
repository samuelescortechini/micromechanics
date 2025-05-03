# 📊 MATLAB Scripts – Homogenization Methods

This folder contains MATLAB implementations of analytical homogenization methods used to estimate the effective elastic properties of the porous ceramic material at the microscale (which is the one sensed by cells) by means of an inverse approach.

## 🧠 Implemented Methods

- `compute_MT.m` – **Mori-Tanaka method**: used for an initial estimation of the effective moduli.  
- `compute_SC.m` – **Self-Consistent method**: more accurate model, but not always convergent in highly porous cases.  
- `compute_SC_relaxed.m` – **Relaxed Self-Consistent**: a modified version that ensures convergence under challenging porosity conditions.  
- `compute_HS_bounds.m` – **Hashin-Shtrikman bounds**: used to compute theoretical upper and lower bounds to ensure physical consistency of the simulation results.  
- `main.m` – Example script to compare the outputs of the different models.

## 📚 Reference

Some of the formulations used are based on:

**Voigt-Reuss and Hashin-Shtrikman bounds revisited**  
O. Castañeda, Journal of the Mechanics and Physics of Solids, 2002  
[DOI: 10.1016/S0022-5096(02)00023-2](https://doi.org/10.1016/S0022-5096(02)00023-2)

## 🔧 Requirements

Tested with MATLAB R2021b+. No additional toolboxes required.

