# ChemNetwork-4DFEM
ChemNetwork-4DFEM is a MATLAB code that generates COMSOL Multiphysics files tailored for simulating (radiation) chemical networks in four-dimensional (4D) chemical, physical, geometrical, and temporal scenarios. This tool simplifies the implementation of complex models by facilitating the coupling of reaction kinetics and mass transport mechanism , such as diffusion, convection and electrostatic drift. It allows researchers to adapt their models for specific applications involving chemical solutions exposed to ionizing radiation, such as electrons or X-rays. 

This tool simplifies the implementation of time-dependent chemical reaction simulations, providing users with a one-click solution for extending their models to incorporate additional physical phenomena or setup geometries. ChemNetwork-4DFEM integrates with AuRaCh, developed by Fritsch et al. (DOI:10.1002/advs.202202803), which provides 0D validation and generates text files formatted for direct input into ChemNetwork-4DFEM.

Its working principle is described in:

## Table of Contents
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Examples](#examples)
- [License](#license)

### Features
Validation of Input Files (AuRaCh): Ensures plain text files conform to required standards for MATLAB Livelink/COMSOL.

Automated COMSOL File Generation: Create ready-to-run COMSOL models using MATLAB.

4D Simulation Ready: Set up 0D chemical kinetics models ready to be expanded in 1D, 2D,3D dimensions and physics.

Complex Geometries: Define and manipulate geometries that suit your experimental setup.
Physical Processes: Integrate physical mass transport laws into your models.
User-Friendly Scripts: Well-documented MATLAB environment that's easy to customize.
   
Prerequisites
MATLAB: Version R2019b or later.
COMSOL Multiphysics: Version 5.6 or later with LiveLink for MATLAB.
Optional: Familiarity with Python, MATLAB scripting and COMSOL modeling.

### Installation

Ensure that COMSOL with LiveLink for MATLAB is properly installed and licensed.
Test the connection by running a simple COMSOL model from MATLAB.

### Usage
Configure Your Model:

Open the main MATLAB script RAD4D_main.m.
Customize the path directory of the 3 plain text files:

Run the MATLAB Script:

This will generate a my_reaction_set.mph COMSOL file with your specified reaction set.

Open COMSOL:

Launch COMSOL Multiphysics.

Open the generated .mph file.

Generate a Space-dependent model

Set up any additional physicsl modules, studies or solvers if necessary.

Run the simulation and analyze the results.

### Examples
Time-Dependent Chemical Reaction:

Location: examples/Gold_set/
Description: Models a 0D HAuCl4 water solution under electron beam exposure chemical reaction evolves over time.

### License
This project is licensed under CC License. See the LICENSE file for details.

For more information, questions, or support, please open an issue on the GitHub repository or contact me.
