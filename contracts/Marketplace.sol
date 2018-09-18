pragma solidity ^0.4.24;


// import "github.com/OpenZeppelin/zeppelin-solidity/contracts/math/SafeMath.sol";
// import "github.com/OpenZeppelin/zeppelin-solidity/contracts/token/ERC20/IERC20.sol";

import 'openzeppelin-solidity/contracts/math/SafeMath.sol';
import 'openzeppelin-solidity/contracts/token/ERC20/IERC20.sol';



contract Marketplace {
  using SafeMath for uint256;

  // The token being sold
  IERC20 private _toksec;
  
  struct offer{
    uint256 price;
    address seller;
  }

  offer[] private _offers;
  uint256 private _nbOffers;
  

  event toksecPurchased(address indexed purchaser, address indexed seller, uint256 price, uint256 amount );

  constructor(IERC20 token) public {
    require(token != address(0));
    _toksec = token;
  }


  function token() public view returns(IERC20) {
    return _toksec;
  }
  
  function offerInfo(uint256 index) public view returns(uint,address){
      return (_offers[index].price,_offers[index].seller);
  }
  
    function nbOffers() public view returns(uint){
      return _nbOffers;
  }
  

  function listOffer(uint256 price) public{
    offer memory newOffer;
    newOffer.price = price;
    newOffer.seller = msg.sender;
    _offers.push(newOffer);
  }

  function buyOffer(uint256 offerNumber) public payable{
    //!!Using offerNumber as reference may cause errors if > 1 purchase per block
    require(msg.value>=_offers[offerNumber].price);

    
  }

}