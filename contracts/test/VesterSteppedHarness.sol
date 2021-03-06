pragma solidity =0.6.6;

import "../../contracts/VesterStepped.sol";

contract VesterSteppedHarness is VesterStepped {
    constructor(
        address token_,
        address recipient_,
        uint vestingAmount_,
        uint vestingBegin_,
        uint vestingEnd_
    ) public VesterStepped(token_, recipient_, vestingAmount_, vestingBegin_, vestingEnd_) {}

    uint _blockTimestamp;

    function getBlockTimestamp() public view virtual override returns (uint) {
        return _blockTimestamp;
    }

    function setBlockTimestamp(uint blockTimestamp) public {
        _blockTimestamp = blockTimestamp;
    }
}
