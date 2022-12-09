#!/usr/bin/env bash
# Parse the registry.json file and extract the list of server endpoints
endpoints=$(cat registry.json | jq -c -r '.[].endpoint')

# Loop through each endpoint
for endpoint in $endpoints; do
  # Check if the endpoint is a .onion address
  if [[ "$endpoint" =~ .*".onion".* ]]; then
    # Send the POST request through the Tor network
    status_code=$(curl -w "%{http_code}" -o /dev/null -s -X POST $endpoint/v1/markets \
              --socks5-hostname 'localhost:9150' \
              --header 'Content-Type: application/json' \
              --data-raw '{}')
  else
    # Send the POST request directly
    status_code=$(curl -w "%{http_code}" -o /dev/null -s -X POST $endpoint/v1/markets \
              --header 'Content-Type: application/json' \
              --data-raw '{}')
  fi

  # Extract the status code from the response
  echo "$endpoint is responding with status code $status_code"

  # Check the status code of the POST request
  if [ "$status_code" != "200" ]; then
    # body 
    title="Automated: $endpoint not reachable"
    body="Please check the endpoint **${endpoint}**\nStatus code: ${status_code}\n"
    gh issue create --title "$title" --body "$body"
  fi
done
