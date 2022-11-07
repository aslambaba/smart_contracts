pragma solidity ^0.5.0;

contract MyWills{
    address public owner;
    address public owner_friend;
    address  payable[] public WillAddress;
    mapping(address=>uint) public wills;
    constructor(address friend_add) payable public{
        owner = msg.sender;
        owner_friend = friend_add;
    }

    modifier OwnerOnly{
        if(msg.sender == owner){
            _;
        }
    }
    modifier OwnerFriend{
        if(msg.sender == owner || msg.sender == owner_friend){
            _;
        }
    }

    function MakeNewWill(address payable person,uint amount) public OwnerOnly{
        WillAddress.push(person);
        wills[person] = amount;
    }

    function PayoutWills() payable public OwnerFriend{
        for(uint i=0;i<WillAddress.length;i++){
            WillAddress[i].transfer(wills[WillAddress[i]]);
        }
    }

}
