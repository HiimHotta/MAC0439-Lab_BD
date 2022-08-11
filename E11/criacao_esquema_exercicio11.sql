-- Esquema de criação do BD do exercício 11

create table Cidade(
	CodC	integer primary key, 
	NomeC	varchar(30) unique not null
);

create table Agricultor(
	CodA	integer primary key, 
	NomeA	varchar(30) not null, 
	CodC	integer references Cidade(CodC)
);
	
create table Produto(
	CodP	integer primary key, 
	NomeP	varchar(20) unique not null, 
	PrecoQuilo numeric(6,2)
);

create table Restaurante(
	CodR	integer primary key, 
	NomeR	varchar(20) not null, 
	CodC integer references Cidade(CodC)
);
	
create table Entrega(
	CodA	integer references Agricultor(CodA), 
	CodP	integer references Produto(CodP), 
	CodR	integer references Restaurante(CodR),
	DataEntrega	date, 
	QtdeQuilos	integer not null,
	primary key (CodA, CodP, CodR, DataEntrega));

insert into Cidade values (4001, 'Mogi das Cruzes');
insert into Cidade values (4002, 'Atibaia');
insert into Cidade values (4003, 'São Paulo');
insert into Cidade values (4004, 'Campinas');
insert into Cidade values (4005, 'Taubaté');
insert into Cidade values (4006, 'Osasco');
insert into Cidade values (4007, 'São Caetano');
insert into Cidade values (4008, 'Diadema');
insert into Cidade values (4009, 'Santo André');


insert into Agricultor values (1001, 'Ana Maria Machado', 4001);
insert into Agricultor values (1002, 'José de Alencar', 4001);
insert into Agricultor values (1003, 'Manuel Bandeira', 4001);
insert into Agricultor values (1004, 'Machado de Assis', 4002);
insert into Agricultor values (1005, 'Oswald de Andrade', 4002);
insert into Agricultor values (1006, 'Lima Barreto', 4003);
insert into Agricultor values (1007, 'Cecília Meireles', 4003);
insert into Agricultor values (1008, 'Castro Alves', 4004);
insert into Agricultor values (1009, 'Monteiro Lobato', 4005);

insert into Produto values (2001, 'tomate', 4.98);
insert into Produto values (2002, 'batata', 0.98);
insert into Produto values (2003, 'cebola', 2.98);
insert into Produto values (2004, 'cenoura', 1.98);
insert into Produto values (2005, 'chuchu', 2.49);
insert into Produto values (2006, 'mandioca', 1.98);
insert into Produto values (2007, 'couve-flor', 3.90);
insert into Produto values (2008, 'quiabo', 8.98);
insert into Produto values (2009, 'pimentão', 3.98);
insert into Produto values (2010, 'repolho', 1.49);
insert into Produto values (2011, 'beterraba', 2.49);
insert into Produto values (2012, 'alface', 2.98);
insert into Produto values (2013, 'tomate cereja', 5.98);

insert into Restaurante values (3001, 'Brasileirinho', 4003);
insert into Restaurante values (3002, 'Sabor de Minas', 4009);
insert into Restaurante values (3003, 'Bom Gosto', 4002);
insert into Restaurante values (3004, 'Panela de Ouro', 4003);
insert into Restaurante values (3005, 'RU-USP', 4003);
insert into Restaurante values (3006, 'Bom de Garfo', 4006);
insert into Restaurante values (3007, 'Sabores do Interior', 4006);
insert into Restaurante values (3008, 'Brasil a Gosto', 4007);
insert into Restaurante values (3009, 'Prato-Cheio', 4008);
insert into Restaurante values (3010, 'A Todo Sabor', 4001);

insert into Entrega values (1001,2005,3010,'2014-10-01', 15);
insert into Entrega values (1004,2002,3005,'2014-10-01', 40);
insert into Entrega values (1006,2011,3002,'2014-10-03', 37);
insert into Entrega values (1003,2003,3009,'2014-10-03', 21);
insert into Entrega values (1004,2008,3008,'2014-10-04', 12);
insert into Entrega values (1007,2008,3003,'2014-10-04', 45);
insert into Entrega values (1005,2002,3002,'2014-10-04', 60);
insert into Entrega values (1005,2001,3002,'2014-10-05', 36);
insert into Entrega values (1002,2002,3010,'2014-10-05', 28);
insert into Entrega values (1002,2007,3006,'2014-10-06', 15);
insert into Entrega values (1004,2010,3006,'2014-10-08', 52);
insert into Entrega values (1007,2003,3004,'2014-10-10', 45);
insert into Entrega values (1002,2005,3002,'2014-10-10', 38);
insert into Entrega values (1002,2003,3004,'2014-10-10', 35);
insert into Entrega values (1004,2005,3002,'2014-10-10', 25);
insert into Entrega values (1005,2011,3002,'2014-10-14', 30);
insert into Entrega values (1001,2003,3002,'2014-10-17', 57);
insert into Entrega values (1003,2002,3010,'2014-10-18', 10);
insert into Entrega values (1003,2012,3006,'2014-10-18', 36);
insert into Entrega values (1007,2007,3006,'2014-10-19', 42);
insert into Entrega values (1006,2003,3001,'2014-10-22', 28);
insert into Entrega values (1002,2003,3003,'2014-10-22', 45);
insert into Entrega values (1001,2003,3005,'2014-10-22', 37);
insert into Entrega values (1007,2003,3006,'2014-10-22', 51);
insert into Entrega values (1003,2003,3007,'2014-10-22', 24);
insert into Entrega values (1003,2003,3008,'2014-10-22', 36);
insert into Entrega values (1001,2003,3010,'2014-10-22', 40);

