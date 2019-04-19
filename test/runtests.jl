# Packages required for testing
using Test
using Logging

# Package Under Test
using WorldMapData

# Set logging level
global_logger(SimpleLogger(stderr, Logging.Debug))

# Define package tests
@time @testset "WorldMapData Package Tests" begin
    testdir = joinpath(dirname(@__DIR__), "test")
    @time @testset "WorldMapData.LoadData" begin
        include(joinpath(testdir, "test_load_data.jl"))
    end
end