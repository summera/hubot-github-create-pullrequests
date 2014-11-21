chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'create-pullrequests', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()
      hear: sinon.spy()

    require('../src/github-create-pullrequests')(@robot)

  it 'registers a respond listener', ->
    expect(@robot.respond).to.have.been.calledWith(/create pr from ([-_\.0-9a-zA-Z]+)\/([-_\.a-zA-z0-9\/]+)\/([-_\.a-zA-z0-9\/]+)(?: into ([-_\.a-zA-z0-9\/]+))?(?: "(.*)")?$/i)
