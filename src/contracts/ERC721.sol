// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC165.sol';
import './interfaces/IERC721.sol';
/*
    we want to create a minting function

    a. we want the nft to point to an address, which is the person minting the nft
    b. keep track of the token IDs
    c. keep track of token owner addresses to token IDs
    d. keep track of tokens and owner address has
    e. an event to emit the transfer log, contract address, where it's minted to and its address ID

 */
contract ERC721 is ERC165, IERC721 {

    //mapping from token ID to owners
    mapping(uint256 => address) private _tokenOwner;

    //mapping from owners to number of ownned tokens
    
    mapping(address => uint256) private _ownedTokensCount;

    // mapping from token ID to approve addressess

    mapping (uint256 => address) private _tokenApprovals;


  constructor() {

        //kaccake256 is a crytpograhic hashing algorithm
     _registerInterface( bytes4(keccak256('balanceOf(bytes4)')^
     keccak256('ownerOf(bytes4)')^keccak256('transferFrom(bytes4)')));
    }


 // this balanceof function help us to check the balance of an address
    function balanceOf(address _owner) public override view returns(uint256){
        
        require(_owner != address(0), "ERC721: Invalid Address");
        return _ownedTokensCount[_owner];
    }

//this functions uses theb token ID to get the address
   
    function ownerOf(uint256 _tokenId) public override view returns(address){

        address owner = _tokenOwner[_tokenId];
        require(owner != address(0), 'ERC721: Address does not exist');
        return owner;
    }

    //function that check if the address exist with the tokenID

    function _exist(uint256 _tokenID) internal view returns(bool){

        address owner = _tokenOwner[_tokenID];

        //check with the ID if the address exist already
        return owner != address(0);

    }

    //this function set an address to it's token ID
    function _mint(address to, uint256 tokenID) internal virtual{


        //required that the addressing is not zero
        require(to != address(0), 'ERC721: Address should not be zero');
        
        //required that the address does not exist
        require(!_exist(tokenID), 'ERC721: Address already exist');

        _tokenOwner[tokenID] = to; //does the minting

        _ownedTokensCount[to] += 1; //increase the token count by 1

        emit Transfer(address(0), to, tokenID);

    }

   
    function _transferFrom(address _from, address _to, uint256 _tokenId) internal {

         //require that address receiving the token is not a zero address

         require( _to != address(0), "Sorry! Address not valid");

         //require that only owner can send token, using ownerOf, a function that as created above

        // require(ownerOf(_tokenId) == _from, "Sorry! only owner can send token");
         require( _from == msg.sender, "Sorry! only owner can send token");
        //add the token Id to the address receiving the token
        _tokenOwner[_tokenId] = _to;

        //update the balance of the account sending the token
        _ownedTokensCount[_from] -= 1;

         //update the balance of the account receiving the token

         _ownedTokensCount[_to] += 1;

        
        

         emit Transfer(_from, _to, _tokenId);
    }
    
    //this transferFrom function we can make public 
    function transferFrom(address _from, address _to, uint256 _tokenId) public override {

        require(isApprovedOrOwner(msg.sender, _tokenId));
        _transferFrom(_from, _to, _tokenId);
    }

    //the approval function
    function approve(address _to, uint256 _tokenId) public {

        address owner = ownerOf(_tokenId);

        //recever can't approve
        require(_to != owner, "Error-ERC71, Approval to current owner");

        //only owner can approve

    require(owner == msg.sender, "Only Owner can approve token!");

    //update the mapping of the approve address
    _tokenApprovals[_tokenId] = _to;


    emit Approval(owner, _to, _tokenId);
    }

    //a funtion to get if a token has been approve or is the owner

    function isApprovedOrOwner(address spender, uint256 _tokenId) internal view returns(bool){

        require(_exist(_tokenId),"Sorry! Token does not exist" );

        address owner = ownerOf(_tokenId);

        return(spender == owner);
    }

}