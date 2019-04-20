__precompile__(true)
module WorldMapData

using Printf
using Shapefile

const VALID_RESOLUTIONS = [
    :FULL,
    :HIGH,
    :INTERMEDIATE,
    :LOW,
    :CRUDE
]

export valid_resolution
"""
Return whether the input symbol is a valid resolution for GSHHS data.

Arguments:
    - `res::Symbol` Symbol to validate

Returns:
    - `valid::Bool` Boolean of resolution validity.
"""
function valid_resolution(res::Symbol)
    return res in VALID_RESOLUTIONS ? true : false
end

const RESOLUTION_LOOKUP = Dict(
    :FULL => "f",
    :HIGH => "h",
    :INTERMEDIATE => "i",
    :LOW => "l",
    :CRUDE => "c",
)

"""
Ensure that the shapefile exists at the specified path otherwise unzip the 
base file.

Arguments:
    - `path` Path to datafile
"""
function load_data(path)
    
    shp_path = path * ".shp"

    # if !isfile(shp_path)
    #     unzip(zip_path)
    # end

    # @debug "Loading datafile: $shp_path"
    handle = open(shp_path, "r") do io
        read(io, Shapefile.Handle)
    end

    return handle
end

export load_GSHHS_data
"""
Load GSHHS Shapefile data and return all polygons in the data set.

All data sets come in 5 different resolutions:
	- f : Full resolution.  These contain the maximum resolution
	    of this data and has not been decimated.
	- h : High resolution.  The Douglas-Peucker line reduction was
	    used to reduce data size by ~80% relative to full.
	- i : Intermediate resolution.  The Douglas-Peucker line reduction was
	    used to reduce data size by ~80% relative to high.
	- l : Low resolution.  The Douglas-Peucker line reduction was
	    used to reduce data size by ~80% relative to intermediate.
	- c : Crude resolution.  The Douglas-Peucker line reduction was
	    used to reduce data size by ~80% relative to low.

For each resolution there are several levels; these depends on the data type.

The shoreline data are distributed in 6 levels:
    - Level 1: Continental land masses and ocean islands, except Antarctica.
    - Level 2: Lakes
    - Level 3: Islands in lakes
    - Level 4: Ponds in islands within lakes
    - Level 5: Antarctica based on ice front boundary.
    - Level 6: Antarctica based on grounding line boundary.

Note that because GIS software confusingly seem to assume a Cartesian geometry,
any polygon straddling the Dateline is broken into an east and west component.
The most obvious example is Antarctica.
"""
function load_GSHHS_data(;resolution::Symbol=:CRUDE, level::Integer=1)
    # Check for valid inputs
    if !valid_resolution(resolution)
        throw(ArgumentError("Invalid GSHHS product resolution: $(string(resolution))"))
    end


    if !(1 <= level <= 6)
        throw(ArgumentError("Invalid data level $level - Must be between 1 and 6."))
    end

    if (resolution == :CRUDE) && (level == 4)
        throw(ArgumentError("Invalid combination resolution $resolution - level $level."))
    end

    path = joinpath(@__DIR__, 
                    "..", 
                    "data",
                    "GSHHS_shp", 
                    RESOLUTION_LOOKUP[resolution],
                    "GSHHS_$(RESOLUTION_LOOKUP[resolution])_L$level")


    return load_data(path)
end

export load_WDBII_border_data
"""
Load WDBI Shapefile data and return all polygons in the data set.

All data sets come in 5 different resolutions:
    - f : Full resolution.  These contain the maximum resolution
	    of this data and has not been decimated.
    - h : High resolution.  The Douglas-Peucker line reduction was
	    used to reduce data size by ~80% relative to full.
    - i : Intermediate resolution.  The Douglas-Peucker line reduction was
	    used to reduce data size by ~80% relative to high.
    - l : Low resolution.  The Douglas-Peucker line reduction was
	    used to reduce data size by ~80% relative to intermediate.
    - c : Crude resolution.  The Douglas-Peucker line reduction was
	    used to reduce data size by ~80% relative to low.

For each resolution there are several levels; these depends on the data type.

The political boundary data come in 3 levels:
    - Level 1: National boundaries.
    - Level 2: Internal (state) boundaries for the 8 largest countries only.
    - Level 3: Maritime boundaries.
"""
function load_WDBII_border_data(;resolution::Symbol=:CRUDE, level::Integer=1)
    # Check for valid inputs
    if !valid_resolution(resolution)
        throw(ArgumentError("Invalid WDBII product resolution: $(string(resolution))"))
    end

    if !(1 <= level <= 3)
        throw(ArgumentError("Invalid data level $level - Must be between 1 and 3."))
    end

    path = joinpath(@__DIR__, 
                    "..", 
                    "data",
                    "WDBII_shp", 
                    RESOLUTION_LOOKUP[resolution],
                    "WDBII_border_$(RESOLUTION_LOOKUP[resolution])_L$level")

    return load_data(path)
end

export load_WDBII_river_data
"""
Load WDBI Shapefile data and return all polygons in the data set.

All data sets come in 5 different resolutions:
    - f : Full resolution.  These contain the maximum resolution
	    of this data and has not been decimated.
    - h : High resolution.  The Douglas-Peucker line reduction was
	    used to reduce data size by ~80% relative to full.
    - i : Intermediate resolution.  The Douglas-Peucker line reduction was
	    used to reduce data size by ~80% relative to high.
    - l : Low resolution.  The Douglas-Peucker line reduction was
	    used to reduce data size by ~80% relative to intermediate.
    - c : Crude resolution.  The Douglas-Peucker line reduction was
	    used to reduce data size by ~80% relative to low.

For each resolution there are several levels; these depends on the data type.

The river database come with 11 levels:
    - Level  1: Double-lined rivers (river-lakes).
    - Level  2: Permanent major rivers.
    - Level  3: Additional major rivers.
    - Level  4: Additional rivers.
    - Level  5: Minor rivers.
    - Level  6: Intermittent rivers - major.
    - Level  7: Intermittent rivers - additional.
    - Level  8: Intermittent rivers - minor.
    - Level  9: Major canals.
    - Level 10: Minor canals.
    - Level 11: Irrigation canals.
"""
function load_WDBII_river_data(;resolution::Symbol=:CRUDE, level::Integer=1)
    # Check for valid inputs
    if !valid_resolution(resolution)
        throw(ArgumentError("Invalid WDBII product resolution: $(string(resolution))"))
    end

    if !(1 <= level <= 11)
        throw(ArgumentError("Invalid data level $level - Must be between 1 and 11."))
    end

    path = joinpath(@__DIR__, 
                    "..", 
                    "data",
                    "WDBII_shp", 
                    RESOLUTION_LOOKUP[resolution],
                    "WDBII_river_$(RESOLUTION_LOOKUP[resolution])_L$(@sprintf("%02d", level))")


    return load_data(path)
end

end # module
