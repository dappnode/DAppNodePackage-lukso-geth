#!/bin/sh

case "$_DAPPNODE_GLOBAL_CONSENSUS_CLIENT_LUKSO" in
  "prysm-lukso.dnp.dappnode.eth")
    echo "Using prysm-lukso.dnp.dappnode.eth"
    JWT_PATH="/security/prysm/jwtsecret.hex"
    ;;
  "lighthouse-lukso.dnp.dappnode.eth")
    echo "Using lighthouse-lukso.dnp.dappnode.eth"
    JWT_PATH="/security/lighthouse/jwtsecret.hex"
    ;;
  "lodestar-lukso.dnp.dappnode.eth")
      echo "Using lodestar-lukso.dnp.dappnode.eth"
      JWT_PATH="/security/lodestar/jwtsecret.hex"
      ;;
  "teku-lukso.dnp.dappnode.eth")
      echo "Using teku-lukso.dnp.dappnode.eth"
      JWT_PATH="/security/teku/jwtsecret.hex"
      ;;
  "nimbus-lukso.dnp.dappnode.eth")
      echo "Using nimbus-lukso.dnp.dappnode.eth"
      JWT_PATH="/security/nimbus/jwtsecret.hex"
      ;;
  *)
    echo "Using default JWT"
    JWT_PATH="/security/default/jwtsecret.hex"
    ;;
esac

# Print the jwt to the dappmanager
JWT=$(cat $JWT_PATH)
curl -X POST "http://my.dappnode/data-send?key=jwt&data=${JWT}"

# Init Geth from genesis
exec geth --datadir=/lukso init /config/genesis.json

exec geth \
  --datadir=/lukso \
  --ws \
  --ws.api eth,engine,net,web3,txpool \
  --ws.addr 0.0.0.0 \
  --ws.origins "*" \
  --http \
  --http.api eth,engine,net,web3,txpool \
  --http.addr 0.0.0.0 \
  --http.corsdomain "*" \
  --http.vhosts "*" \
  --ipcdisable \
  --authrpc.addr 0.0.0.0 \
  --authrpc.port 8551 \
  --authrpc.vhosts "*" \
  --authrpc.jwtsecret ${JWT_PATH} \
  --metrics \
  --metrics.addr 0.0.0.0 \
  --port ${P2P_PORT} \
  ${EXTRA_FLAGS}
#  --bootnodes $EXECUTION_BOOTSTRAP_NODE_1 \
#  --networkid 42  \
#  --miner.gaslimit 42000000 \
#  --miner.gasprice 4200000000 \