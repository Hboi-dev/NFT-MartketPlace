// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721.sol';
import './interfaces/IERC721Enumerable.sol';

contract ERC721Enumerable is ERC721, IERC721Enumerable{

    uint256 [] private _alltoken;

    //mapping from tokenID to position in alltoken arrays

    mapping (uint256 => uint256) private _alltokenIndex;

    //mapping from owner to list of tokenID

    mapping (address => uint256[]) private _ownedTokens;

    //mapping from token ID index to all the owner list

    mapping(uint256 => uint256) private _ownedTokenIndex;


    constructor() {

        //kaccake256 is a crytpograhic hashing algorithm
     _registerInterface( bytes4(keccak256('totalSupply(bytes4)')
     ^keccak256('tokenByIndex(bytes4)')^keccak256('tokenOfOwnerByIndex(bytes4)')));
    }


    //return the total supply of _alltoken array
    function totalSupply() public override view returns (uint256){

        

        return _alltoken.length;
    }

    
     function tokenByIndex(uint256 _index) public override view returns (uint256){

        require(_index < totalSupply(), "Global index is out of bound!");
        
        return _alltoken[_index]; // returns the index value
    }


     function tokenOfOwnerByIndex(address _owner, uint256 _index) public override view returns (uint256){
       
        require(_index < balanceOf(_owner), "Owner index is out of bound!");
        return _ownedTokens[_owner][_index];
    
     }

     function _mint(address to, uint256 tokenID) internal override(ERC721){
        super._mint(to, tokenID); // allow us grab _mint () from ERC721 

       _addTokenToAllEnumeration(tokenID); //we want the function to be called once the _mint() is called
       _addTokenToOwnerEnumeration(to, tokenID);
     }

    function _addTokenToOwnerEnumeration(address to, uint256 tokenId) private {

        _ownedTokens[to].push(tokenId); // adding the owner address and the token Id to _ownedToken
        _ownedTokenIndex[tokenId] = _ownedTokens[to].length; // _ownedTokenIndex tokenId set to the address of the _ownedTokens position

    }
    //add token to the token array and set the position of the indexes
     function _addTokenToAllEnumeration(uint256 tokenId) private{

        _alltokenIndex[tokenId] = _alltoken.length;
        _alltoken.push(tokenId); //add token to the list of arrays
     }


}