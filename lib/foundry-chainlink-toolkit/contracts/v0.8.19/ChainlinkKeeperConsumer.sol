// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@chainlink/contracts/v0.8/AutomationCompatible.sol";

/**
 * THIS IS AN EXAMPLE CONTRACT THAT USES HARDCODED VALUES FOR CLARITY.
 * THIS IS AN EXAMPLE CONTRACT THAT USES UN-AUDITED CODE.
 * DO NOT USE THIS CODE IN PRODUCTION.
 */

contract ChainlinkKeeperConsumer is AutomationCompatibleInterface {
  /**
   * Public counter variable
   */
  uint public counter;

  /**
   * Use an interval in seconds and a timestamp to slow execution of Upkeep
   */
  uint public immutable interval;
  uint public lastTimeStamp;

  constructor() {
    interval = 100;
    lastTimeStamp = block.timestamp;

    counter = 0;
  }

  function checkUpkeep(bytes calldata /* checkData */) external view override returns (bool upkeepNeeded, bytes memory performData) {
    performData = new bytes(0);
    upkeepNeeded = (block.timestamp - lastTimeStamp) > interval;

    // We don't use the checkData in this example. The checkData is defined when the Upkeep was registered.
    return (upkeepNeeded, performData);
  }

  function performUpkeep(bytes calldata /* performData */) external override {
    //We highly recommend revalidating the upkeep in the performUpkeep function
    if ((block.timestamp - lastTimeStamp) > interval) {
      lastTimeStamp = block.timestamp;
      counter = counter + 1;
    }
    // We don't use the performData in this example. The performData is generated by the Automation Node's call to your checkUpkeep function
  }
}
