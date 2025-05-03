# 🦴 Double-Scale Homogenization of a Porous Ceramic Scaffold for Bone Replacement

This repository contains files for a micromechanics project involving multiscale modeling of a rattan-derived porous ceramic material, designed for bone replacement applications.  
The work includes analytical and numerical homogenization methods applied at both micro and mesoscale levels to estimate effective stiffness for engineering design.

---

## 📂 Folder structure (recommended reading order)

To better understand the project, it is suggested to explore the folders in the following order:

1. `/presentation` – Final project slides with visual explanations and results  
2. `/matlab` – MATLAB scripts implementing analytical homogenization models (Mori-Tanaka, Self-Consistent, Hashin-Shtrikman bounds)  
3. `/abaqus` – 2D finite element RVE simulation with periodic boundary conditions

---

## 🧪 Project Summary

### 📌 Objective
Estimate the effective elastic properties of a porous ceramic scaffold with **biomorphic architecture** using a **double-scale homogenization approach**.

### 🔬 Approach Overview

#### **Microscale (1–10 μm pores)**
- Material: isotropic matrix with randomly distributed spherical voids (30.5% porosity)
- Methods:
  - **Mori-Tanaka** → initial approximation
  - **Self-Consistent** and **Relaxed Self-Consistent** → refined evaluation
  - **Hashin-Shtrikman bounds** → theoretical limits

#### **Mesoscale (10–300 μm channels)**
- Geometry: irregular parallel channels with 23.25% porosity
- RVE created in Abaqus and meshed
- **Periodic Boundary Conditions** applied in tension (x, y) and shear (xy)
- FEM simulation to extract average strain/stress response

---

## 📊 Results

| Scale      | Young’s Modulus                 |
|------------|---------------------------------|
| Nanoscale  | ~96.5 GPa (theoretical)         |
| Microscale | ~22.24 GPa                      |
| Mesoscale  | ~8.7 GPa                        |
| Macroscale | Ex = Ey ~ 4.8 GPa, Ez ~ 6.7 GPa |

✔️ The FEM-based results fall within the expected range and validate the analytical estimations under double-scale porosity assumptions.

---

## 📚 References

- Voigt-Reuss and Hashin-Shtrikman bounds revisited (Castaneda, 2002)  
- Macroscopic stress, couple stress and flux tensors derived through energetic equivalence (Michel et al., 2009)  
- Additional references in the `/presentation` folder

---

## 👤 Author

Samuele Scortechini  
Biomedical and Materials Engineering – Politecnico di Milano  
📧 samuele.scortechini@mail.polimi.it
