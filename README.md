# Solving for Controller Feedback of Dynamical Systems Using Reinforcement Learning 
### (Full report in Ethan Crouse - Layman.pdf)
**Author**: Ethan D. Crouse  
**Supervisor**: Dr. Steffen W. R. Werner  
**Date**: May 5, 2025  

## Overview

This project demonstrates how reinforcement learning can be used to compute feedback control for stabilizing unstable linear dynamical systems. Specifically, the method trains a neural network controller using reinforcement learning on a reduced version of the system's dynamics, derived from its unstable eigenspace.

By leveraging Dr. Werner’s insight that the unstable eigenspace alone determines stability, we reduce computation and training time drastically while still achieving robust control performance on the full system.

## System Model

We consider continuous and discrete-time linear dynamical systems of the form:

**Continuous-time**:  
    **E𝑥̇ = A𝑥 + Bu**

**Discrete-time**:  
    **Ex(k+1) = Ax(k) + Bu(k)**

Where:
- **x** is the system state  
- **u** is the feedback control  
- **A**, **B**, and **E** are system matrices  
- The goal is to compute **u = K(x)** that drives the system to a steady state (typically **x = 0**)  

## Method

1. **Identify unstable eigenvalues** of the system using E⁻¹A.
2. **Project the system** onto the unstable eigenspace using its eigenvectors.
3. **Truncate the system matrices** to reduce the problem dimension.
4. **Train a reinforcement learning agent** using MATLAB’s RL toolbox:
   - Actor Network: Outputs control **u(k)** based on state **x(k)**
   - Critic Network: Evaluates the value of state-action pairs for learning
5. **Simulate results** on both reduced and full systems to validate controller effectiveness.

## Example Systems

- **Simple 2x2 unstable system** for initial debugging and validation
- **HF2D5 (N = 4489)**: High-dimensional, real-world heat flow system  
  - Trained on reduced system with only 1 unstable eigenvalue
  - Successfully stabilizes the full system

## Results

- **>99% reduction in training cost** using truncated matrices
- Reinforcement learning-based feedback stabilizes both test systems
- Controller performance is robust when applied to full-scale models

## Limitations & Future Work

- Controllers are trained for finite episodes and may not generalize beyond the training distribution
- Training instability can be unsafe in physical systems
- Future work:  
  - Continuous-time controller design  
  - Safe RL methods to avoid excessive overshoot during training  

