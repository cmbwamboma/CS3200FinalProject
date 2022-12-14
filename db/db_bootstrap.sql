-- This file is to bootstrap a database for the CS3200 project. 

-- Create a new database.  You can change the name later.  You'll
-- need this name in the FLASK API file(s),  the AppSmith 
-- data source creation.
create database wealth_management;

-- Via the Docker Compose file, a special user called webapp will 
-- be created in MySQL. We are going to grant that user 
-- all privilages to the new database we just created. 
-- TODO: If you changed the name of the database above, you need 
-- to change it here too.
grant all privileges on wealth_management.* to 'webapp'@'%';
flush privileges;

-- Move into the database we just created.
-- TODO: If you changed the name of the database above, you need to
-- change it here too. 
use wealth_management;

-- Put your DDL

CREATE TABLE manager (
  manager_id integer PRIMARY KEY,
  full_name varchar(50) NOT NULL,
  phone_number varchar(12) NOT NULL,
  email varchar(50) NOT NULL,
  hire_date date NOT NULL
);

CREATE TABLE portfolio (
    portfolio_id integer PRIMARY KEY,
    aum integer not null,
    active_or_passive boolean,
    managed_by integer NOT NULL,
    FOREIGN KEY (managed_by) REFERENCES manager(manager_id)
);


CREATE TABLE client (
    client_id integer PRIMARY KEY,
    username varchar(20) UNIQUE,
    pass varchar(20),
    first_name varchar(20) NOT NULL,
    last_name varchar(30) NOT NULL,
    email varchar(30) NOT NULL,
    phone_number varchar(12),
    portfolio integer,
    social_security varchar(10),
    mailing_state varchar(30),
    mailing_city varchar(40),
    mailing_address varchar(50),
    FOREIGN KEY (portfolio) REFERENCES portfolio(portfolio_id)
);

CREATE TABLE bank_account (
  account_number integer(12) PRIMARY KEY,
  client integer,
  balance integer,
  billing_state varchar(30),
  billing_city varchar(50),
  billing_address varchar(50),
  FOREIGN KEY (client) REFERENCES client(client_id)
);

CREATE TABLE industry (
    industry_id integer PRIMARY KEY,
    industry_name varchar(200) UNIQUE NOT NULL,
    sector varchar(200)
);

CREATE TABLE security (
    ticker varchar(6) PRIMARY KEY,
    name varchar(40) UNIQUE NOT NULL,
    price integer NOT NULL,
    industry integer,
    beta integer NOT NULL,
    FOREIGN KEY (industry) REFERENCES  industry(industry_id)
);

CREATE TABLE holding (
    portfol integer NOT NULL,
    sec varchar(6) NOT NULL,
    quantity integer NOT NULL,
    FOREIGN KEY (portfol) REFERENCES portfolio(portfolio_id),
    FOREIGN KEY (sec) REFERENCES security(ticker)
);


CREATE TABLE support_rep (
    rep_id integer PRIMARY KEY,
    rep_name varchar(50) NOT NULL,
    hire_date date NOT NULL,
    phone varchar(12) NOT NULL,
    email varchar(50) NOT NULL
);

CREATE TABLE support_request (
    ticket_number integer PRIMARY KEY auto_increment,
    requested_by integer NOT NULL,
    rep integer NOT NULL,
    details varchar(300) NOT NULL,
    resolved boolean NOT NULL,
    request_date date NOT NULL,
    FOREIGN KEY (requested_by) REFERENCES client(client_id),
    FOREIGN KEY (rep) REFERENCES support_rep(rep_id)
);

CREATE TABLE trade (
    trade_id integer PRIMARY KEY,
    port_traded integer,
    traded_by integer,
    sec_traded varchar(6),
    quantity integer,
    price integer,
    FOREIGN KEY (port_traded) REFERENCES portfolio(portfolio_id),
    FOREIGN KEY (traded_by) REFERENCES manager(manager_id),
    FOREIGN KEY (sec_traded) REFERENCES security(ticker)
);



