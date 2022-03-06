pragma solidity =0.6.6;

import "../interfaces/IToken.sol";
import "../interfaces/IClaimable.sol";
import "../interfaces/IVester.sol";

contract VesterOneStep is IVester, IClaimable {
    uint public constant override segments = 1;

    address public immutable token;
    address public recipient;

    uint public immutable override vestingAmount;
    uint public immutable override vestingBegin;
    uint public immutable override vestingEnd;

    constructor(
        address token_,
        address recipient_,
        uint vestingAmount_,
        uint vestingBegin_,
        uint vestingEnd_
    ) public {
        token = token_;
        recipient = recipient_;

        vestingAmount = vestingAmount_;
        vestingBegin = vestingBegin_;
        vestingEnd = vestingEnd_;
    }

    function setRecipient(address recipient_) public {
        recipient = recipient_;
    }

    function claim() public override returns (uint amount) {
        require(msg.sender == recipient, "Vester: UNAUTHORIZED");
        uint blockTimestamp = getBlockTimestamp();
        if (blockTimestamp < vestingBegin) return 0;
        amount = IToken(token).balanceOf(address(this));
        IToken(token).transfer(recipient, amount);
    }

    uint _blockTimestamp;

    function getBlockTimestamp() public view virtual returns (uint) {
        return _blockTimestamp;
    }

    function setBlockTimestamp(uint blockTimestamp) public {
        _blockTimestamp = blockTimestamp;
    }
}
