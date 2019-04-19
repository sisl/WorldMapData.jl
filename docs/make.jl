using Documenter
using WorldMapData

include("src/makeplots.jl")

# Generate documents
makedocs(
    modules   = [WorldMapData],
    doctest   = false,
    clean     = true,
    linkcheck = true,
    format    = Documenter.HTML(),
    sitename  = "WorldMapData.jl",
    authors   = "Duncan Eddy",
    pages     = Any[
        "Home" => "index.md",
    ]
)

# Generate plots
# makeplots()

deploydocs(
    repo = "github.com/sisl/WorldMapData.jl",
    devbranch = "master",
    devurl = "latest",
)