-- Add sample data.
insert into manager (manager_id, full_name, phone_number, email, hire_date) values (1, 'Catriona Marjot', '760-957-7740', 'cmarjot0@bizjournals.com', '2022-06-23');
insert into manager (manager_id, full_name, phone_number, email, hire_date) values (2, 'Eilis Kraut', '452-515-1247', 'ekraut1@howstuffworks.com', '2021-09-11');
insert into manager (manager_id, full_name, phone_number, email, hire_date) values (3, 'Carilyn Skeech', '196-508-0299', 'cskeech2@g.co', '2018-03-28');
insert into manager (manager_id, full_name, phone_number, email, hire_date) values (4, 'Pinchas Dreakin', '504-340-3535', 'pdreakin3@amazon.com', '2015-04-08');
insert into manager (manager_id, full_name, phone_number, email, hire_date) values (5, 'Dee Gerhardt', '697-548-6507', 'dgerhardt4@zimbio.com', '2016-05-22');
insert into manager (manager_id, full_name, phone_number, email, hire_date) values (6, 'Doe Drees', '520-815-1971', 'ddrees5@businesswire.com', '2017-10-17');
insert into manager (manager_id, full_name, phone_number, email, hire_date) values (7, 'Monti Gelardi', '465-755-9253', 'mgelardi6@army.mil', '2018-09-20');
insert into manager (manager_id, full_name, phone_number, email, hire_date) values (8, 'Korey Claxson', '704-110-0317', 'kclaxson7@1688.com', '2020-11-27');
insert into manager (manager_id, full_name, phone_number, email, hire_date) values (9, 'Hayley Sidon', '441-389-8675', 'hsidon8@cdc.gov', '2015-03-09');
insert into manager (manager_id, full_name, phone_number, email, hire_date) values (10, 'Vaclav Levis', '851-792-7673', 'vlevis9@newsvine.com', '2017-08-19');

insert into portfolio (portfolio_id, aum, active_or_passive, managed_by) values (1, 1381048.63, true, 1);
insert into portfolio (portfolio_id, aum, active_or_passive, managed_by) values (2, 592820.22, false, 2);
insert into portfolio (portfolio_id, aum, active_or_passive, managed_by) values (3, 4483057.0, false, 3);
insert into portfolio (portfolio_id, aum, active_or_passive, managed_by) values (4, 9360363.0, false, 4);
insert into portfolio (portfolio_id, aum, active_or_passive, managed_by) values (5, 4189678.09, false, 5);
insert into portfolio (portfolio_id, aum, active_or_passive, managed_by) values (6, 7007379.0, false, 6);
insert into portfolio (portfolio_id, aum, active_or_passive, managed_by) values (7, 3446098.0, true, 7);
insert into portfolio (portfolio_id, aum, active_or_passive, managed_by) values (8, 4110281.38, false, 8);
insert into portfolio (portfolio_id, aum, active_or_passive, managed_by) values (9, 8309656.03, true, 9);
insert into portfolio (portfolio_id, aum, active_or_passive, managed_by) values (10, 6332413.89, true, 10);

