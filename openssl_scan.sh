#!/bin/bash

# Save the positional arguments in human-readable variables
endpoint=$1
port=$2

# For each of these protocols...
for v in ssl2 ssl3 tls1 tls1_1 tls1_2; do
    # For each of the ciphers listed in the installed openssl package...
    for c in $(openssl ciphers 'ALL:eNULL' | tr ':' ' '); do
        # Test if the endpoint accepts the protocol and cipher
        openssl s_client -connect $endpoint:$port \
            -cipher $c -$v < /dev/null > /dev/null 2>&1 && \
            # If successful, echo the output
            echo -e "$v:\t$c"
    done
done
