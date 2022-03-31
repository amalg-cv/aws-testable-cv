//SPDX-License-Identifier: MIT

pragma solidity >=0.8.4 <0.9.0;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract NFTMarketplace is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenId;
    Counters.Counter private _soldItems;

    address payable private owner;
    uint256 private listingFee = 0.0001 ether;
    uint256 private commissionBasis = 250;
    uint256 private royaltyBasis = 1000;

    struct MarketItem {
        uint256 tokenId;
        address payable seller;
        address payable owner;
        address payable creator;
        uint256 price;
        bool sold;
    }

    event MarketItemCreation(
        uint256 indexed tokenId,
        address seller,
        address owner,
        address creator,
        uint256 price,
        bool sold
    );

    constructor(string memory name, string memory symbol) ERC721(name, symbol) {
        owner = payable(msg.sender);
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "not authorized to update listing fee");
        _;
    }

    function updateListingFee(uint256 _listingFee) public onlyOwner {
        listingFee = _listingFee;
    }

    function getListingFee() public view returns (uint256) {
        return listingFee;
    }

    function updateCommissionBasis(uint256 _commissionBasis) public onlyOwner {
        commissionBasis = _commissionBasis;
    }

    function calculateCommission(uint256 price) public view returns (uint256) {
        uint256 commission = (price * commissionBasis) / 10000;
        return commission;
    }

    function updateRoyaltyBasis(uint256 _royaltyBasis) public onlyOwner {
        royaltyBasis = _royaltyBasis;
    }

    function calculateRoyalty(uint256 price) public view returns (uint256) {
        uint256 royalty = (price * royaltyBasis) / 10000;
        return royalty;
    }
}
