import { Application } from "@hotwired/stimulus"
import { Autocomplete } from 'stimulus-autocomplete'
import { Datepicker } from 'stimulus-datepicker'
import NestedForm from 'stimulus-rails-nested-form'

const application = Application.start()

application.register("autocomplete", Autocomplete, 'datepicker', Datepicker, 'nested-form', NestedForm)

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
