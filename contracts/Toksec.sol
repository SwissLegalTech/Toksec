pragma solidity ^0.4.24;

// import "github.com/OpenZeppelin/zeppelin-solidity/contracts/math/SafeMath.sol";
import 'openzeppelin-solidity/contracts/math/SafeMath.sol';


contract Toksec {
  using SafeMath for uint256;
  
  struct timeshare {
      uint256 time;
      uint256 amount;
  }
  
  mapping (address => timeshare[]) private _timeshares;
  
  mapping (address => mapping (address => uint256)) private _allowed;
  uint256 private _totalSupply;

  string private _identifier;
  string private _company;
  
  event Transfer(address indexed from, address indexed to, uint256 value, timeshare[] liquidated );

  event Approval(address indexed owner, address indexed spender, uint256 value );

  constructor(string company, uint256 nbShares) public {
     // _identifier = identifier; 
      _company = company;
      timeshare memory initialIssuance;
      initialIssuance.amount = nbShares;
      //!! 0 is chosen as irrelevant date
      initialIssuance.time = 0;
      _timeshares[msg.sender].push(initialIssuance);
      _totalSupply = nbShares;
  }
  
  function totalSupply() public view returns (uint256) {
    return _totalSupply;
  }

  function company() public view returns (string) {
    return _company;
  }

  function balanceOf(address owner) public view returns (uint256) {

    uint256 blc = 0;
    for (uint256 i=0; i<_timeshares[owner].length; i++) {
      blc.add(_timeshares[owner][i].amount);
    }
    return blc;
  }

/*  function allowance(address owner, address spender) public view returns (uint256){
    return _allowed[owner][spender];
  }*/
    
  // transfer the number of token specified from the pile, latest acquired first. An option could specify otherwise
  function transfer(address to, uint256 value) public returns (bool) {
    require(value <= balanceOf(msg.sender));
    
    uint256 remaining = value;
    timeshare[] memory liquidated;
    uint256 timesharesLength = _timeshares[msg.sender].length;
    
    for (uint256 i=timesharesLength; i>=0; i--) {
      if(_timeshares[msg.sender][i].amount>remaining){
         liquidated[timesharesLength.sub(i)].amount= _timeshares[msg.sender][i].amount.sub(remaining);
         liquidated[timesharesLength.sub(i)].time= _timeshares[msg.sender][i].time;
         _timeshares[msg.sender][i].amount= _timeshares[msg.sender][i].amount.sub(remaining);
         remaining=0; 
      } else {
          liquidated[timesharesLength.sub(i)].amount= _timeshares[msg.sender][i].amount.sub(remaining);
         liquidated[timesharesLength.sub(i)].time= _timeshares[msg.sender][i].time;
         _timeshares[msg.sender][i].amount= _timeshares[msg.sender][i].amount.sub(remaining);
         remaining=0; 
      }
    }

    // Finalize by adding this position to the timeshare of the receiver
    timeshare memory newPosition;
    newPosition.amount = value;
    newPosition.time = now-7; 
     _timeshares[to].push(newPosition);
    emit Transfer(msg.sender, to, value, liquidated);
    return true;
  }

/*  function approve(address spender, uint256 value) public returns (bool) {
    require(spender != address(0));

    _allowed[msg.sender][spender] = value;
    emit Approval(msg.sender, spender, value);
    return true;
  }
*/

/*  function transferFrom(address from, address to, uint256 value) public returns (bool){
    require(value <= _balances[from]);
    require(value <= _allowed[from][msg.sender]);
    require(to != address(0));

    _balances[from] = _balances[from].sub(value);
    _balances[to] = _balances[to].add(value);
    _allowed[from][msg.sender] = _allowed[from][msg.sender].sub(value);
    emit Transfer(from, to, value);
    return true;
  }
*/
  // /**
  //  * @dev Increase the amount of tokens that an owner allowed to a spender.
  //  * approve should be called when allowed_[_spender] == 0. To increment
  //  * allowed value is better to use this function to avoid 2 calls (and wait until
  //  * the first transaction is mined)
  //  * From MonolithDAO Token.sol
  //  * @param spender The address which will spend the funds.
  //  * @param addedValue The amount of tokens to increase the allowance by.
  //  */
  // function increaseAllowance(
  //   address spender,
  //   uint256 addedValue
  // )
  //   public
  //   returns (bool)
  // {
  //   require(spender != address(0));

  //   _allowed[msg.sender][spender] = (
  //     _allowed[msg.sender][spender].add(addedValue));
  //   emit Approval(msg.sender, spender, _allowed[msg.sender][spender]);
  //   return true;
  // }

  // /**
  //  * @dev Decrease the amount of tokens that an owner allowed to a spender.
  //  * approve should be called when allowed_[_spender] == 0. To decrement
  //  * allowed value is better to use this function to avoid 2 calls (and wait until
  //  * the first transaction is mined)
  //  * From MonolithDAO Token.sol
  //  * @param spender The address which will spend the funds.
  //  * @param subtractedValue The amount of tokens to decrease the allowance by.
  //  */
  // function decreaseAllowance(
  //   address spender,
  //   uint256 subtractedValue
  // )
  //   public
  //   returns (bool)
  // {
  //   require(spender != address(0));

  //   _allowed[msg.sender][spender] = (
  //     _allowed[msg.sender][spender].sub(subtractedValue));
  //   emit Approval(msg.sender, spender, _allowed[msg.sender][spender]);
  //   return true;
  // }

  // /**
  //  * @dev Internal function that mints an amount of the token and assigns it to
  //  * an account. This encapsulates the modification of balances such that the
  //  * proper events are emitted.
  //  * @param account The account that will receive the created tokens.
  //  * @param amount The amount that will be created.
  //  */
  // function _mint(address account, uint256 amount) internal {
  //   require(account != 0);
  //   _totalSupply = _totalSupply.add(amount);
  //   _balances[account] = _balances[account].add(amount);
  //   emit Transfer(address(0), account, amount);
  // }

  // /**
  //  * @dev Internal function that burns an amount of the token of a given
  //  * account.
  //  * @param account The account whose tokens will be burnt.
  //  * @param amount The amount that will be burnt.
  //  */
  // function _burn(address account, uint256 amount) internal {
  //   require(account != 0);
  //   require(amount <= _balances[account]);

  //   _totalSupply = _totalSupply.sub(amount);
  //   _balances[account] = _balances[account].sub(amount);
  //   emit Transfer(account, address(0), amount);
  // }

  // /**
  //  * @dev Internal function that burns an amount of the token of a given
  //  * account, deducting from the sender's allowance for said account. Uses the
  //  * internal burn function.
  //  * @param account The account whose tokens will be burnt.
  //  * @param amount The amount that will be burnt.
  //  */
  // function _burnFrom(address account, uint256 amount) internal {
  //   require(amount <= _allowed[account][msg.sender]);

  //   // Should https://github.com/OpenZeppelin/zeppelin-solidity/issues/707 be accepted,
  //   // this function needs to emit an event with the updated approval.
  //   _allowed[account][msg.sender] = _allowed[account][msg.sender].sub(
  //     amount);
  //   _burn(account, amount);
  // }

/*    function getDocument(bytes32 _name) external view returns (string, bytes32){
        return "kkk", "32";
    }
    function setDocument(bytes32 _name, string _uri, bytes32 _documentHash) external;
  issue
*/
  // function issuable() external view returns (bool){
  //     return true;
  // }
  // function canSend(address _from, address _to, bytes32 _tranche, uint256 _amount, bytes _data) external view returns (byte, bytes32, bytes32){
  //     return ;
  // }



}
