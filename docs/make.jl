using Documenter
using WorldMapData

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