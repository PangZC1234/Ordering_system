# Ordering System

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Technologies Used](#technologies-used)
- [Installation](#installation)
- [Usage](#usage)

## Introduction

Ordering System is a web application that allows users to make orders, display ordered items, and includes an admin page to manage the database. It is built using Django for the backend and React for the frontend.

## Features

- User registration and authentication
- Order creation and management
- Admin panel for database management
- Docker support for easy deployment

## Technologies Used

- **Backend**: Django, Django REST Framework
- **Frontend**: React
- **Database**: MySQL
- **Containerization**: Docker, Docker Compose

## Installation

To get a local copy up and running, follow these steps.

### Prerequisites

- Docker and Docker Compose installed on your machine

### Steps

1. Clone the repository
    ```bash
    git clone https://github.com/PangZC1234/ordering_system.git
    git checkout JWT
    cd ordering_system
    ```
    
2. Build and start the Docker containers
    ```bash
    docker-compose up --build
    ```
    
## Usage

Open your browser and navigate to `http://localhost` to access the frontend.

Admin panel can be accessed at `http://localhost:8000/admin`.

### Default Credentials

- Email: admin@example.com
- Password: (Randomly set during automatic superuser creation, please refer to the console)
- *Notes:* only the superuser has access to the admin page and django admin, the accounts created later will only have access to the order and kitchen system as default.

### Start using via the admin/django admin page
Login using the credentials and start insert things into the database
