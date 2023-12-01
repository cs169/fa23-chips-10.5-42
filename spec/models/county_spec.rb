# frozen_string_literal: true

require 'rails_helper'

describe County do
  describe '.std_fips_code' do
    let(:county) do
      create(:county, fips_code: fips_code)
    end

    context 'when fips_code is a single digit' do
      let(:fips_code) { 1 }

      it 'returns a zero-padded string' do
        expect(county.std_fips_code).to eq('001')
      end
    end

    context 'when fips_code is three digits' do
      let(:fips_code) { 111 }

      it 'returns the fips_code as a string' do
        expect(county.std_fips_code).to eq('111')
      end
    end
  end
end
