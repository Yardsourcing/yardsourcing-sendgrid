# Yardsourcing Sendgrid API Microservice

### Created by:
- [Angel Breaux](https://github.com/abreaux26)    [LinkedIn](https://www.linkedin.com/in/angel-breaux)
- [Doug Welchons](https://github.com/DougWelchons/)   [LinkedIn](https://www.linkedin.com/in/douglas-welchons)
- [Dominic Padula]() [LinkedIn]()
- [Jordan Beck](https://github.com/jordanfbeck0528)   [LinkedIn](https://www.linkedin.com/in/jordan-f-beck/)
- [Alexa Morales Smyth](https://github.com/amsmyth1)  [LinkedIn](https://www.linkedin.com/in/moralesalexa/)
- [Jenny Branham](https://github.com/jbranham1)     [LinkedIn](https://www.linkedin.com/in/jenny-branham)
- [Genevieve Nuebel](https://github.com/Gvieve)     [LinkedIn](https://www.linkedin.com/in/genevieve-nuebel)


The Yardsourcing SendGrid API Microservice is a lightweight API modular service that consumes SendGrid's email API. It can be hooked into your existing application to send email communications to your users.

#### Built With
* [Sinatra](http://sinatrarb.com/)
* [Ruby](https://www.ruby-lang.org/en/)

This project was tested with:
* RSpec version 3.10

## Contents
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installing](#installing)
- [Endpoints](#endpoints)
  - [Mail](#mail)
- [Testing](#testing)
- [How to Contribute](#how-to-contribute)
- [Roadmap](#roadmap)
- [Contributors](#contributors)
- [Acknowledgments](#acknowledgments)

### Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

#### Prerequisites

* __Ruby__

  - The project is built with ruby using __ruby version 2.5.3p105__, you must install ruby on your local machine first. Please visit the [ruby](https://www.ruby-lang.org/en/documentation/installation/) home page to get set up. _Please ensure you install the version of ruby noted above._

#### Installing

1. Clone the repo
  ```
  $ git clone https://github.com/Yardsourcing/yardsourcing-sendgrid
  ```

2. Bundle Install
  ```
  $ bundle install
  ```

4. Start sinatra ruby server
  ```
  $ bundle exec ruby applicationcontroller.rb
  ```

### Endpoints
##### Mail
- POST request to send email
  - __required params__:
    - to=<recipient_email>
    - from=<sender_email>
    - subject=<email_subject>
    - content=<email_body>
  - examples:
    - post `http://localhost:4567/mail?to=email@gmail.com&from=myemail@hotmail.com&subject=BDAY BASH&content=You are Invited!`

### Testing
##### Running Tests
- To run the full test suite run the below in your terminal:
```
$ bundle exec rspec
```

### How to Contribute

In the spirit of collaboration, things done together are better than done on our own. If you have any amazing ideas or contributions on how we can improve this API they are **greatly appreciated**. To contribute:

  1. Fork the Project
  2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
  3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
  4. Push to the Branch (`git push origin feature/AmazingFeature`)
  5. Open a Pull Request

### Roadmap

See the [open issues](https://github.com/Gvieve/rails-engine) for a list of proposed features (and known issues). Please open an issue ticket if you see an existing error or bug.

### Contributors
- [Angel Breaux](https://github.com/abreaux26)
- [Doug Welchons](https://github.com/DougWelchons/)
- [Dominic Padula]() [LinkedIn]()
- [Jordan Beck](https://github.com/jordanfbeck0528)
- [Alexa Morales Smyth](https://github.com/amsmyth1)
- [Jenny Branham](https://github.com/jbranham1)
- [Genevieve Nuebel](https://github.com/Gvieve)

  See also the list of
  [contributors](https://github.com/Yardsourcing/yardsourcing-sendgrid/graphs/contributors)
  who participated in this project.

### Acknowledgments
  - Our fantastically wizard like Project Manager and Instructor at [Turing School of Software and Design](https://turing.io/):
    * Ian Douglas
