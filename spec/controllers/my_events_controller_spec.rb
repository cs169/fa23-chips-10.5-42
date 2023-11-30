# frozen_string_literal: true

require 'rails_helper'

describe MyEventsController do
  before do
    user = create(:user)
    log_in(user)
  end

  describe 'when edit, update, or destroy is called' do
    it 'assigns the correct event as @event' do
      event = create(:event)
      get :edit, params: { id: event.id }
      expect(assigns(:event)).to eq(event)
    end
  end

  describe  'when request new' do
    it 'assigns a new event to @event' do
      get :new
      expect(assigns(:event)).to be_a_new(Event)
    end

    it 'renders the new template' do 
      get :new
      expect(response).to render_template(:new)
    end
  end


  describe 'when create get called' do
    let(:county) { create(:county) }
    context 'with valid parameters' do
      it 'creates a new Event' do
        expect {
          post :create, params: { event: attributes_for(:event).merge(county_id: county.id) }
        }.to change(Event, :count).by(1)
      end

      it 'redirects to the events index page' do
        post :create, params: { event: attributes_for(:event).merge(county_id: county.id) }
        expect(response).to redirect_to(events_path)
      end
    end

    context 'with invalid parameters' do
      it 'does not create and add a new Event' do
        expect {
          post :create, params: { event: { start_time: Time.zone.now - 1 } }
        }.to_not change(Event, :count)
      end
      it 'rerenders the new view' do
        post :create, params: { event: { start_time: Time.zone.now - 1 } }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'when update is called' do
    let(:event) do
      create(:event)
    end
    context 'with valid changes' do
      it 'updates the event' do
        put :update, params: { id: event.id, event: { name: 'New Event Name' } }
        event.reload
        expect(event.name).to eq('New Event Name')
      end

      it 'redirects to events index page' do
        put :update, params: { id: event.id, event: { name: 'New Event Name' } }
        expect(response).to redirect_to(events_path)
      end
    end
    
    context 'with invalid parameter' do
      it 'does not make the change' do
        put :update, params: { id: event.id, event: { start_time: Time.zone.now - 1 } }
        start_time = event.start_time
        event.reload
        expect(event.start_time.to_i).to eq(start_time.to_i)
      end

      it 'rerenders edit view' do 
        put :update, params: { id: event.id, event: { start_time: Time.zone.now - 1 } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'when we try to DELETE an event' do
      
    it 'destroys the right event' do
      event = create(:event)
      expect {
        delete :destroy, params: { id: event.id }
      }.to change(Event, :count).by(-1)
    end
  end
end
