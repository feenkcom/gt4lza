# Glamorous Toolkit for LZA

An extension  Glamorous Toolkit for editing and visualizing AWS LZA (Landing Zone Accelerator) configurations.

## Installation

In a Glamorous Toolkit image, load the code and associated documentation by executing the following snippet:
```st
Metacello new
	repository: 'github://feenkcom/gt4lza:main/src';
	baseline: 'Gt4LZA';
	load.
#BaselineOfGt4LZA asClass loadLepiter
```
