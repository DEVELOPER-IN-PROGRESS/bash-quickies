#!/bin/bash

#Color Palettes
cyan="\033[1;36m" #heading
red="\033[1;31m" #errors
blue="\033[1;34m" #loading
green="\033[1;32m" #success
yellow="\033[1;33m" #warning
purple="\033[0;35m"  #title names
lpurple="\033[1;35m"  #light purple
ENDCOLOR="\033[0m"

#Title
echo -e "${red}"
echo "
███    ███ ███████ ██████  ███   ██      ███████ ███    ███ ██ ████████ ██   ██ 
████  ████ ██      ██   ██ ████  ██      ██      ████  ████ ██    ██    ██   ██ 
██ ████ ██ █████   ██████  ██ ██ ██ ████ ███████ ██ ████ ██ ██    ██    ███████ 
██  ██  ██ ██      ██   ██ ██  █ ██           ██ ██  ██  ██ ██    ██    ██   ██ 
██      ██ ███████ ██   ██ ██   ███      ███████ ██      ██ ██    ██    ██   ██ 
"
echo -e "${ENDCOLOR}"

echo -e "${blue}"
echo "Version : 4.2"
echo -e "Author(s): stack-overflow, johns"
echo -e "${ENDCOLOR}"

sleep 2
#clear
echo -e "${purple}MERN Backend Project Setup Starting..${ENDCOLOR}"
sleep 1
#Step 1 create a project directory
echo ""

while true; do
	read -r -p "$(echo -e "${green}Enter Project name${ENDCOLOR}:")" project
	if [[ -n $project  ]]; then 
		echo ""
		break
	else 
	   echo "project name cannot be empty"
	fi
done

server__=app

#read -r -p "$(echo -e ${green}Enter Project name${ENDCOLOR}:)" server_variable

read -rp "$(echo -e "${green}Enter Server Name${ENDCOLOR}:")" server_variable
server__=${server_variable:-app}

echo -e "${blue} $server__ ${ENDCOLOR}"

mkdir -p $project  

#Step 2 change path into directory 
echo -e "\n${blue}Switching into project directory...${ENDCOLOR}"
cd $project

#3  run the init command 
echo -e "\n${yellow}setting up the package.json file ${ENDCOLOR}" 
sleep 0.5
npm init -y

echo -e "${blue}installing the required packages wait a minute.... ${ENDCOLOR}\n"

npm install cors dotenv express mongoose jsonwebtoken bcrypt multer
#demo only
#npm install jsonwebtoken
npm install --save-dev nodemon

sleep 1
echo -e "${green}node modules installation complete ${ENDCOLOR}"

sleep 1
echo ""

echo -e "${yellow} Creating required folders.. ${ENDCOLOR}"
mkdir -p models controllers 
touch models/baseModel.js controllers/baseController.js
touch databaseconnection.js

cat > databaseconnection.js << EOL
const mongoose = require('mongoose');
mongoose.connect(process.env.DATABASE)
  .then(() => console.log(' MongoDB connected'))
  .catch(err => console.error('MongoDB error:', err));
EOL

echo ""
echo -e "${green}Folders created ${ENDCOLOR}"

# create  the index.js file 
echo -e "\n ${green} Creating  server file ... ${ENDCOLOR}"
sleep 1
touch index.js .env  .gitignore 

sleep 1
#5 
cat > index.js << EOL
const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
require('dotenv').config();
const route = require('./routes' );

const $server__ = express();
$server__.use(cors());
$server__.use(express.json());

$server__.use(route);
//require('./databaseconnection');

const PORT = process.env.PORT || 5000;
$server__.listen(PORT, () => console.log(\` Server running on port \${PORT}\`));
EOL

echo -e "\n  creating routes.."
touch routes.js

cat > routes.js << EOL 
const express = require('express')
const route = new express.Router();
const baseController = require('./controllers/baseController');

//change path as per requirement
route.get('/all-users' , baseController.getAllUsers);

module.exports = route
EOL

cat > models/baseModel.js << EOF
const mongoose = require('mongoose');

const baseSchema = new mongoose.Schema({
	name:{
		type:String,
		required:true
	},
	password:{
		type:String,
		required:true
	},
	age:{
		type:Number,
		required:true
	}
})

const base = mongoose.model("base" , baseSchema);
module.exports = base;
EOF

cat > controllers/baseController.js << EOF

exports.getAllUsers=async(req,res)=>{
	try{
		console.log('inside the get controller');
		// statements
		res.status(200).json({'success':'200'})
	}catch(error){
		res.status(500).json(error);
	}	
}
	
EOF

echo -e "\n ${green}Writing  .env file ${ENDCOLOR}"
echo -e  "PORT=5000\nDATABASE=" > .env
echo -e "\nadding to gitignore file"
echo -e "node_modules\n.env\nuploads/"  > .gitignore
sleep 1
echo -e "setup completed"
echo -e "\n adding watch scripts...."

npx  npm-add-script -k "start"  -v "node index.js"

echo -e "${yellow}Initializing git repository...${ENDCOLOR}"
git init 

echo -e "${green}setup complete thank you for waiting ... ${ENDCOLOR}"
sleep 1

#echo -e "\n ${cyan}running the project server..${ENDCOLOR}"

echo -e "\n ${yellow}Purging the run scripts.... ${ENDCOLOR}"

sleep 1
clear

#cd $project
#nodemon start

echo -e "\nDone. Now run: "
#echo -e "cd $project "
echo -e "nodemon start"
echo -e "${green}Thank You for waiting .. ${ENDCOLOR}"

sleep 1
echo -e "${yellow} opening vscode..${ENDCOLOR}"
sleep 0.5
code .
sleep 1
echo ""

#
sleep 2
cd ..
clear 

whoami=$(basename "$0")
touch nuke.sh

#delete the main runfile
echo -e "shred -ufz $whoami" >> nuke.sh
echo "sleep 0.5" >> nuke.sh
echo "rm nuke.sh" >> nuke.sh
#echo "ok bye.. goodnight"
#echo "exit" >> nuke.sh

sleep 1.2
bash nuke.sh
