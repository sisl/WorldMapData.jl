# Delete folder 
if !isdir("./downloads")
    # Remove any file already in location
    rm("./downloads", force=true, recursive=true)

    # Create downloads folder
    mkdir("./downloads")

    # Download required data
    @debug "Download GSHHG data products..."
    download("http://www.soest.hawaii.edu/pwessel/gshhg/gshhg-shp-2.3.7.zip", "./downloads/gshhg-shp-2.3.7.zip")
end

# Ensure output folder exists
if !isdir("../data")
    mkdir("../data")

    # Unzip data
    @debug "Unzipping GSHHG data..."
    run(`unzip ./downloads/gshhg-shp-2.3.7.zip -d ../data`)
end
