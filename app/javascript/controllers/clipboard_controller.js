import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

    static values = {
        content: String
    }

    connect() {
        this.originalContent = this.element.children[0]
    }

    async copy() {
        await navigator.clipboard.writeText(this.contentValue)

        this.element.textContent = "COPIED!"

        setTimeout(() => {
            this.element.textContent = null
            this.element.appendChild(this.originalContent)
        }, 1500)
    }
}
