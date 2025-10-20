import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "list", "fields"]

  addOperator() {
    const name = this.inputTarget.value.trim()
    if (name === "") return

    // Create visible tag
    const tag = document.createElement("span")
    tag.className = "inline-flex items-center bg-green-100 text-green-700 px-3 py-1 rounded-full text-sm"
    tag.textContent = name
    this.listTarget.appendChild(tag)

    // Create hidden field
    const field = document.createElement("input")
    field.type = "hidden"
    field.name = "task[operators_attributes][][name]"
    field.value = name
    this.fieldsTarget.appendChild(field)

    this.inputTarget.value = ""
  }
}
