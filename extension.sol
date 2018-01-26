pragma solidity ^0.4.18;
contract LendIt {
    address[] borrowers = [0x8aF9C90D7E3e27C6343C3De07A260a489872adCE, 0x83D1a618f37Cf08b64352755Bfad7b2a3b781F5b, 0x2F32a6eE63d73A16F9e50365A2e76f9f64124dee];
    uint totalLendable = 0;
    mapping(address => uint) lentMoney;
    function LendIt() public payable {
        updateTotalLendable();
    }
  function () public payable {
        updateTotalLendable();
    }
    function updateTotalLendable() internal {
        totalLendable += msg.value;
    }
    modifier canBorrow() {
        bool contains = false;
        for(uint i = 0; i < borrowers.length; i++) {
            if (borrowers[i] == msg.sender) {
                contains = true;
            }
        }
        require(contains);
        _;
    }
    function borrow() canBorrow public {
        uint amountLent = totalLendable/borrowers.length;
        uint amountBorrowed = lentMoney [msg.sender];
        uint amount = amountLent-amountBorrowed;
        lentMoney [msg.sender] = amountBorrowed + amount;
        if (amount > 0){
            msg.sender.transfer(amount);
        }
    }
}