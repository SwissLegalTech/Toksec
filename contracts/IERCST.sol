pragma solidity ^0.4.24;

/*  @title IERCST Security Token Standard (EIP 1400)
    !! At early stage as of 2018.09.17 and additional adaptations
    @dev See https://github.com/ethereum/EIPs/issues/1411
*/

interface IERCST {

  function getDocument(bytes32 _name) external view returns (string, bytes32);
  function setDocument(bytes32 _name, string _uri, bytes32 _documentHash) external;
  function issuable() external view returns (bool);
  function canSend(address _from, address _to, bytes32 _tranche, uint256 _amount, bytes _data) external view returns (byte, bytes32, bytes32);

}
