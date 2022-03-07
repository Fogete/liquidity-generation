pragma solidity =0.6.6;

import "./Distributor.sol";

contract OwnedDistributor is Distributor {
    address public admin;

    event SetAdmin(address newAdmin);

    constructor(
        address token_,
        address claimable_,
        address admin_
    ) public Distributor(token_, claimable_) {
        admin = admin_;
    }

    function editRecipient(address account, uint shares) public virtual {
        require(msg.sender == admin, "OwnedDistributor: UNAUTHORIZED");
        editRecipientInternal(account, shares);
    }

    function setAdmin(address admin_) public virtual {
        require(msg.sender == admin, "OwnedDistributor: NO AUTHORIZED");
        admin = admin_;
        emit SetAdmin(admin_);
    }
}
