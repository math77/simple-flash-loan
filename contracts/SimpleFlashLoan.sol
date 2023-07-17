// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;


import "@aave/core-v3/contracts/flashloan/base/FlashLoanSimpleReceiverBase.sol";
import "@aave/core-v3/contracts/interfaces/IPoolAddressesProvider.sol";
import "@aave/core-v3/contracts/dependencies/openzeppelin/contracts/IERC20.sol";

//quicknode tutorial

//@author promatheus
contract SimpleFlashLoan is FlashLoanSimpleReceiverBase {

  address payable owner;

  receive() external payable {}

  constructor(address addressProvider) FlashLoanSimpleReceiverBase(IPoolAddressesProvider(addressProvider)) {}

  //WHY THIS FUNCTION WAS DECLARATED THIS WAY? fn...
  function fn_RequestFlashLoan(address token, uint256 amount) public {
    
    POOL.flashLoanSimple(
      address(this),
      token,
      amount,
      "",
      0
    );
  }

  function executeOperation(
    address asset,
    uint256 amount,
    uint256 premium,
    address initiator,
    bytes calldata params 
  ) external override returns (bool) {

    uint256 totalAmount = amount + premium;
    IERC20(asset).approve(address(POOL), totalAmount);

    return true;
  }
}
