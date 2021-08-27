interface Chips {
    function mintChip(uint256 amount) external payable;
}


contract Contract {
    constructor() {

    }

    function buyChips(Chips target) payable public {
       /* target.mintChip{value:5, gas: 800}(10); */
        target.mintChip{value: address(this).balance}(3);
    }
}
