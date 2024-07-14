## Asterisk Backend

- [x] Contract creates a Semaphore group on construction.
- [ ] New users join the group using [Proof of Passport](https://www.proofofpassport.com/) to ensure that only women can join and only once for each person
- [x] Users can submit one report per day, passing the IPFS content ID of their encrypted report
- [x] Daily report submissions submitted through a relayer for better UX

## Usage

### Deploy

```shell
$ ETHERSCAN_API_KEY=xxxx PRIVATE_KEY=0x1234... forge script script/Asterisk.s.sol:AsteriskScript --rpc-url https://sepolia.drpc.org  --broadcast --verify -vvvvv
```

## License

MIT
