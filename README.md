![](https://img.shields.io/badge/Microverse-blueviolet)

# Blog app

> Work in progress Ruby on Rails Blog application

## Prerequisites

Ruby >= 3.0.0

Rails >= 7.0.0

Postgresql >= 12.0

## Tests

To run the tests you must first have run bundle install
Then in the repository's main directory run bundle exec rspec spec


<details>
<summary>Quick guide how to test the API</summary>
Sign-up:

```
curl -XPOST -H "Content-Type: application/json" -d '{ "user": { "name": "John", "photo": "https://i.pravatar.cc/200?img=3", "bio": "some bio", "posts_counter": "0", "email": "test@example.com", "password": "12345678" } }' http://localhost:3000/users
```
Click the link in the terminal to confirm the registration, and then sign in:

```
curl -XPOST -i -H "Content-Type: application/json" -d '{ "user": { "email": "test@example.com", "password": "12345678" } }' http://localhost:3000/users/sign_in
```
Replace the Authorization: Bearer `token` with {{{your token}}} for the next steps below:
Create a new post:

```
curl -XPOST -H "Authorization: Bearer {{{your_token}}}" -H "Content-Type: application/json" -d '{ "post": { "title": "New Post", "text": "This a post created from the API", "comments_counter": "0", "likes_counter": "0"} }' http://localhost:3000/api/posts
```
Get all the posts:

```
curl -XGET -H "Authorization: Bearer  {{{your_token}}}" -H "Content-Type: application/json" http://localhost:3000/api/posts
```
Add a comment:

```
curl -XPOST -H "Authorization: Bearer {{{your_token}}}" -H "Content-Type: application/json" -d '{ "comment": { "text": "new comment from API"} }' http://localhost:3000/api/posts/1/comments
```
Get all comments:

```
curl -XGET -H "Authorization: Bearer {{{your_token}}}" -H "Content-Type: application/json" http://localhost:3000/api/posts/1/comments
```
</details>

## Getting Started

- Run git clone on this project at the desired directory:
   ```
   git clone https://github.com/iammouaz/blog-app.git
   ```
- Go to the cloned directory with `cd blog-app`
- Run `bundle install` to install the necessary packages
- Run `sudo apt install postgresql postgresql-contrib` to install the necessary database system
- Make sure to run the postgresql service with `sudo service postgresql start`
- Run `rails db:create` to create the database locally or if already have one run `rails db:reset` instead
- After installing everything, you can run now the website with `rails s`

## Author

👤 **Mouaz Ek Molkey**

- GitHub: [![@lfmnovaes](https://img.shields.io/github/followers/iammouaz?color=lightgray&style=plastic&labelColor=blue)](https://github.com/)
- Twitter: [![@lfmnovaes](https://img.shields.io/twitter/follow/iammouaz?style=plastic&labelColor=blue)](https://www.twitter.com//)
- LinkedIn: [![@lfmnovaes](https://img.shields.io/badge/LinkedIn-blue?style=plastic&logo=linkedin)](https://www.linkedin.com/in//)

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](../../issues/).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- Microverse

## 📝 License

This project is [MIT](./LICENSE) licensed.