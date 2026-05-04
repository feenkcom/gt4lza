# Glamorous Toolkit for LZA

An extension  [Glamorous Toolkit](https://gtoolkit.com) for editing and visualizing [AWS LZA](https://docs.aws.amazon.com/solutions/landing-zone-accelerator-on-aws/) (Landing Zone Accelerator) configurations.

## Installation

In a Glamorous Toolkit image, load the code and associated documentation by executing the following snippet:
```st
Metacello new
	repository: 'github://feenkcom/gt4lza:main/src';
	baseline: 'Gt4LZA';
	load.
#BaselineOfGt4LZA asClass loadLepiter
```

## What you get

Dedicated editing YAML files, including completion and exploration of references.
A model for analysis purposes, including a generated network graph.
