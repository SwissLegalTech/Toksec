pragma solidity ^0.4.24;
 
import 'openzeppelin-solidity/contracts/math/SafeMath.sol';
import 'openzeppelin-solidity/contracts/token/ERC20/IERC20.sol';

contract Toksec {
  using SafeMath for uint256;

  mapping (address => uint) private _balances;
  
  mapping (address => mapping (address => uint256)) private _allowed;
  uint256 private _totalSupply;

  string private _identifier;
  string private _company;
  address private _issuer;
  bool private _issuable= true;
  
  event Transfer(address indexed from, address indexed to, uint256 value);

  event Approval(address indexed owner, address indexed spender, uint256 value );

  constructor(string company, string identifier, uint256 nbShares) public {
    _issuer = msg.sender; // _issuer is identified to msg.sender for simplication purposes
    _identifier = identifier; 
    _company = company;
    _balances[msg.sender] = nbShares;
    _totalSupply = nbShares;
  }
  
  function totalSupply() public view returns (uint256) {
    return _totalSupply;
  }

  function company() public view returns (string) {
    return _company;
  }

  function balanceOf(address owner) public view returns (uint256) {
    return _balances[owner];
  }

/*  function allowance(address owner, address spender) public view returns (uint256){
    return _allowed[owner][spender];
  }
    */
  function transfer(address to, uint256 value) public returns (bool) {  
    require(value <= _balances[msg.sender]);
    require(to != address(0));

    _balances[msg.sender] = _balances[msg.sender].sub(value);
    _balances[to] = _balances[to].add(value);
    emit Transfer(msg.sender, to, value);
    return true;
  }
/*
  function approve(address spender, uint256 value) public returns (bool) {
    require(spender != address(0));

    _allowed[msg.sender][spender] = value;
    emit Approval(msg.sender, spender, value);
    return true;
  }
*/
  function transferFrom(address from, address to, uint256 value) public returns (bool){
    require(value <= _balances[from]);
    require(value <= _allowed[from][msg.sender]);
    require(to != address(0));

    _balances[from] = _balances[from].sub(value);
    _balances[to] = _balances[to].add(value);
    _allowed[from][msg.sender] = _allowed[from][msg.sender].sub(value);
    emit Transfer(from, to, value);
    return true;
  }

  function newIssuance( uint256 amount) public {
    require(msg.sender == _issuer);
    require(_issuable);
    _totalSupply = _totalSupply.add(amount);
    _balances[msg.sender] = _balances[msg.sender].add(amount);
    emit Transfer(address(0), msg.sender, amount);
  }


/*    function getDocument(bytes32 _name) external view returns (string, bytes32){
        return "kkk", "32";
    }
    function setDocument(bytes32 _name, string _uri, bytes32 _documentHash) external;
  issue
*/
  function issuable() external view returns (bool){
      return _issuable;
  }
  // function canSend(address _from, address _to, bytes32 _tranche, uint256 _amount, bytes _data) external view returns (byte, bytes32, bytes32){
  //     return ;
  // }



// MARKETPLACE  
  
  struct offer{
    uint256 price;
    uint256 amount;
    address seller;
  }

  offer[] private _offers;
  uint256 private _nbOffers;
  

  event toksecPurchase(address indexed purchaser, address indexed seller, uint256 price, uint256 amount );

  
  function offerInfo(uint256 index) public view returns(uint,address){
      return (_offers[index].price,_offers[index].seller);
  }
  
    function nbOffers() public view returns(uint){
      return _nbOffers;
  }

  function listOffer(uint256 price, uint256 amount) public{
    require(balanceOf(msg.sender)>=amount);
    // TODO allowance
    offer memory newOffer;
    newOffer.price = price;
    newOffer.amount = amount;
    newOffer.seller = msg.sender;
    _offers.push(newOffer);
  }

  function buyOffer(uint256 offerNumber,uint256 amountPurchased) public payable{
    //!!Using offerNumber as reference may cause errors if > 1 purchase per block
    require(msg.value>=_offers[offerNumber].price.mul(amountPurchased));
    //currently expect to buy the full offer, partial could be done
    require(amountPurchased == _offers[offerNumber].amount );
    //require(_offers[offerNumber].amount<=amountPurchased);
    transferFrom(msg.sender, _offers[offerNumber].seller, _offers[offerNumber].amount);

    emit toksecPurchase(msg.sender, _offers[offerNumber].seller, _offers[offerNumber].price, _offers[offerNumber].amount );
    if (offerNumber < _nbOffers.sub(1)) {
      _offers[offerNumber] = _offers[_nbOffers-1];
    }
    _nbOffers.sub(1);
  }

}
