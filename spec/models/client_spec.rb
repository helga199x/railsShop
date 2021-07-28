require 'rails_helper'

RSpec.describe Client, type: :model do

  describe '#validates' do
    context 'when fields not nil' do

      let(:client) { Client.new(name: 'Jojo', phone: '7654040', adress: 'Pompo Street 4') }

      it "shouldn't equal nil" do
        expect(client.name).to be_truthy
        expect(client.phone).to be_truthy
        expect(client.adress).to be_truthy
        expect(client.valid?).to eq true
      end
    end
  end
end
