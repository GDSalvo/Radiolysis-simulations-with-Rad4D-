# Rad-4D
Rad-4D is a Livelink MATLAB script that generates COMSOL Multiphysics files (.mph) tailored for the finite-element modeling of (radiation) chemical networks in chemically, physically, geometrically realistic and time-dependent (i.e., 4D) scenarios. It simplifies the implementation of complex models by facilitating the coupling of reaction kinetics and mass transport mechanisms, such as diffusion, convection and electrostatic drift. It thereby allows researchers to adapt their models for specific applications of complex reaction kinetics including chemical solutions exposed to ionizing radiation, such as electrons or X-ray. Rad-4D is configured to work with validated output files that can be generated with the latest version of the automated radiation chemistry tool AuRaCh  [(Link)](https://github.com/BirkFritsch/Radiolysis-simulations) developed by Birk Fritsch et al. The workflow provides users with a one-click solution for their customized use cases, requiring only little experience in scientific coding.

Its working principle is described in:

## Table of Contents
- [Features](#features)
- [User Guide](#userguide)
- [License](#license)

### Features
Validation of Input Files (AuRaCh): Ensures plain text files conform to required standards for MATLAB Livelink/COMSOL.

Automated COMSOL File Generation: Create ready-to-run COMSOL models using MATLAB.

4D Simulation Ready: Set up 0D chemical kinetics models ready to be expanded in 1D, 2D,3D dimensions and physics in a time-dependent study (4D).

Complex Geometries: Define and manipulate geometries that suit your experimental setup.
Physical Processes: Integrate physical mass transport laws into your models.
User-Friendly Scripts: Well-documented MATLAB environment that's easy to customize.
   
# User Guide for Radiolysis Simulations and Model Validation via AuRaCh, MATLAB, and COMSOL

## Software Requirements

Ensure the following software and configurations are set up:

- Python: with AuRaCh script

- MATLAB: Version 2018a or later is required, with the Rad4D script and Livelink for MATLAB

- COMSOL Multiphysics: Version 5.4 or later is required. The essential module is the Reaction Engineering module. Additionally, the following modules are recommended:
  - Transport of Diluted Species (TDS)
  - Primary and Secondary Current Distribution
  - Tertiary Current Distribution (Nernst-Planck), essential for comprehensive electrochemical modeling.

## Step-by-Step Workflow:

### 1. Running AuRaCh Python Script:
- Launch the AuRaCh by executing the script in Python [(Link)](https://github.com/BirkFritsch/Radiolysis-simulations). Ensure that the input file names are correct as provided by authors (`C0_name.txt`, `reactions_name.txt`,`settings.txt`).
- Launch the AuRach2COMSOL script in Python. Ensure that the output data files `C0_name_COMSOL.txt`,`Reactions_name_COMSOL.txt` are saved in an accessible location for MATLAB.
- Note that this first step can be skipped to test Rad4D with example files in the MATLAB folder of this repository. These files are equivalent to AuRaCh2COMSOL output files that are created following the previous two sub-steps. To the test the examples (H2O or HAuCl4), start at step 2.

### 2. Processing with MATLAB and Livelink for MATLAB:
- **Start MATLAB:**
  - Open Livelink for MATLAB via the configured shortcut in your desktop.
- **Prepare MATLAB Environment:**
  - Download from here and open the script `Rad4D.m`.
  - Update the file path in the script (line 22) to point to the directory containing files from AuraCh (`C0_name_COMSOL.txt`,`Reactions_name_COMSOL.txt`,`Parameters_dose.txt`)
  - Modify the file names within the script to match your specific text files (replace `name.txt` in the corresponding lines; line 24 > "C0_name.txt", line 25 > "Parameters_dose.txt", line 26 > "Reactions_name.txt").
- **Execute the Script:**
  - Run the `Rad4D.m` script in MATLAB and wait for it to complete. Verify that a `ModelClient` object appears in the MATLAB workspace.

### 3. Importing and Configuring the Model in COMSOL:
- **Connect to COMSOL Server:**
  - Open `COMSOL Multiphysics` 
  - Navigate to `File > COMSOL MULTIPHYSICS server > Connect to server` to establish a server connection.
- **Import Model:**
  - Go to `File > COMSOL MULTIPHYSICS server > Import application from server > my_reaction_set.mph`.
- **Import Validation:**
  - Check the correct configuration of the model under `Reaction Engineering > Initial Values,  Reaction Engineering > Additional Sources`.
  - Ensure radiation dose consistency in number and unit (e.g., `dose rate` in AuRaCh and `PHI` in COMSOL).

### 4. Running the Reaction Engineering (0D) Model:
- **Study/Solver Configurations:**
  - Right-click on `Study 1` then select `Show Default Solver`.
  - Navigate to `Solution 1 > Time Dependent Solver 1` and set:
    - `Time Stepping` as logarithmic.
    - `Steps taken by solver` as intermediate.
- **Model Execution:**
  - Click on `Study 1 > Compute`.
  - Review the results:
    - Find the concentration evolution already plotted under `Results > Concentration(re)`.
    - Access the solution data under `Datasets > Study 1 / Solution 1`.
   
### 5. Comparing Results:
- **Load External Results (AuRaCh):**
  - Import the `reactions_name_number_Gys.csv` file from AuRaCh by right-clicking on tables in COMSOL: `Tables > Table > Import...`.
- **Results Visualization:**
  - Under `Results > Derived values > Global Evaluation > Settings`, set the unit to M and evaluate.
  - Configure and plot the imported AuRaCh data in a unified line plot group.

### 6. Geometric and Physical Expansion:
- **Generation of a space dependent model:**
  - Under `Reaction Engineering > Generate-Space Dependent Model`
  - "Appropriate" model complexity depends on the irradiation scenario and parameter space, as well as the purpose of the model. Refer to the main manuscript for guidelines for model implementation [(Link)](https://doi.org/10.1016/j.isci.2025.112374).
  - Expand and refine the model based on initial results and computational feedback.
- **Meshing Requirements:**
  - Users should select user-defined meshing options to have full control over meshing parameters, allowing for tailored configurations that meet specific project needs.
  - Incorporating meshing adds complexity to both the implementation and the solution of the model. For detailed strategies on mesh refinement and its impact on model fidelity, refer to the main publication [(Link)](https://doi.org/10.1016/j.isci.2025.112374) and previous studies  [(Link)](https://iopscience.iop.org/article/10.1088/2632-959X/acad18)
  - It is crucial to conduct mesh convergence studies to prove the accuracy of the model. These studies help in identifying the best mesh that minimize errors while maximizing computational efficiency.
- **Study Types:**
  - Implement time-dependent, stationary, and concatenated studies. For additional guidance and advanced configurations, refer to the COMSOL Multiphysics manuals [(Link)](https://doc.comsol.com/5.5/docserver/#!/com.comsol.help.comsol/comsol_ref_solver.27.001.html)
- **Results Visualization:** 
  - Evaluate tables and plots (line, maps, movies) to visually represent the results.
  - Use Livelink for MATLAB to manipulate data and plots with a scripting environment, refer to the user guide. [(Link)](https://doc.comsol.com/5.4/doc/com.comsol.help.llmatlab/LiveLinkForMATLABUsersGuide.pdf)
 

### License
This project is licensed under GPL v3.0 License. See the LICENSE file for details.

For more information, questions, or support, please open an issue on the GitHub repository or contact me.
