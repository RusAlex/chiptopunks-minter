import '../node_modules/@openzeppelin/contracts/access/Ownable.sol';
import '../node_modules/@openzeppelin/contracts/utils/math/SafeMath.sol';

/**
 * @title ERC721 token receiver interface
 * @dev Interface for any contract that wants to support safeTransfers
 * from ERC721 asset contracts.
 */
interface IERC721Receiver {
    /**
     * @dev Whenever an {IERC721} `tokenId` token is transferred to this contract via {IERC721-safeTransferFrom}
     * by `operator` from `from`, this function is called.
     *
     * It must return its Solidity selector to confirm the token transfer.
     * If any other value is returned or the interface is not implemented by the recipient, the transfer will be reverted.
     *
     * The selector can be obtained in Solidity with `IERC721.onERC721Received.selector`.
     */
    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external returns (bytes4);
}

interface IERC721 {
 function transferFrom(address _from, address _to, uint256 _tokenId) external payable;
}

interface IERC20 {
        function totalSupply() external view returns (uint256);

        function balanceOf(address account) external view returns (uint256);

        function transfer(address recipient, uint256 amount) external returns (bool);

        function allowance(address owner, address spender) external view returns (uint256);

        function approve(address spender, uint256 amount) external returns (bool);

        function transferFrom(
                address sender,
                address recipient,
                uint256 amount
        ) external returns (bool);

        event Transfer(address indexed from, address indexed to, uint256 value);
        event Approval(address indexed owner, address indexed spender, uint256 value);
}

interface Chips {
    function mintChip(uint256 amount) external payable;
}


contract Contract is IERC721Receiver, Ownable {
    // Equals to `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`
    // which can be also obtained as `IERC721Receiver(0).onERC721Received.selector`
    bytes4 private constant _ERC721_RECEIVED = 0x150b7a02;

    constructor() {

    }

    function buyChips(Chips target, uint numberOfCalls, uint numberPerCall) payable public {
        require(msg.value % numberOfCalls == 0, "Division error");
        uint256 perCallValue = msg.value / numberOfCalls;
        for (uint p = 0; p < numberOfCalls; p++) {
          target.mintChip{value: perCallValue}(numberPerCall);
        }

    }


    /**
     * @dev Withdraw ether from the contract
    */
    function withdraw() onlyOwner public {
        uint balance = address(this).balance;
        payable(msg.sender).transfer(balance);
    }

    // reclaim accidentally sent tokens
    function reclaimToken(IERC20 token, uint256 tokenAmount) public onlyOwner {
        require(address(token) != address(0));
        token.transfer(msg.sender, tokenAmount);
    }

    // reclaim accidentally sent tokens
    function reclaimNftToken(IERC721 token, uint256 tokenId) public onlyOwner {
        require(address(token) != address(0));
        token.transferFrom(address(this), msg.sender, tokenId);
    }

    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data) override external pure returns (bytes4) { return _ERC721_RECEIVED; }

}
