// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;


import "../node_modules/@openzeppelin/contracts/utils/Strings.sol";
import "../node_modules/erc721a/contracts/ERC721A.sol";
import "../node_modules/erc721a/contracts/extensions/ERC721ABurnable.sol";
import "../node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "../node_modules/@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

contract Tickets is ERC721A, ERC721ABurnable, Ownable{
    using Strings for uint256;

    //bytes32 public root = 0x65db95bce907178649fa7c289773149343c552dc70d646f84bdfccccd2436d68;
    uint256 MintPrice;
    uint256 TotalSupply;
    uint256 MaxSupply;
    uint256 maxperWallet;

    bool isPublicMintEnabled;
    bool public Revealed = false;
    bool public AllowListSale;
    string internal baseTokenUri = "https://ipfs.kittycoin.cat/ipfs/";
    address payable public withdrawWallet;
    mapping(address => uint256) public WalletMints;

constructor() payable ERC721A ('Tickets', 'KWT'){
    MintPrice = 0.06 ether;
    TotalSupply = 0;
    MaxSupply = 10000;
    maxperWallet = 3;

}

modifier callerIsUser() {
        require(tx.origin == msg.sender, "Kitty World Tickets :: Cannot be called by a contract");
        _;
}

function setisPublicMintEnabled(bool isPublicMintEnabled_) external onlyOwner{
    isPublicMintEnabled = isPublicMintEnabled_;
}

function setAllowListSale(bool _AllowListSale) external onlyOwner{
    AllowListSale = _AllowListSale;
}

function setBaseTokenUri(string calldata baseTokenUri_) external onlyOwner{
    baseTokenUri = baseTokenUri_;
}


function tokenUri(uint256 tokenId_) public view returns (string memory){
        require (_exists(tokenId_), "Token does not exist");
        return bytes(baseTokenUri).length > 0 ? string(abi.encodePacked(baseTokenUri, tokenId_.toString(), ".json")) : "";
        }

function withdraw() external onlyOwner{
    (bool success, ) = withdrawWallet.call {value: address(this).balance}("");
    require(success, "withdraw failed");
}

function mint(uint256 quantity_) external payable callerIsUser{
    require(isPublicMintEnabled, 'minting not currently enabled');
    require(msg.value == quantity_ * MintPrice, 'wrong amount');
    require((TotalSupply + quantity_) <= MaxSupply, 'sold out');
    require((WalletMints[msg.sender] + quantity_) <= maxperWallet, 'exceed max mints for this wallet');
    require(balanceOf(msg.sender) + quantity_ <= maxperWallet, 'wallet cannot mint more than 3 total');
    TotalSupply ++;
     _safeMint(msg.sender, quantity_);

}

function AllowListmint(uint256 quantity_) external payable callerIsUser{
    //require(isValid(_merkleProof, keccak256(abi.encodePacked(msg.sender))), "Not whitelisted");
    require(AllowListSale, 'minting not currently enabled');
    require(msg.value == quantity_ * MintPrice, 'wrong amount');
    require((TotalSupply + quantity_) <= MaxSupply, 'sold out');
    require(WalletMints[msg.sender] + quantity_ <= maxperWallet, 'exceed max mints for this wallet');
    require(balanceOf(msg.sender) + quantity_ <= maxperWallet, 'wallet cannot mint more than 3 total');
    TotalSupply ++;
     _safeMint(msg.sender, quantity_);

}


//function isValid (bytes32[] memory _merkleProof, bytes32 leaf) public view returns (bool){
  //  return MerkleProof.verify(_merkleProof, root, leaf);
//}
}