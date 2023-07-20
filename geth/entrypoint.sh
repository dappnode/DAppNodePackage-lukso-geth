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

echo "[INFO - entrypoint] Posting JWT to dappmanager: ${JWT_PATH}"
JWT=$(cat $JWT_PATH)
curl -X POST "http://my.dappnode/data-send?key=jwt&data=${JWT}"

echo "[INFO - entrypoint] Initializing Geth from genesis"
geth --datadir=/lukso init /config/genesis.json

echo "[INFO - entrypoint] Starting Geth"
exec geth --datadir /lukso \
  --config /config/geth.toml \
  --port ${P2P_PORT} \
  --http \
  --http.api eth,engine,net,web3,txpool \
  --http.addr 0.0.0.0 \
  --http.corsdomain "*" \
  --http.vhosts "*" \
  --ws \
  --ws.api eth,engine,net,web3,txpool \
  --ws.addr 0.0.0.0 \
  --ws.port 8546 \
  --ws.origins "*" \
  --authrpc.addr 0.0.0.0 \
  --authrpc.port 8551 \
  --authrpc.vhosts "*" \
  --authrpc.jwtsecret ${JWT_PATH} \
  --syncmode ${SYNC_MODE:-snap} \
  --metrics \
  --metrics.addr 0.0.0.0 \
  ${EXTRA_FLAGS}
