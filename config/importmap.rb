# Pin npm packages by running ./bin/importmap

pin 'application', preload: true
pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true
pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
pin 'stimulus-autocomplete', to: 'stimulus-autocomplete.js', preload: true
pin 'stimulus-autocomplete', to: 'https://cdn.jsdelivr.net/npm/stimulus-autocomplete@3.0.2/src/autocomplete.min.js'
pin_all_from 'app/javascript/controllers', under: 'controllers'
pin 'slim-select', to: 'https://ga.jspm.io/npm:slim-select@2.3.0/dist/slimselect.umd.js'
pin 'stimulus-autocomplete', to: 'https://ga.jspm.io/npm:stimulus-autocomplete@3.0.2/src/autocomplete.js'
pin '@hotwired/stimulus', to: 'https://ga.jspm.io/npm:@hotwired/stimulus@3.2.1/dist/stimulus.js'
pin 'datepicker.js', to: 'https://ga.jspm.io/npm:datepicker.js@0.0.1-beta1/datepicker.js'
pin 'stimulus-datepicker', to: 'https://ga.jspm.io/npm:stimulus-datepicker@1.0.1/src/datepicker.js'
pin '@fortawesome/fontawesome-free', to: 'https://ga.jspm.io/npm:@fortawesome/fontawesome-free@6.1.1/js/all.js'
pin 'stimulus-rails-nested-form', to: 'https://ga.jspm.io/npm:stimulus-rails-nested-form@4.1.0/dist/stimulus-rails-nested-form.mjs'
pin "tailwindcss-stimulus-components", to: "https://ga.jspm.io/npm:tailwindcss-stimulus-components@3.0.4/dist/tailwindcss-stimulus-components.modern.js"
