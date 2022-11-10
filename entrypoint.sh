#!/bin/sh

# case "$_DAPPNODE_GLOBAL_CONSENSUS_CLIENT_LUKSO in
# "prysm-lukso.dnp.dappnode.eth")
#   echo "Using prysm-lukso.dnp.dappnode.eth"
#   JWT_PATH="/security/prysm/jwtsecret.hex"
#   ;;
# "lighthouse-lukso.dnp.dappnode.eth")
#   echo "Using lighthouse-lukso.dnp.dappnode.eth"
#   JWT_PATH="/security/lighthouse/jwtsecret.hex"
#   ;;
# "teku-lukso.dnp.dappnode.eth")
#   echo "Using teku-lukso.dnp.dappnode.eth"
#   JWT_PATH="/security/teku/jwtsecret.hex"
#   ;;
# "nimbus-lukso.dnp.dappnode.eth")
#   echo "Using nimbus-lukso.dnp.dappnode.eth"
#   JWT_PATH="/security/nimbus/jwtsecret.hex"
#   ;;
# *)
#   echo "Using default"
#   JWT_PATH="/security/default/jwtsecret.hex"
#   ;;
# esac

# Print the jwt to the dappmanager
JWT=$(cat $JWT_PATH)
curl -X POST "http://my.dappnode/data-send?key=jwt&data=${JWT}"

exec geth --config "/config/configuration.toml"
#  $EXTRA_OPTION

  #   --http --http.addr 0.0.0.0 \
  # --http.corsdomain "*" \
  # --http.vhosts "*" \
  # --ws \
  # --ws.origins "*" \
  # --ws.addr 0.0.0.0 \
  # --syncmode ${SYNCMODE:-snap} \
  # --port ${P2P_PORT} \
  # --metrics \
  # --metrics.addr 0.0.0.0 \
  # --authrpc.addr 0.0.0.0 \
  # --authrpc.port 8551 \
  # --authrpc.vhosts "*" \
  # --authrpc.jwtsecret "/security/default/jwtsecret.hex" \