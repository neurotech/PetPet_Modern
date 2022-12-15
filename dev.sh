echo "Building PetPet_Modern and installing to WoW directories."

echo "Creating TOC file..."
touch PetPet_Modern.toc.tmp
cat PetPet_Modern.toc > PetPet_Modern.toc.tmp
sed -i "s/@project-version@/$(git describe --abbrev=0)/g" PetPet_Modern.toc.tmp

echo "Copying assets to Modern..."
mkdir -p /h/games/World\ of\ Warcraft/_retail_/Interface/AddOns/PetPet_Modern/
cp *.lua /h/games/World\ of\ Warcraft/_retail_/Interface/AddOns/PetPet_Modern/
cp PetPet_Modern.toc.tmp /h/games/World\ of\ Warcraft/_retail_/Interface/AddOns/PetPet_Modern/PetPet_Modern.toc

echo "Cleaning up..."
rm PetPet_Modern.toc.tmp

echo "Complete."