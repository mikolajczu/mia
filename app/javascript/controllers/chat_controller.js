import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "messages"]

  connect() {
    this.messagesTarget.scrollTo({
      top: this.messagesTarget.scrollHeight,
      behavior: "smooth"
    })
  }

  async sendMessage(e) {
    e.preventDefault()

    const content = this.inputTarget.value.trim()
    if (!content || this.isLocked) return

    this.addMessage(content)
    this.inputTarget.value = ""

    this.lockInput()

    const typingIndicator = this.addTypingIndicator()

    const token = document.querySelector('meta[name="csrf-token"]').content;
    const response = await fetch("/chat", {
      method: "POST",
      headers: { "Content-Type": "application/json", "Accept": "application/json", "X-CSRF-Token": token },
      body: JSON.stringify({ message: content })
    })

    const data = await response.json()

    typingIndicator.remove()

    await this.typeMessage(data.reply)
    this.unlockInput()
  }

  addMessage(text) {
    const div = document.createElement("div")
    div.classList.add("message", "user")

    const avatar = `<img src="/assets/user.png" alt="You" class="avatar">`

    div.innerHTML = `
      ${avatar}
      <div class="bubble">
        ${text}
      </div>
    `
    this.messagesTarget.appendChild(div)
    this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight
  }

  addTypingIndicator() {
    const indicator = document.createElement("div")
    indicator.classList.add("mia-typing", "message", "mia")

    const avatar = `<img src="/assets/mia.png" alt="Mia" class="avatar">`

    indicator.innerHTML = `
      ${avatar}
      <div class="bubble">
        <span class="dots">
          <span class="dot dot1"></span>
          <span class="dot dot2"></span>
          <span class="dot dot3"></span>
        </span>
      </div>
    `
    this.messagesTarget.appendChild(indicator)
    this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight
    return indicator
  }

  async typeMessage(text) {
    const div = document.createElement("div")
    div.classList.add("message", "mia")

    const avatar = `<img src="/assets/mia.png" alt="Mia" class="avatar">`

    div.innerHTML = `${avatar}<div class="bubble"><span class="typing-text"></span></div>`
    this.messagesTarget.appendChild(div)

    const span = div.querySelector(".typing-text")
    for (let i = 0; i < text.length; i++) {
      span.textContent += text[i]
      await new Promise(resolve => setTimeout(resolve, 30))
      this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight
    }
  }

  lockInput() {
    this.isLocked = true
    this.inputTarget.disabled = true
  }

  unlockInput() {
    this.isLocked = false
    this.inputTarget.disabled = false
    this.inputTarget.focus()
  }
}
