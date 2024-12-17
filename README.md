# Rad-4D
Rad-4D is a Livelink MATLAB script that generates COMSOL Multiphysics files (.mph) tailored for simulating (radiation) chemical networks in four-dimensional (4D) chemical, physical, geometrical, and temporal scenarios. This tool simplifies the implementation of complex models by facilitating the coupling of reaction kinetics and mass transport mechanism , such as diffusion, convection and electrostatic drift. It allows researchers to adapt their models for specific applications involving chemical solutions exposed to ionizing radiation, such as electrons or X-rays. 

Rad4D works with AuRaCh, which automates 0D radiolysis simulations and is detailed by Fritsch et al. (DOI:10.1002/advs.202202803).
Its working principle is described in:

## Table of Contents
- [Features](#features)
- [User Guide](#userguide)
- [Examples](#examples)
- [License](#license)

### Features
Validation of Input Files (AuRaCh): Ensures plain text files conform to required standards for MATLAB Livelink/COMSOL.

Automated COMSOL File Generation: Create ready-to-run COMSOL models using MATLAB.

4D Simulation Ready: Set up 0D chemical kinetics models ready to be expanded in 1D, 2D,3D dimensions and physics in a time-dependent study (4D).

Complex Geometries: Define and manipulate geometries that suit your experimental setup.
Physical Processes: Integrate physical mass transport laws into your models.
User-Friendly Scripts: Well-documented MATLAB environment that's easy to customize.
   
# User Guide for Radiolysis Simulations and Model Validation via AuRaCh, MATLAB, and COMSOL

## Software Requirements:
- Python with AuRaCh script
- MATLAB with Rad4D script and Livelink for MATLAB installed
- COMSOL Multiphysics with access to a COMSOL Server

## Step-by-Step Workflow:

### 1. Running AuRaCh Python Script:
- Launch the AuRaCh by executing the script in Python. Ensure that the input files are correct as provided here (`C0_name.txt`, `reactions_name.txt`,`settings.txt`).
- Launch the AuRach2COMSOL by executing the script in Python. Ensure that the output data files (`C0_name_COMSOL.txt`,`Reactions_name_COMSOL.txt` are saved in an accessible location for MATLAB.

### 2. Processing with MATLAB and Livelink for MATLAB:
- **Start MATLAB:**
  - open MATLAB via the configured shortcut.
- **Prepare MATLAB Environment:**
  - Open the script `Rad4D.m`.
  - Update the file path in the script (line 22) to point to the directory containing files from AuraCh (`C0_name_COMSOL.txt`,`Reactions_name_COMSOL.txt`,`Parameters_dose.txt`)
  - Modify the file names within the script to match your specific text files (replace `name.txt` in the corresponding lines; line 37 > "C0_name.txt", line 61 > "Parameters_dose.txt", line 78 > "Reactions_name.txt").
- **Execute the Script:**
  - Run the `Rad4D.m` script in MATLAB and wait for it to complete. Verify that a `ModelClient` object appears in the MATLAB workspace.

### 3. Importing and Configuring the Model in COMSOL:
- **Connect to COMSOL Server:**
  - Open `COMSOL Multiphysics` 
  - Navigate to `File > COMSOL MULTIPHYSICS server > Connect to server` to establish a server connection.
- **Import Model:**
  - Go to `File > COMSOL MULTIPHYSICS server > Import application from server > my_reaction_set.mph`.
- **Model Setup:**
  - Check that the species labels match configurations under `Reaction Engineering > Initial Values,  Reaction Engineering > Additional Sources`.
  - Ensure radiation dose consistency in number and unit (e.g., `dose rate` in AuRaCh and `PHI` in COMSOL).

### 4. Running the Model and Comparing Results:
- **Model Execution:**
  - Adjust study settings appropriately and run the model.
  - Right-click on `Study 1` then select `Show Default Solver`.
  - Navigate to `Solution 1 > Time Dependent Solver 1` and set:
    - `Time Stepping` as logarithmic.
    - `Steps taken by solver` as intermediate.
  - Click on `Study 1 > Compute`.
  - Review the results:
    - Find the concentration evolution already plotted under `Results > Concentration(re)`.
    - Access the solution data under `Datasets > Study 1 / Solution 1`.
- **Data Comparison and Visualization:**
  - Review the concentration evolution in `Results > Concentration(re)`, which should already be plotted under linear scale.
  - Under `Results > Derived values > Global Evaluation > Settings`, set the unit to M and evaluate.
  - Import the `reactions_name_number_Gys.csv` file from AuRaCh by right-clicking on tables in COMSOL: `Tables > Table > Import...`.
  - Configure and plot the imported data in a unified 1D plot group for comparison.

## Final Steps:
- **Model Expansion:**
  - Under Reaction Engineering > Generate-Space Dependent Model 
  - Select appropriate geometry and physics directly through the configured window.
  - Expand and refine the model based on initial results and computational feedback.

### License
This project is licensed under GNU License. See the LICENSE file for details.

For more information, questions, or support, please open an issue on the GitHub repository or contact me.
