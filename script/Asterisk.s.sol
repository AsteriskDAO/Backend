// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.23;

import {Script, console} from "forge-std/Script.sol";
import {Asterisk} from "../src/Asterisk.sol";

contract AsteriskScript is Script {
  function setUp() public {}

  function run() public {
    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
    vm.startBroadcast(deployerPrivateKey);

    // Semaphore v4 beta 16 deployed address on Sepolia
    new Asterisk(0x42C0e6780B60E18E44B3AB031B216B6360009baB);

    vm.stopBroadcast();
  }
}
