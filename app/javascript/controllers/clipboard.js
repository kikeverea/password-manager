import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

    static values = {
        content: String
    }

    copy() {
        console.log('Called')
        navigator.clipboard.writeText(this.contentValue);
    }
}
