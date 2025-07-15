:: Batch file used to build the current pack files.
:: Updated: 12/07/2025

@echo OFF
CLS
TITLE Modpack Build
setlocal enabledelayedexpansion

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
    for /R "." %%f in (*.zip) do (
        set _file=%%~nf
        set _ver=!_file:~8!
        IF %%A==fabric (
            rename Feather-3.1.zip Feather-V!_ver!-Fabric.zip
            move Feather-V!_ver!-Fabric.zip ../../out
        ) ELSE IF %%A==quilt (
            rename Feather-3.1.zip Feather-V!_ver!-Quilt.zip
            move Feather-V!_ver!-Quilt.zip ../../out
        )
    )
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
    for /R "." %%f in (*.mrpack) do (
        set _file=%%~nf
        set _ver=!_file:~8!
        IF %%A==fabric (
            rename Feather-3.1.mrpack Feather-V!_ver!-Fabric.mrpack
            move Feather-V!_ver!-Fabric.mrpack ../../out
        ) ELSE IF %%A==quilt (
            rename Feather-3.1.mrpack Feather-V!_ver!-Quilt.mrpack
            move Feather-V!_ver!-Quilt.mrpack ../../out
        )
    )
    echo "%%A build complete!" & echo:
    cd ..
)

echo "Script completed!"
PAUSE