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
    # Use jq to delete the corresponding item from the registry.json file
    cat registry.json | jq "del(.[] | select(.endpoint == \"$endpoint\"))" > new_registry.json
    mv new_registry.json registry.json

    # create a branch
    branch_name="delete-$RANDOM"
    git checkout -b "$branch_name" 
    # Add the updated registry.json file to the Git index
    git add registry.json

    # Commit the changes with a message
    message="Deleted endpoint $endpoint from registry.json"
    git commit -m "$message"

    # push the branch to the remote repository
    git push -u origin "$branch_name"

    title="$endpoint not reachable"
    body="Please check the endpoint **${endpoint}** it may not be reachable anymore.
    Status code: ${status_code}
    
    If you approve the pull request, the endpoint will be removed from the registry."
    
    # create a pull request
    gh pr create --base master --title "$title" --body "$body" 

    # checkout the master branch
    git checkout master
  fi
done
