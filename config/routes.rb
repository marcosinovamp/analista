Rails.application.routes.draw do
  get 'intext', to: 'page#intext'
  get 'analysis', to: 'page#analysis'
  get 'sinon', to: 'page#sinon'
  get 'dicio', to: 'page#dicio'
end
