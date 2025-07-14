:: Batch file used to build the current pack files.
:: Updated: 12/07/2025

@echo OFF
CLS
TITLE Modpack Build

:: Create out directory if it doesn't already exist
echo "Starting build:"
cd ..
if exist out\ (
    echo "Found existing output. Removing old files..."
    rmdir /S /Q out
) || echo "Creating new output folder"
mkdir out

:: Build Curseforge files
echo: & echo "Building curseforge files"
cd curseforge
FOR %%A IN (fabric, quilt) DO (
    echo "Start build: %%A ->"
    cd %%A
    packwiz cf export
    move Feather-*.zip ../../out
    echo "%%A build complete!" & echo:
    cd ..
)

:: Build Modrinth files
echo "Building curseforge files"
cd ../modrinth
FOR %%A IN (fabric, quilt) DO (
    echo "Start build: %%A ->"
    cd %%A
    packwiz mr export
    move Feather-*.mrpack ../../out
    echo "%%A build complete!" & echo:
    cd ..
)

echo "Script completed!"
PAUSE