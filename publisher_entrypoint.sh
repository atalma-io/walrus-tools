#!/bin/bash

if [ ! -f /opt/walrus/config/publisher/sui_client.yaml ]; then
    
    echo "No wallet found, generating new one..."
    /opt/walrus/bin/walrus generate-sui-wallet --path /opt/walrus/config/publisher/sui_client.yaml
    echo "=== Wallet generation completed ==="
    echo "=== Wallet contents ==="
    cat /opt/walrus/config/publisher/sui_client.yaml
   
    echo 'wallet_config: /opt/walrus/config/publisher/sui_client.yaml' >> /opt/walrus/config/client_config.yaml
    echo "=== Wallet config added to client config ==="
    cat /opt/walrus/config/client_config.yaml    

    echo "=== Getting WAL tokens ==="
    /opt/walrus/bin/walrus get-wal --config /opt/walrus/config/client_config.yaml
    echo "=== WAL tokens fetched ==="
else
    echo "=== Existing wallet found ==="
    cat /opt/walrus/config/publisher/sui_client.yaml

    echo "=== Full config is ==="
    cat /opt/walrus/config/client_config.yaml

    echo "=== Getting WAL tokens ==="
    /opt/walrus/bin/walrus get-wal --config /opt/walrus/config/client_config.yaml
    echo "=== WAL tokens fetched ==="

    echo "=== Starting publisher ==="
fi

# Execute the main command
exec "$@" 
