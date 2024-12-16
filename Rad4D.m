function out = model
%
%Created on Fri Dec 13 2022
%
%Rad-4D
%
%Rad-4D is a Livelink MATLAB script that generates COMSOL Multiphysics files (.mph) tailored for simulating (radiation) chemical networks in four-dimensional (4D) chemical, physical, geometrical, and temporal scenarios. This tool simplifies the implementation of complex models by facilitating the coupling of reaction kinetics and mass transport mechanism , such as diffusion, convection and electrostatic drift. It allows researchers to adapt their models for specific applications involving chemical solutions exposed to ionizing radiation, such as electrons or X-rays. 
%
%This tool simplifies the implementation of time-dependent chemical reaction simulations, providing users with a one-click solution for extending their models to incorporate additional physical phenomena or setup geometries. Rad4D integrates with AuRaCh, developed by Fritsch et al. (DOI:10.1002/advs.202202803), which provides 0D validation and generates text files formatted for direct input into Rad4D.
%
%Its working principle is described in:
%
%@author: Giuseppe De Salvo, Birk Fritsch
%

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

% insert the correct path where .txt files and model.m are present
Path='C:\Users\giuse\Downloads\TEST SI'
model.modelPath(Path);


model.component.create('comp1', true);

model.component('comp1').physics.create('re', 'ReactionEng');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').activate('re', true);

%% Parameters defined outside the component 

% Import the file Species
filename = 'C0_HAUCl4_COMSOL.txt';
T = readtable(filename,'Format','%s%s%s')

Species=table2cell(T(:,1))

InitialValues =table2cell(T(:,2))

for i=1:length(Species) 
it="R"+ Species(i)
iv=InitialValues(i)
model.param.set(it,iv);
end

gValues =table2cell(T(:,3))

for i=1:length(Species) 
gt="g"+ Species(i)
gv=gValues(i) 
model.param.set(gt,gv);
Gt="G"+Species(i)
model.param.set(Gt,"(rho*phi*g"+ Species(i)+")/(F)");
end

% Import the file Parameters.txt
filename = 'Parameters_dose.txt';
T2 = readtable(filename,'Format','%s%s')

Tags=table2cell(T2(:,1))

Values=table2cell(T2(:,2))

for i=1:length(Tags) 
dt=Tags(i)
dv=Values(i) 
model.param.set(dt,dv);
end


%% The reaction set OD component

% import the file Reactions.txt
filename = 'Reactions_HAuCl4_COMSOL.txt';
T3 = readtable(filename,'Format','%s%s%s')

nReactions=table2cell(T3(:,1))

formula=table2cell(T3(:,2))

constant=table2cell(T3(:,3))


for i=1:length(nReactions)
    nr="rch"+ nReactions(i)
    model.component('comp1').physics('re').create(nr, 'ReactionChem', -1);
    model.component('comp1').physics('re').feature(nr).set('formula', formula(i));
    model.component('comp1').physics('re').feature(nr).set('kf', constant(i));
end

model.component('comp1').physics('re').prop('mixture').set('mixture', 'liquid');
%% Set the beam generation terms

model.component('comp1').physics('re').create('add1', 'AdditionalSourceFeature', -1);

for i=1:length(Species) 
    Gt="G"+Species(i)
    model.component('comp1').physics('re').feature('add1').setIndex('AddR', Gt, i-1, 0);
end


for i=1:length(Species) 
    Rt="R"+Species(i)
    model.component('comp1').physics('re').feature('inits1').setIndex('initialValue', Rt, i-1, 0);
end 

%% Name the model
model.label('my_reaction_set.mph');


out = model;
