# WorldMapData.jl Documentation

Welcome to the WorldMapData.jl documentation! This package provides access to 
GSHHS world map data. The data provides information on landmass, water, and 
political boundaries.

You can find and download the original dataset from here https://www.soest.hawaii.edu/pwessel/gshhg/

The package provides the following function to interact with the dataset:

```@docs
valid_resolution
load_GSHHS_data
load_WDBII_border_data
load_WDBII_river_data
```