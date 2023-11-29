# frozen_string_literal: true

describe Event do
  describe 'validates' do
    context 'when start_time is the is not in the future' do
      it 'is not valid' do
        event = build(:event, start_time: Time.zone.now - 1)
        expect(event).not_to be_valid
        expect(event.errors[:start_time]).to include('must be after today')
      end
    end

    context 'when end_time is before start_time' do
      it 'is not valid' do
        event = build(:event, start_time: Time.zone.now + 2, end_time: Time.zone.now + 1)
        expect(event).not_to be_valid
        expect(event.errors[:end_time]).to include('must be after start time')
      end
    end
  end

  describe 'when county_names_by_id is called' do
    let(:state) do
      create(:state)
    end
    let(:counties) do
      create_list(:county, 5, state: state)
    end
    let(:event) do
      create(:event, county: counties[0])
    end

    context 'when county does not exist' do
      let(:event) do
        build(:event, county: nil)
      end

      it 'return an list' do
        expect(event.county_names_by_id).to be_empty
      end
    end

    it 'returns a county => id hash' do
      hash = counties.map { |c| [c.name, c.id] }.to_h
      expect(event.county_names_by_id).to eq(hash)
    end
  end
end