insert into client (client_id, username, pass, first_name, last_name, email, phone_number, portfolio, social_security, mailing_state, mailing_city, mailing_address) values (1, 'grobyns0', '139EUE', 'Gabby', 'Robyns', 'grobyns0@feedburner.com', '713-239-4677', 1, '0898833469', 'Texas', 'Houston', '38867 Barby Trail');
insert into client (client_id, username, pass, first_name, last_name, email, phone_number, portfolio, social_security, mailing_state, mailing_city, mailing_address) values (2, 'bmechan1', 'N3HufvW', 'Brigg', 'Mechan', 'bmechan1@prnewswire.com', '510-840-3027', 2, '9386054922', 'California', 'Richmond', '42465 Fordem Alley');
insert into client (client_id, username, pass, first_name, last_name, email, phone_number, portfolio, social_security, mailing_state, mailing_city, mailing_address) values (3, 'cnaile2', 'YTQxxRm4uLYk', 'Carson', 'Naile', 'cnaile2@nature.com', '417-693-3628', 3, '4622305089', 'Missouri', 'Springfield', '462 Calypso Crossing');
insert into client (client_id, username, pass, first_name, last_name, email, phone_number, portfolio, social_security, mailing_state, mailing_city, mailing_address) values (4, 'blestrange3', 'nTUqVv7vL542', 'Brendis', 'Lestrange', 'blestrange3@shop-pro.jp', '915-680-4645', 4, '8992812817', 'Texas', 'El Paso', '930 Waxwing Pass');
insert into client (client_id, username, pass, first_name, last_name, email, phone_number, portfolio, social_security, mailing_state, mailing_city, mailing_address) values (5, 'ccrecy4', '4pbzhtNDXrkH', 'Collen', 'Crecy', 'ccrecy4@livejournal.com', '619-817-3790', 5, '9086475507', 'California', 'San Diego', '217 Schmedeman Terrace');
insert into client (client_id, username, pass, first_name, last_name, email, phone_number, portfolio, social_security, mailing_state, mailing_city, mailing_address) values (6, 'ascarsbrick5', 'o1Kd1R', 'Aubree', 'Scarsbrick', 'ascarsbrick5@bloomberg.com', '503-988-4598', 6, '3505331139', 'Oregon', 'Portland', '4316 Shelley Lane');
insert into client (client_id, username, pass, first_name, last_name, email, phone_number, portfolio, social_security, mailing_state, mailing_city, mailing_address) values (7, 'rscranney6', 'HerVvg8xNB', 'Rosabelle', 'Scranney', 'rscranney6@cargocollective.com', '202-154-6967', 7, '0703755897', 'District of Columbia', 'Washington', '1 Maple Drive');
insert into client (client_id, username, pass, first_name, last_name, email, phone_number, portfolio, social_security, mailing_state, mailing_city, mailing_address) values (8, 'llagen7', '70aMZoN', 'Lulu', 'Lagen', 'llagen7@bluehost.com', '360-735-9506', 8, '5770063130', 'Washington', 'Olympia', '085 Oneill Circle');
insert into client (client_id, username, pass, first_name, last_name, email, phone_number, portfolio, social_security, mailing_state, mailing_city, mailing_address) values (9, 'kdebernardi8', 'oPlcVywe', 'Koo', 'De Bernardi', 'kdebernardi8@cyberchimps.com', '912-474-7849', 9, '5710809535', 'Georgia', 'Savannah', '0 John Wall Avenue');
insert into client (client_id, username, pass, first_name, last_name, email, phone_number, portfolio, social_security, mailing_state, mailing_city, mailing_address) values (10, 'equail9', 'EOBE1B', 'Eugen', 'Quail', 'equail9@blogtalkradio.com', '570-618-0339', 10, '7365859806', 'Pennsylvania', 'Scranton', '3885 Eastwood Trail');

insert into bank_account (account_number, client, balance, billing_state, billing_address) values (1, 1, 438418.74, 'Pennsylvania', '890 Texas Street');
insert into bank_account (account_number, client, balance, billing_state, billing_address) values (2, 2, 630793.49, 'Indiana', '13857 Dorton Junction');
insert into bank_account (account_number, client, balance, billing_state, billing_address) values (3, 3, 97477.83, 'Florida', '36524 Porter Alley');
insert into bank_account (account_number, client, balance, billing_state, billing_address) values (4, 4, 637704.86, 'Illinois', '14 Shasta Place');
insert into bank_account (account_number, client, balance, billing_state, billing_address) values (5, 5, 457912.06, 'Texas', '8582 Oriole Circle');
insert into bank_account (account_number, client, balance, billing_state, billing_address) values (6, 6, 614527.0, 'California', '92 Mayfield Terrace');
insert into bank_account (account_number, client, balance, billing_state, billing_address) values (7, 7, 736315.71, 'Montana', '917 Schiller Trail');
insert into bank_account (account_number, client, balance, billing_state, billing_address) values (8, 8, 428067.37, 'Oregon', '2241 Hermina Circle');
insert into bank_account (account_number, client, balance, billing_state, billing_address) values (9, 9, 48214.15, 'Texas', '30 Shelley Trail');
insert into bank_account (account_number, client, balance, billing_state, billing_address) values (10, 10, 711345.1, 'Missouri', '996 Vera Trail');

