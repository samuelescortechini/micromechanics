# 🧾 Abaqus Simulation – Homogenization with Periodic Boundary Conditions

This folder contains the input and model files used for a finite element simulation of a 2D representative volume element (RVE) of a porous ceramic material, performed in Abaqus.

## ⚙️ Simulation Description

- The FEM model implements **Periodic Boundary Conditions (PBC)** in 2D.
- The aim is to compute **effective mechanical properties** at the **macroscale**, which is the scale relevant for **engineering design involving mechanical load-bearing applications**.

The file `macroscale_homogenization.cae` includes:
- Abaqus model database containing the geometry, mesh, materials, PBCs, and loading steps.
- Uniaxial tension simulations along the **x** and **y** directions
- A shear simulation in the **xy** plane

## 📊 Post-processing

For the interpretation of results and extraction of the homogenized stiffness tensor, refer to the **final presentation** available in the `/presentation` folder.

## 📚 Reference

The theoretical formulation applied for the energetic equivalence and derivation of macroscale tensors is based on:

> **Macroscopic stress, couple stress and flux tensors derived through energetic equivalence from microscopic continuous and discrete heterogeneous finite representative volumes**  
> Michel, J.C., Moulinec, H., Suquet, P. – *Journal of the Mechanics and Physics of Solids* (2009)  
> [DOI: 10.1016/j.jmps.2008.08.005](https://doi.org/10.1016/j.jmps.2008.08.005)

This reference is also cited and discussed in the presentation.

---
