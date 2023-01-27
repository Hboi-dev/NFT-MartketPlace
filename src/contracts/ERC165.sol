// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './interfaces/IERC165.sol';

    

contract ERC165 is IERC165{

       constructor() {

        //kaccake256 is a crytpograhic hashing algorithm
     _registerInterface( bytes4(keccak256('supportsInterface(bytes4)')));
    }


    
    //keep track of contract fingerprint data of bytes function conversion
    mapping (bytes4 => bool) private _supportsInterfaces;

 /*
 
 the funtion below is similiar to what we have in the interface but implimented. However, this function is overridding the one in the 
 interface because they are the same. 

 Overriding Function: Similar Function
 OverLoading Funtion: similiar Function but different number of Inputs
 
 */

    function supportsInterface(bytes4 interfaceID) external override view returns (bool){


        return _supportsInterfaces[interfaceID];
    }

    //Register the interface(This comes from within)

    // Since we set the constructor to deploy the _registerInterface, we do not need to set the scope 0f _registerInterface to public
    function _registerInterface(bytes4 interfaceID) internal {
        //require that the input interfaceID isnt a non bytes value
        require( interfaceID != 0xffffffff, "ERC165: Invalid Interface");
        _supportsInterfaces[interfaceID] = true;
    }
}