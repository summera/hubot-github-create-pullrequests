# Description:
#   Create Github Pull Requests with Hubot.
#
# Dependencies:
#   "githubot": "^1.0.0-beta2"
#
# Configuration:
#   HUBOT_GITHUB_TOKEN (see https://github.com/iangreenleaf/githubot)
#
# Commands:
#   hubot create pr from <user>/<repo>/<branch> [into <base>] ["<body>"]
#
# Notes:
#   By default, the target branch will be master and the body empty.
#
#   You will need to create and set HUBOT_GITHUB_TOKEN.
#   The token will need to be made from a user that has access to repo(s)
#   you want hubot to interact with.
#
# Author:
#  summera

githubToken = process.env.HUBOT_GITHUB_TOKEN

module.exports = (robot) ->
  github = require('githubot')(robot)

  robot.respond /create pr from ([-_\.0-9a-zA-Z]+)\/([-_\.a-zA-z0-9\/]+)\/([-_\.a-zA-z0-9\/]+)(?: into ([-_\.a-zA-z0-9\/]+))?(?: "(.*)")?$/i, (msg) ->
    return if missingEnv()

    base = msg.match[4] || 'master'

    data = {
      title: "PR to merge #{msg.match[3]} into #{base}",
      head: msg.match[3],
      base: base,
      body: msg.match[5] || ''
    }

    github.handleErrors (response) ->
      switch response.statusCode
        when 404
          msg.send 'Error: Sorry mate, this is not a valid repo that I have
            access to.'
        when 422
          msg.send "Error: Yo mate, the pull request has already been created
            or the branch does not exist."
        else
          msg.send 'Error: Sorry mate, something is wrong with your request.'

    github.post "repos/#{msg.match[1]}/#{msg.match[2]}/pulls", data, (pr) ->
      msg.send "Success! Pull request created for #{msg.match[3]}.
        #{pr.html_url}"

  missingEnv = ->
    unless githubToken?
      msg.send 'HUBOT_GITHUB_TOKEN is missing. Please ensure that it is set.
        See https://github.com/summera/hubot-github-create-pullrequests for
        more details about generating one.'

    !githubToken?
