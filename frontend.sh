read -p "Enter the folder name for the portal [portal]: " folder
folder=${folder:-portal}

mkdir $folder

echo "\n\n#####################################################\nInstalling Node.js v16.x using NodeSource..."
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs

echo "\n\n#####################################################\nInstalled the following Node.js versions:"
node -v
npm -v

echo "\n\n#####################################################\nCloning the MVG portal repository..."
git clone -b portal https://github.com/deltaDAO/Ocean-Market $folder

echo "\n\n#####################################################\n"
echo "You are all set!"
echo "Use 'cd $folder' to change to the portal directory"
echo "There you can install dependencies via 'npm install' and you can boot up a local portal by using 'npm start' afterwards."
echo "\n#####################################################"