const hre = require("hardhat");

async function main() {
 
  const Marketplace = await hre.ethers.getContractFactory("NFTMarketplace");
  const marketplace = await Marketplace.deploy("NFT Accelerator", "NFTA");

  await marketplace.deployed();

  console.log("Marketplace deployed to:", marketplace.address);
  saveConfigFiles(marketplace.address, "NFTMarketplace");
}

function saveConfigFiles(address, name) {
  const fs = require("fs");
  var path = require('path');
  const backendDir = path.join(__dirname, "../configs");
  if(!fs.existsSync(backendDir)) {
    fs.mkdirSync(backendDir);
  }
  const network = hre.network.name;
  fs.writeFileSync(backendDir + `/${name}-${network}.json`,
    JSON.stringify({address: address}, undefined, 2)      // this should also be copied to the frontend
  );

  const abiSource = path.join(__dirname, `../artifacts/contracts/${name}.sol/${name}.json`);
  const abiDestination = path.join(__dirname, `../configs/${name}.json`); // this should be copied to the frontend
  fs.copyFileSync(abiSource, abiDestination);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
