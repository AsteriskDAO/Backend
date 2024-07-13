//SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import "./ISemaphore.sol";

contract Asterisk {
  ISemaphore public semaphore;
  uint256 public groupId;
  uint256 public deploymentTime;
  uint256[] public identityCommitments;

  constructor(address _semaphore) {
    semaphore = ISemaphore(_semaphore);
    groupId = semaphore.createGroup();
    deploymentTime = block.timestamp;
  }

  // Submitted via user's account
  function join(uint256 identityCommitment) external {
    // TODO proof of passport is not yet to a usable state
    semaphore.addMember(groupId, identityCommitment);
    // Backup source of group contents in case we don't have time to implement subgraph
    identityCommitments.push(identityCommitment);
  }

  // Submitted via relayer anonymously
  function submitReport(
    uint256 merkleTreeDepth,
    uint256 merkleTreeRoot,
    uint256 nullifier,
    uint256 reportCid,
    uint256[8] calldata points
  ) external {
    ISemaphore.SemaphoreProof memory proof = ISemaphore.SemaphoreProof(
        merkleTreeDepth,
        merkleTreeRoot,
        nullifier,
        reportCid, // message
        daysSinceDeployment(), // scope
        points
    );

    semaphore.validateProof(groupId, proof);
  }

  
  // Each user can submit a report once each day
  function daysSinceDeployment() public view returns (uint256) {
    uint256 timeDifference = block.timestamp - deploymentTime;
    return timeDifference / 60 / 60 / 24; // Convert seconds to days
  }

}
