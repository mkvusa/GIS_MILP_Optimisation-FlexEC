# A GIS-MILP Framework for Electric Vehicle Charging Station Placement and Optimization: A Case Study in Eindhoven, the Netherlands

This repository contains selected data, scripts, and results associated with the journal paper:

**“A GIS-MILP framework for electric vehicle charging station placement and optimization: A Case Study in Eindhoven, Netherlands”**, published in *Computers, Environment and Urban Systems*.

The project develops an integrated **Geographic Information System and Mixed-Integer Linear Programming framework** for planning electric vehicle charging stations. The framework combines spatial suitability analysis with optimization of charging station placement, travel time, investment cost, grid energy use, battery storage, and Vehicle-to-Grid flows.

The case study focuses on Eindhoven, the Netherlands.

---

## Summary

1. [Workflow](#workflow)  
2. [Datasets](#datasets)
3. [Requirements](#requirements) 
4. [Setup](#setup) 
5. [Outputs](#outputs)  
6. [Writing and Citation](#writing-and-citation)  
7. [Acknowledgement](#acknowledgement)  
8. [Further Reading](#further-reading)

---

## Workflow and Datasets

The workflow combines two main stages:

1. **GIS-based spatial suitability analysis**  
   Spatial data are processed to evaluate candidate locations for electric vehicle charging stations. The spatial analysis considers accessibility, proximity to demand, road network conditions, grid infrastructure, land-use context, and other relevant spatial variables.

2. **MILP-based optimization**  
   Candidate locations and spatial outputs from the GIS stage are used as inputs to a Mixed-Integer Linear Programming model. The optimization model selects charging station locations and operational decisions while considering cost, travel time, grid energy use, storage capacity, and V2G energy flows.

Data were obtained from open-access Dutch and international sources, including CBS, OpenStreetMap, public infrastructure datasets, and other spatial data providers. Some raw datasets may need to be downloaded directly from the original providers because of licensing or file-size limitations.

The repository includes selected processed inputs, optimization scripts, and output files used for analysis and visualization.

![Workflow of the project](location_allocation_optmization.jpg)

---

## Datasets

The datasets in this folder include GIS and MILP files. Due to the size of the GIS files, the road network, neighbourhood boundaries, and points of interest are not included in this repository. However, these datasets can be publicly accessed through [CBS](https://www.cbs.nl/), [PDOK](https://app.pdok.nl/viewer/), and [Esri Living Atlas of the World](https://livingatlas.arcgis.com/en/home/) `[Licensed]`.

## Requirements

The workflow was developed using the following software:

- [ArcGIS Pro](https://www.arcgis.com/index.html) `[Licensed]`
- [Gurobi Optimizer](https://www.gurobi.com/) `[Licensed academic/commercial]`
- [Python](https://www.python.org/) `[Free]`
- [R](https://www.r-project.org/) `[Free]`
- [QGIS](https://www.qgis.org/) `[Free, optional]`
- [LaTeX](https://www.latex-project.org/) `[Free]`
- [Microsoft Excel](https://www.microsoft.com/en-us/microsoft-365/excel) `[Licensed]`

## Setup
The model framework is set to integrate the spatial suitability of location using spatial regression analysis with MILP to optimize location, number, cost, travel time and investment cost for an optimized charging station network.

The model has two main objectives: monetary cost and Travel time. Monetary cost, referred to as MC, comprises the investment cost in land acquisition, BESS storage installation, and the cost of charging at the station, while the Travel cost is the cost of traveling to the EVCS to charge or discharge energy by the user. The setup allows for the assessment of these two objectives using a tradeoff for planning purposes. Read the manuscript for further details.


## Outputs
The data folder also includes the result files of the TT run and the MC run. These folders contain the outputs from the GIS suitability analysis and the MILP model. The specific folder names are [MC_run_results](MC_run_results) and [TT_results](TT_results). Each folder contains files related to the model outputs, with file names starting with `TT` or `MC` to differentiate the individual planning objective prioritization scenarios.

In the [Scripts](Scripts) folder, the scripts used in the study are presented. The main files in this folder are the MILP scripts labelled [TT_run_EVCS.ipynb](Scripts/TT_run_EVCS.ipynb) for the travel-time optimization scenario and [MC_run_EVCS.ipynb](Scripts/MC_run_EVCS.ipynb) for the monetary-cost optimization scenario. The folder also includes [MC_results_analysis.ipynb](Scripts/MC_results_analysis.ipynb), which was used to analyse the monetary-cost results. For further details, see the published article.

Main Python packages include:
python
pandas
numpy
geopandas
shapely
networkx
osmnx
gurobipy
matplotlib
seaborn
openpyxl


Furthermore, due to the size of the spatial data, these files are not included in this repository. However, a description of how the data were collected, processed, and used is detailed in the manuscript. The datasets can be accessed online from the original data providers.

## Writing and Citation
The manuscript was written and edited in LaTeX. See the final published copy

## Acknowledgement
Spatial thanks to the co-Authors, the chair group of spatial planning at Wageningen University, and the Dutch National Research Council(NWO)](https://www.nwo.nl/en/projects/kich1ed0320012) for funding the FlexECs project.
## Further Reading
