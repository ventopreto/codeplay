require 'rails_helper'

describe Course do
  it { should have_many(:users).through(:orders) }
  it { should have_many(:students).through(:orders) }
end