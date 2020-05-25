# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#index"
  resources :images
  # get "tags/:tag_name", to: "images#filter_tag", as: "tag_path"
  resources :tags, only: [:show]
  get "images/:id/share", to: "images#new_share", as: "share_path"
  post "images/:id/share", to: "images#create_share"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
