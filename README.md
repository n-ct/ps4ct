This is going to change. We are working on our feature branch.

This sentence is part of commit #2 to our `testing-branches` branch.

# Provable Security For Certificate Transparency #

This repository runs a full Certificate Transparency Personality.

This repo uses submodules, and should be cloned as `git clone --recurse-submodules URL`

## Checklist ##
[X] Trillian gRPC API\
[X] CT <-> Trillian using default config\
[~] Custom CT Configuration, Keys\
[X] "One-click" Deployement

## Dev/Gossip Instructions ##
1. `gossip_master` is our new destination branch. Anything on this branch is tested and working.
    Branch off of `gossip_master` whenever you start working on a new feature, or `git merge gossip_master`
2. Write New Features locally, then `go build` locally to test for static errors
3. Run `dc run gosmin bash`, test in the gossip environment
4. Create a PR and add the entire dev team as a review
5. Dev Team should merge into `gossip_master`

## Deploy Instructions ##

*Note*: `alias dc=docker-compose`

0. (If needed) `dc down -v --rmi all && yes | d system prune && yes | d volume prune`
1. Build docker images `dc build`
2. Start Log Server and CT server `dc up tlserver ctserver` (mysql and tlsigner are automatically setup in the background)
3. Open a shell to the monitor `dc run monitor bash`, and check `curl ctserver:6965/athos/ct/v1/get-sth`. a JSON object should be returned

### Troublshooting ###
1. wipe the docker-slate clean ("factory reset")
```
dc down -v --rmi all && yes | d system prune && yes | d volume prune
```


