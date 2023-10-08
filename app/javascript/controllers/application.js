import { Application } from "@hotwired/stimulus"
import { dashboard } from "../dashboard";

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

console.log("RUNNING THE OTHER APPLICATION.JS")