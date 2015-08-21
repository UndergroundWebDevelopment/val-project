require 'rails_helper'
require 'session/operations'

RSpec.describe Session::Signup do
  it do 
    _, op = Session::Signup.run(user: {
      email: "foobar@nothing.com",
      password: "123123",
      confirm_password: "123123",
    })

    expect(op.model.persisted?).to eq true
    expect(op.model.email).to eq "foobar@nothing.com"
    expect(Tyrant::Authenticatable.new(op.model).digest).to eq "123123"
  end
end
