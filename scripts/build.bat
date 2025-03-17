cd ..
mkdir out
cd curseforge/fabric
packwiz cf export
move Feather-*.zip ../../out
cd ../../modrinth/fabric
packwiz mr export
move Feather-*.mrpack ../../out
