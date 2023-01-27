// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//the . is bcus both contract are in the same directory, / tells it to look for it
import './ERC721Metadata.sol';
//import './ERC721.sol'; since we already inherit it in ERC721Enumerable so we just keep only ERC721Enumerable
import './ERC721Enumerable.sol';

contract ERC721Connector is ERC721Metadata, ERC721Enumerable{

    //when we deploy the ERC271Connector, we want it to tranfer the metadata over, thus this will then be carried
    //over to the HBOiBirdz

//Remember that ERC721Metadata needs two aurgument
    constructor(string memory name, string memory symbol) ERC721Metadata(name, symbol){

    }
}