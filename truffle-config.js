// to customize our truffle
module.exports = {


  networks: {

  
    development: {
     host: "127.0.0.1",     // from our ganache RPC server
     port: 7545,            // still from our ganache RPC server
     network_id: "*",       // Any network, instead of typing the ganache id everytime
    },
  },

    contracts_directory: "./src/contracts/", // we moved the solidity doc to our contract folder and deleted it
    //so we are using this to tell truffle that we moved the contract folder it created to a diff directory 
    
    contracts_build_directory: './src/abis', // this build a new directory for our json file that we'// be creating
    

    
  // Configure our solidity compilers
  compilers: {
    solc: {
      version: "^0.8.17", // setting the solidity compiler version 
      // docker: true,        // Use "0.5.1" you've installed locally with docker (default: false)
      // settings: {          // See the solidity docs for advice about optimization and evmVersion
       optimizer: { //to optimize your complier
         enabled: true, // set to true
         runs: 200 // use the default 200 which is how big you want your project
       }
      //  evmVersion: "byzantium"
      // }
    }
  }

 
  // db: {
  //   enabled: false,
  //   host: "127.0.0.1",
  //   adapter: {
  //     name: "indexeddb",
  //     settings: {
  //       directory: ".db"
  //     }
  //   }
  // }
};


