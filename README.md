# Mia — Your Personal Wellbeing Assistant

MiaAI is a Ruby on Rails 7 web application that allows users to chat with an AI-powered wellbeing assistant.
It’s designed to help users reflect, learn, and grow through supportive and personalized conversations.

## Features

* Real-time AI chat — communicate with Mia, your wellbeing companion

* User authentication (Devise) — sign up, log in, or chat as a guest

* Persistent chat history — signed-in users can view and revisit their past conversations

* Chat sidebar — shows all previous chats with the option to delete any

* Guest mode — guests can send up to 10 messages in a single chat

* Modern UI — fully responsive design built with Tailwind CSS

* Hotwire + Turbo — smooth, real-time updates without page reloads

## Tech Stack

* Backend: Ruby on Rails 7

* Frontend: Tailwind CSS + Hotwire (Turbo + Stimulus)

* Auth: Devise

* Database: PostgreSQL

* Language: Ruby 3.2+

## Setup Instructions
1️⃣ Clone the repository
```bash
git clone https://github.com/mikolajczu/mia.git
cd mia
```

2️⃣ Install dependencies
```bash
bundle install
yarn install
```

3️⃣ Set up the database
```bash
rails db:create db:migrate
```

4️⃣ Start the development server
```bash
bin/dev
```

Now visit http://localhost:3000

## Project Structure

```
app/
 ├── controllers/
 │    ├── chats_controller.rb     # Handles chat creation and display
 │    └── messages_controller.rb  # Handles message sending
 ├── models/
 │    ├── chat.rb
 │    ├── message.rb
 │    └── user.rb
 ├── views/
 │    ├── chats/
 │    │    ├── _sidebar.html.erb  # Sidebar with chat history
 │    │    └── show.html.erb      # Chat view with message input
 │    └── devise/                 # Devise authentication views
 ├── javascript/controllers/
 │    └── chat_controller.js      # Stimulus controller for sending messages
 │    └── animation_controller.js # Stimulus controller for animations
 └── assets/stylesheets/
      └── chat.css                # Chat layout and animations
```

## How It Works

* When a guest opens the chat, a session token is generated and tied to their chat.
Guests can send up to 10 messages before being prompted to sign up.

* When a logged-in user opens the chat, a new chat record is created and saved to their account.
They can revisit past chats from the sidebar, or delete them.

* Messages are stored in the database with sender type (user / mia).
The AI response currently uses a placeholder, but can be connected to the OpenAI API.

## Running Tests

The project uses RSpec for unit testing:

```bash
bundle exec rspec
```

## 📜 License

MIT License © 2025 Mikolaj Czurlowski