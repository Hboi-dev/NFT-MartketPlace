// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC721Connector.sol";

contract HboiBirdz is ERC721Connector{

    //create an arrays to store our nft created

    string [] public hboiBirdz;

    //we need to set a mapping to check if our nft exist

    mapping(string => bool) _hboiBirdExist;

    constructor () ERC721Connector('HboiBirdz', 'HBIRDZ'){
        
    }

    //function that does the minting

    function mint(string memory _hboibird) public {

        require(!_hboiBirdExist[_hboibird], "Error - NFT already exist");
      // this method of getting the index with push is deprecated for complier version 0.8.0 but works for other version
      //  uint256 _id = HboiBirdz.push(_hboibird);

      hboiBirdz.push(_hboibird);

      uint _id = hboiBirdz.length - 1; // set the index

      _mint(msg.sender, _id); // this function is from the ERC721 contract that map the address to its token ID

        _hboiBirdExist[_hboibird] = true;
    }
}