const { readFileSync } = require("node:fs");
const { ethers } = require("ethers");

const provider = new ethers.JsonRpcProvider(`https://sepolia.drpc.org`);
const wallet = new ethers.Wallet(process.env.PRIVATE_KEY, provider);
const contractAbi = readFileSync('./abi.json', 'utf8');
const contract = new ethers.Contract(process.env.CONTRACT_ADDR, contractAbi, wallet)
// TODO rewards contract
// const rewardsAbi = readFileSync('./abi.json', 'utf8');
// const rewards = new ethers.Contract(process.env.REWARDS_ADDR, rewardsAbi, wallet)

export async function handler(event) {
  if('body' in event) {
    // Running on AWS
    event = JSON.parse(event.body);
  }
  try {
    await contract.submitReport(...event.calldata);
    // TODO When the proof submission succeeds then we can distribute reward tokens
//     await rewards.distributeReward(event.userAddress);
    return {
      statusCode: 200,
      body: JSON.stringify({
        status: 'ok',
      }),
    };
  } catch(error) {
    console.error(error);
    return {
      statusCode: 400,
      body: JSON.stringify({
        errorType: 'error',
        errorMessage: error.message
      }),
    };
  }
}

