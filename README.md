[![Build Status](https://travis-ci.org/summera/hubot-github-create-pullrequests.svg?branch=master)](https://travis-ci.org/summera/hubot-github-create-pullrequests)

# Hubot Create Pull Requests

## Installation

In hubot project repo, run:

```
npm install hubot-github-create-pullrequests
```

Then add **hubot-github-createpullrequests** to your `external-scripts.json`:

```javascript
["hubot-github-create-pullrequests"]
```

## Configuration
This package uses the HUBOT_GITHUB_TOKEN environment variable to authenticate with github. This is explained more in [githubot](https://github.com/iangreenleaf/githubot).

### Acquire a token
If you don't have a token yet, run this:

```
curl -i https://api.github.com/authorizations -d '{"note":"githubot","scopes":["repo"]}' -u "yourusername"
```

Enter your Github password when prompted. When you get a response, look for the "token" value.

## Hubot Commands
```
hubot create pr from <user>/<repo>/<branch> [into <base>] ["<body>"]
```

- user (required): The github user or org that owns the repo.
- repo (required): Repository where your branch exists.
- branch (required): Name of branch.
- base (optional): Name of branch you would like to request to merge into. `Master` by default.
- body (optional): Message to create with pull request. Empty by default.
