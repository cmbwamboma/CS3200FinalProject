# CS3200 Final Project: Wealth Management Portal

Hello to whomever is reading this, I'm Christopher Mbwa-Mboma and this is the wealth management database I created for my
Database Design final project. As I'm writing this, I'm a third-year Computer Science And Finance major and the finance
part of my major is what led me to choosing a wealth management database. Overall, my project consists of a database with three 
user personas, a client with a portfolio and a bank account, a wealth/portfolio manager who manages the portfolio on the clients behalf,
and a customer support rep that handles any support issues the client may have. Thus, the routes are organized into three categories.
The clients folder contains the clients.py file containing the routes relating to clients, the portfolios folder contains portfolios.py
which has the portfolio related routes, and the support folder has the supports.py folder containing the support routes.

Here is the link to the walkthrough Videos I made:
https://drive.google.com/file/d/1hl_jV2M5e9zij4Bjlxmwnx_PnCt4IYPt/view?usp=share_link

This repo contains 2 docker containers: 
1. A MySQL 8 container
2. A Python Flask container to implement a REST API

## How to setup and start the containers

**Important** - you need Docker Desktop and ngrok installed
1. From the python terminal run the commands docker compose build and docker compose down
2. In the command terminal, navigate to the folder containing ngrok
3. From that location run ngrok http 8001 (The docker sql container uses port 8001)

## For setting up a Conda Web-Dev environment:

1. `conda create -n webdev python=3.9`
1. `conda activate webdev`
1. `pip install flask flask-mysql flask-restful cryptography flask-login`




