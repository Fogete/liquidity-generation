pragma solidity =0.6.6;

import "../interfaces/IToken.sol";
import "../interfaces/IClaimable.sol";

contract MockClaimable is IClaimable {
    address public immutable token;
    address public recipient;

    constructor(address token_, address recipient_) public {
        token = token_;
        recipient = recipient_;
    }

    function setRecipient(address recipient_) public {
        recipient = recipient_;
    }

    function claim() public override returns (uint amount) {
        amount = IToken(token).balanceOf(address(this));
        IToken(token).transfer(recipient, amount);
    }
}
