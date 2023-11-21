require 'rails_helper'

describe Representative do
  describe 'when a representative already exists in the database' do
    let(:existing_rep) { 
      Representative.create!(name: 'Rohan Taneja', ocdid: 'ocd-id', title: 'President') 
    }

    let(:rep_info) do
      OpenStruct.new(
        officials: [OpenStruct.new(name: 'Rohan Taneja')],
        offices: [OpenStruct.new(name: 'President', division_id: 'ocd-id', official_indices: [0])]
      )
    end

    it 'does not create a duplicate one' do
      existing_rep
      expect { Representative.civic_api_to_representative_params(rep_info) }.not_to change(Representative, :count)
    end
  end
end
