const LinkerConfig = require('./linkerConfig');
const AssetAssembly = require('./assetsAsm');

const fs = require('fs');

const assetsDir = './assets';
const linkerConfigFileName = './gametank-2M.cfg';


const dirInfo = fs.readdirSync(assetsDir);

const linkerText = LinkerConfig.generateLinkerConfig(dirInfo, 1);

fs.writeFileSync(linkerConfigFileName, linkerText);


AssetAssembly.generateAssetAssemblyFiles(dirInfo);