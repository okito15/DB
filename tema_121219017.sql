DROP DATABASE IF EXISTS internet_provider;
CREATE DATABASE internet_provider;
USE internet_provider;

CREATE TABLE clients
(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255) NOT NULL,
egn VARCHAR(10) NOT NULL UNIQUE,
phone VARCHAR(10) NOT NULL UNIQUE,
address VARCHAR(255) NOT NULL,
mac VARCHAR(255) NOT NULL UNIQUE,
ip VARCHAR(255) NOT NULL UNIQUE,
plan VARCHAR(255) NOT NULL,
date_of_payment DATE NOT NULL,
download INT,
upload INT
);

INSERT INTO clients(name, egn, phone, address, mac, ip, plan, date_of_payment, download, upload)
VALUES 	('Ivan Krasimirov', '8452192189', '0878451237', 'Sofia, jk. Tolstoi', '15:3c:62:7f:8d:9t', '164.182.83.211', 'NET++', '2021-06-01',  1234567, 123456),
		('Evgeni Stoyanov', '7712746720', '0884065011', 'Sofia, jk. Lyulin', '51:8c:5g:9k:81:9r', '163.186.82.219', 'NET+', '2021-06-02',  85281, 43111),
		('Pavel Dimitrov', '9883125141', '0891357812', 'Sofia, jk. Hladilnika', '19:3n:52:j6:3v:9q', '161.183.83.215', 'NET Smart', '2021-06-03', 50399, 32121),
        ('Stoyan Kolev', '8551261219', '0891621126','Sofia, jk. Studentski', '14:2c:98:k2:9l:2m:1f', '162.182.84.212', 'NET++', '2021-06-04', 100000, 50000),
        ('Stela Petkova', '959284012', '0872752320','Sofia, jk. Lozenec', '41:5f:18:v2:9t:b6:7k', '165.184.81.213', 'NET Smart', '2021-06-05', 66666, 42125);

CREATE TABLE problems
(
id INT AUTO_INCREMENT PRIMARY KEY,
address VARCHAR(255) NOT NULL,
technician VARCHAR(255) NOT NULL,
solution VARCHAR(255) NOT NULL,
cost DOUBLE
);

INSERT INTO problems(address, technician, solution, cost)
VALUES	('Sofia, jk. Tolstoi', 'Georgi Angelov', 'Podmqna na kabeli', 30),
		('Sofia, jk. Lozenec', 'Kolyo Pavlov', 'Povreden ruter', 25),
        ('Sofia, jk. Lyulin', 'Biser Marinov', 'Povredena internet kutiq', 35);
        
CREATE TABLE clients_problems
(
client_id INT NOT NULL,
problem_id INT NOT NULL,
PRIMARY KEY(client_id, problem_id),
CONSTRAINT FOREIGN KEY (client_id) REFERENCES clients(id) ON UPDATE RESTRICT ON DELETE RESTRICT,
CONSTRAINT FOREIGN KEY (problem_id) REFERENCES problems(id) ON UPDATE RESTRICT ON DELETE RESTRICT
);

INSERT INTO clients_problems(client_id, problem_id) VALUES(1,1);
INSERT INTO clients_problems(client_id, problem_id) VALUES(2,3);
INSERT INTO clients_problems(client_id, problem_id) VALUES(5,2);

SELECT CONCAT(MAX(cost),' lv.') AS Most_expensive_problem FROM problems;

SELECT clients.id, clients.name, clients.egn, clients.phone, clients.address, clients.mac, clients.ip, clients.plan, clients.date_of_payment, CONCAT(clients.download, ' MB') as download, CONCAT(clients.upload, ' MB') as upload FROM clients;

SELECT clients.id as client_id, clients.name as client_name, clients.plan as client_plan, clients.address as client_address, problems.solution as problem_solution, CONCAT(problems.cost, ' lv.') as problem_cost, CONCAT('Tehnik ', problems.technician) as technician FROM clients
JOIN clients_problems ON clients.id = clients_problems.client_id
JOIN problems ON problems.id = clients_problems.problem_id
GROUP BY name;

SELECT *
FROM problems
INNER JOIN clients_problems
ON problems.id = clients_problems.problem_id;

SELECT problems.id as problem_id, problems.address as address, problems.technician as technician, problems.solution as solution, CONCAT(problems.cost, ' lv.') as cost
FROM problems
RIGHT OUTER JOIN clients_problems
ON problems.id = clients_problems.problem_id;

SELECT COUNT(problems.id) AS Problems_with_cost_more_than_25_leva
FROM problems
JOIN clients_problems ON problems.id = clients_problems.problem_id
WHERE problems.cost > 25


        
        
