// SPDX-License-Identifier: MIT

pragma solidity ^0.8.2;

import '../node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol';
import '../node_modules/@openzeppelin/contracts/access/Ownable.sol';

//gaper x cam

contract ChiptoPunks is ERC721Enumerable, Ownable {
    string _baseTokenURI;
    uint256 public maxChips;
    uint256 private chipPrice = 0.002 ether;
    uint256 public saleStartTimestamp = 1629500400;

    constructor() ERC721("ChiptoPunks", "CHIP")  {
        maxChips = 512;
    }


    function mintChip(uint256 chipQuantity) public payable {
        uint256 supply = totalSupply();
        require( block.timestamp >= saleStartTimestamp, "Not time yet");
        require( chipQuantity < 4, "3 Max" );
        require( supply + chipQuantity <= maxChips, "Exceeds maximum supply" );
        require( msg.value >= chipPrice * chipQuantity,"TX Value not correct" );

        for(uint256 i; i < chipQuantity; i++){
            _safeMint( msg.sender, supply + i );
        }
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }

    function setBaseURI(string memory baseURI) public onlyOwner {
        _baseTokenURI = baseURI;
    }

    function setTime(uint256 newTime) public onlyOwner {
        saleStartTimestamp = newTime;
    }

    function reserveChips() public onlyOwner {
        uint supply = totalSupply();
        uint i;
        for (i = 0; i < 8; i++) {
            _safeMint(msg.sender, supply + i);
        }
    }

    /**
     * @dev Withdraw ether from the contract
    */
    function withdraw() onlyOwner public {
        uint balance = address(this).balance;
        payable(msg.sender).transfer(balance);
    }
}
