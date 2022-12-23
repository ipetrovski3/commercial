import { Application } from "@hotwired/stimulus"
import { Autocomplete } from 'stimulus-autocomplete'
import { Datepicker } from 'stimulus-datepicker'

const application = Application.start()


application.register("autocomplete", Autocomplete, 'datepicker', Datepicker)

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