insert into industry (industry_id, industry_name, sector) values (1, 'Package Goods/Cosmetics', 'Consumer Non-Durables');
insert into industry (industry_id, industry_name, sector) values (2, 'Office Equipment/Supplies/Services', 'Consumer Services');
insert into industry (industry_id, industry_name, sector) values (3, 'Integrated oil Companies', 'Energy');
insert into industry (industry_id, industry_name, sector) values (4, 'EDP Services', 'Technology');
insert into industry (industry_id, industry_name, sector) values (5, 'Engineering & Construction', 'Basic Industries');
insert into industry (industry_id, industry_name, sector) values (6, 'Computer Manufacturing', 'Technology');
insert into industry (industry_id, industry_name, sector) values (7, 'Newspapers/Magazines', 'Consumer Services');
insert into industry (industry_id, industry_name, sector) values (8, 'Natural Gas Distribution', 'Public Utilities');
insert into industry (industry_id, industry_name, sector) values (9, 'Real Estate Investment Trusts', 'Consumer Services');
insert into industry (industry_id, industry_name, sector) values (10, 'Biotechnology: Biological Products (No Diagnostic Substances)', 'Health Care');

insert into security (ticker, name, price, industry, beta) values ('TTF', 'Twimbo', 172.04, 1, 1.05);
insert into security (ticker, name, price, industry, beta) values ('JW.A', 'JumpXS', 479.45, 2, .95);
insert into security (ticker, name, price, industry, beta) values ('NCA', 'Eadel', 69.24, 3, .75);
insert into security (ticker, name, price, industry, beta) values ('FMCIR', 'Eare', 126.39, 4, 1.50);
insert into security (ticker, name, price, industry, beta) values ('DL', 'Yodo', 203.19, 5, 1.35);
insert into security (ticker, name, price, industry, beta) values ('HMST', 'Feedbug', 127.36, 6, .64);
insert into security (ticker, name, price, industry, beta) values ('CNBKA', 'Aibox', 356.2, 7, .57);
insert into security (ticker, name, price, industry, beta) values ('STKL', 'Quamba', 419.59, 8, 1.00);
insert into security (ticker, name, price, industry, beta) values ('SB', 'Yabox', 438.17, 9, 1.62);
insert into security (ticker, name, price, industry, beta) values ('CLRB', 'Flipopia', 405.8, 10, 2.00);

insert into holding (portfol, sec, quantity) values ('1', 'TTF', 31);
insert into holding (portfol, sec, quantity) values ('2', 'JW.A', 42);
insert into holding (portfol, sec, quantity) values ('3', 'NCA', 10);
insert into holding (portfol, sec, quantity) values ('4', 'FMCIR', 26);
insert into holding (portfol, sec, quantity) values ('5', 'DL', 39);
insert into holding (portfol, sec, quantity) values ('6', 'HMST', 28);
insert into holding (portfol, sec, quantity) values ('7', 'CNBKA', 21);
insert into holding (portfol, sec, quantity) values ('8', 'STKL', 22);
insert into holding (portfol, sec, quantity) values ('9', 'SB', 49);
insert into holding (portfol, sec, quantity) values ('10', 'CLRB', 29);

insert into support_rep (rep_id, rep_name, hire_date, phone, email) values (1, 'Vassili Dillinton', '2020-11-12', '135-450-2311', 'vdillinton0@tamu.edu');
insert into support_rep (rep_id, rep_name, hire_date, phone, email) values (2, 'Terrill Dreher', '2018-06-25', '785-479-8618', 'tdreher1@oracle.com');
insert into support_rep (rep_id, rep_name, hire_date, phone, email) values (3, 'Aloisia Lofthouse', '2022-10-10', '456-321-1334', 'alofthouse2@bbc.co.uk');
insert into support_rep (rep_id, rep_name, hire_date, phone, email) values (4, 'Herman Montford', '2018-02-09', '913-580-4415', 'hmontford3@theguardian.com');
insert into support_rep (rep_id, rep_name, hire_date, phone, email) values (5, 'Marco Kaspar', '2016-03-30', '830-752-0735', 'mkaspar4@vinaora.com');
insert into support_rep (rep_id, rep_name, hire_date, phone, email) values (6, 'Duky Musgrave', '2018-09-23', '938-310-8052', 'dmusgrave5@ehow.com');
insert into support_rep (rep_id, rep_name, hire_date, phone, email) values (7, 'Jami Goldstone', '2019-07-05', '305-449-0325', 'jgoldstone6@flavors.me');
insert into support_rep (rep_id, rep_name, hire_date, phone, email) values (8, 'Forrest Cunnane', '2016-10-22', '119-660-3840', 'fcunnane7@paginegialle.it');
insert into support_rep (rep_id, rep_name, hire_date, phone, email) values (9, 'Claudine Sturridge', '2018-07-07', '575-656-8865', 'csturridge8@mapquest.com');
insert into support_rep (rep_id, rep_name, hire_date, phone, email) values (10, 'Michelle Wabersinke', '2019-05-29', '916-201-6234', 'mwabersinke9@dedecms.com');

