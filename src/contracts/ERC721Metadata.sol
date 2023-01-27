// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './interfaces/IERC721Metadata.sol';
import './ERC165.sol';

contract ERC721Metadata is IERC721Metadata, ERC165{

//we do not want the varaible to be visible of the metadata to be visible that's why we have to set it private
    string private _name;
    string private _symbol;

    constructor(string memory named, string memory symbolified){

        _name = named;
        _symbol = symbolified;

        _registerInterface( bytes4(keccak256('name()')^keccak256('symbol(bytes4)')));
    }

    //we want to create a function to access the variable

    function name() external override view returns(string memory){

        return _name;
    }

      function symbol() external override view returns(string memory){

        return _symbol;
    }

   
}