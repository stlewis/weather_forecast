# frozen_string_literal: true

Rails.application.routes.draw do
  resources :weather_reports, only: %i[new] do
    get 'by_address', on: :collection
  end

  root 'weather_reports#new'
end