insert into support_request (ticket_number, requested_by, rep, details, resolved, request_date) values (1, 1, 1, 'id ligula suspendisse ornare consequat lectus in est risus auctor sed tristique in tempus sit amet sem fusce consequat nulla nisl nunc nisl', true, '2022-01-13');
insert into support_request (ticket_number, requested_by, rep, details, resolved, request_date) values (2, 2, 2, 'in consequat ut nulla sed accumsan felis ut at dolor quis odio consequat varius integer ac leo pellentesque ultrices mattis odio donec vitae nisi nam ultrices', false, '2022-02-11');
insert into support_request (ticket_number, requested_by, rep, details, resolved, request_date) values (3, 3, 3, 'erat id mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel nulla eget eros elementum pellentesque quisque porta', false, '2022-05-23');
insert into support_request (ticket_number, requested_by, rep, details, resolved, request_date) values (4, 4, 4, 'eleifend luctus ultricies eu nibh quisque id justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus', true, '2022-11-10');
insert into support_request (ticket_number, requested_by, rep, details, resolved, request_date) values (5, 5, 5, 'duis faucibus accumsan odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi vel lectus in quam fringilla rhoncus', false, '2022-03-15');
insert into support_request (ticket_number, requested_by, rep, details, resolved, request_date) values (6, 6, 6, 'aliquam sit amet diam in magna bibendum imperdiet nullam orci pede venenatis non sodales sed tincidunt eu felis fusce posuere felis sed lacus morbi sem', true, '2022-06-23');
insert into support_request (ticket_number, requested_by, rep, details, resolved, request_date) values (7, 7, 7, 'luctus rutrum nulla tellus in sagittis dui vel nisl duis ac nibh fusce lacus purus aliquet at feugiat non pretium quis', false, '2022-06-07');
insert into support_request (ticket_number, requested_by, rep, details, resolved, request_date) values (8, 8, 8, 'penatibus et magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes', false, '2021-12-29');
insert into support_request (ticket_number, requested_by, rep, details, resolved, request_date) values (9, 9, 9, 'phasellus in felis donec semper sapien a libero nam dui proin leo odio porttitor id consequat in consequat ut nulla sed accumsan felis ut', false, '2022-08-17');
insert into support_request (ticket_number, requested_by, rep, details, resolved, request_date) values (10, 10, 10, 'sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel est donec odio justo sollicitudin ut suscipit a feugiat', false, '2022-03-18');

insert into trade (trade_id, traded_by, port_traded, sec_traded, quantity, price) values (1, 1, 1, 'TTF', 40, 359.84);
insert into trade (trade_id, traded_by, port_traded, sec_traded, quantity, price) values (2, 2, 2, 'JW.A', 84, 84.45);
insert into trade (trade_id, traded_by, port_traded, sec_traded, quantity, price) values (3, 3, 3, 'NCA', 2, 473.22);
insert into trade (trade_id, traded_by, port_traded, sec_traded, quantity, price) values (4, 4, 4, 'FMCIR', 41, 459.6);
insert into trade (trade_id, traded_by, port_traded, sec_traded, quantity, price) values (5, 5, 5, 'DL', 25, 205.77);
insert into trade (trade_id, traded_by, port_traded, sec_traded, quantity, price) values (6, 6, 6, 'HMST', 100, 69.97);
insert into trade (trade_id, traded_by, port_traded, sec_traded, quantity, price) values (7, 7, 7, 'CNBKA', 5, 401.38);
insert into trade (trade_id, traded_by, port_traded, sec_traded, quantity, price) values (8, 8, 8, 'STKL', 92, 124.73);
insert into trade (trade_id, traded_by, port_traded, sec_traded, quantity, price) values (9, 9, 9, 'SB', 98, 375.69);
insert into trade (trade_id, traded_by, port_traded, sec_traded, quantity, price) values (10, 10, 10, 'CLRB', 92, 146.18);