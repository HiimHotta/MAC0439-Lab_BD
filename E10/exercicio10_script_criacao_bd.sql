-- cria a tabela Produto
CREATE TABLE Produto
(
  fabricante char(1),
  modelo int,
  tipo char(20)
) ;

-- cria a tabela PC
CREATE TABLE PC
(
  modelo int,
  velocidade int,
  ram int,
  hd float,
  cd char(2),
  preco numeric(6,2)
);

-- cria a tabela Laptop
CREATE TABLE Laptop
(
  modelo int,
  velocidade int,
  ram int,
  hd float,
  tela float,
  preco numeric(6,2)
);

-- cria a tabela Impressora
CREATE TABLE Impressora
(
  modelo int,
  colorida bool,
  tipo varchar(15),
  preco numeric(6,2)
);


ALTER TABLE Produto ADD PRIMARY KEY (modelo);
ALTER TABLE Produto ALTER tipo SET NOT NULL;
ALTER TABLE Produto ALTER tipo SET DEFAULT 'PC';
ALTER TABLE Produto ALTER fabricante SET NOT NULL;
ALTER TABLE Produto ADD CHECK (tipo = 'PC' OR tipo = 'Laptop' OR tipo = 'Impressora');

ALTER TABLE PC ADD FOREIGN KEY (modelo) REFERENCES Produto(modelo);
ALTER TABLE PC ADD PRIMARY KEY (modelo);
ALTER TABLE PC ALTER velocidade SET NOT NULL;
ALTER TABLE PC ALTER ram SET NOT NULL;
ALTER TABLE PC ALTER hd SET NOT NULL;
ALTER TABLE PC ADD CHECK (preco > 0.0);

ALTER TABLE Laptop ADD FOREIGN KEY (modelo) REFERENCES Produto(modelo);
ALTER TABLE Laptop ADD PRIMARY KEY (modelo);
ALTER TABLE Laptop ALTER velocidade SET NOT NULL;
ALTER TABLE Laptop ALTER ram SET NOT NULL;
ALTER TABLE Laptop ALTER hd SET NOT NULL;
ALTER TABLE Laptop ALTER tela SET NOT NULL;
ALTER TABLE Laptop ADD CHECK (preco > 0.0);

ALTER TABLE Impressora ADD FOREIGN KEY (modelo) REFERENCES Produto(modelo);
ALTER TABLE Impressora ADD PRIMARY KEY (modelo);
ALTER TABLE Impressora ALTER colorida SET DEFAULT TRUE;
ALTER TABLE Impressora ALTER tipo SET NOT NULL;
ALTER TABLE Impressora ADD CHECK (preco > 0.0);


-- popula a tabela Produto
insert into Produto (fabricante, modelo, tipo) values ('A', 1001, 'PC');
insert into Produto (fabricante, modelo, tipo) values ('A', 1002, 'PC');
insert into Produto (fabricante, modelo, tipo) values ('A', 1003, 'PC');
insert into Produto (fabricante, modelo, tipo) values ('A', 2004, 'Laptop');
insert into Produto (fabricante, modelo, tipo) values ('A', 2005, 'Laptop');
insert into Produto (fabricante, modelo, tipo) values ('A', 2006, 'Laptop');
insert into Produto (fabricante, modelo, tipo) values ('B', 1004, 'PC');
insert into Produto (fabricante, modelo, tipo) values ('B', 1005, 'PC');
insert into Produto (fabricante, modelo, tipo) values ('B', 1006, 'PC');
insert into Produto (fabricante, modelo, tipo) values ('B', 2001, 'Laptop');
insert into Produto (fabricante, modelo, tipo) values ('B', 2002, 'Laptop');
insert into Produto (fabricante, modelo, tipo) values ('B', 2003, 'Laptop');
insert into Produto (fabricante, modelo, tipo) values ('C', 1007, 'PC');
insert into Produto (fabricante, modelo, tipo) values ('C', 1008, 'PC');
insert into Produto (fabricante, modelo, tipo) values ('C', 2008, 'Laptop');
insert into Produto (fabricante, modelo, tipo) values ('C', 2009, 'Laptop');
insert into Produto (fabricante, modelo, tipo) values ('C', 3002, 'Impressora');
insert into Produto (fabricante, modelo, tipo) values ('C', 3003, 'Impressora');
insert into Produto (fabricante, modelo, tipo) values ('C', 3006, 'Impressora');
insert into Produto (fabricante, modelo, tipo) values ('D', 1009, 'PC');
insert into Produto (fabricante, modelo, tipo) values ('D', 1010, 'PC');
insert into Produto (fabricante, modelo, tipo) values ('D', 1011, 'PC');
insert into Produto (fabricante, modelo, tipo) values ('D', 2007, 'Laptop');
insert into Produto (fabricante, modelo, tipo) values ('E', 1012, 'PC');
insert into Produto (fabricante, modelo, tipo) values ('E', 1013, 'PC');
insert into Produto (fabricante, modelo, tipo) values ('F', 2010, 'Laptop');
insert into Produto (fabricante, modelo, tipo) values ('F', 3001, 'Impressora');
insert into Produto (fabricante, modelo, tipo) values ('F', 3004, 'Impressora');
insert into Produto (fabricante, modelo, tipo) values ('G', 3005, 'Impressora');
insert into Produto (fabricante, modelo, tipo) values ('H', 3007, 'Impressora');

-- popula a tabela PC
insert into PC (modelo, velocidade, ram, hd, cd, preco) values (1001,  700,  64, 10, '8x',  799);
insert into PC (modelo, velocidade, ram, hd, cd, preco) values (1002, 1500, 128, 60, '2x', 2499);
insert into PC (modelo, velocidade, ram, hd, cd, preco) values (1003,  866, 128, 20, '8x', 1999);
insert into PC (modelo, velocidade, ram, hd, cd, preco) values (1004,  866,  64, 10, '2x',  999);
insert into PC (modelo, velocidade, ram, hd, cd, preco) values (1005, 1000, 128, 20, '2x', 1499);
insert into PC (modelo, velocidade, ram, hd, cd, preco) values (1006, 1300, 256, 40, '6x', 2119);
insert into PC (modelo, velocidade, ram, hd, cd, preco) values (1007, 1400, 128, 80, '2x', 2299);
insert into PC (modelo, velocidade, ram, hd, cd, preco) values (1008,  700,  64, 30, '4x',  999);
insert into PC (modelo, velocidade, ram, hd, cd, preco) values (1009, 1200, 128, 80, '6x', 1699);
insert into PC (modelo, velocidade, ram, hd, cd, preco) values (1010,  750,  64, 30, '4x',  699);
insert into PC (modelo, velocidade, ram, hd, cd, preco) values (1011, 1100, 128, 60, '6x', 1299);
insert into PC (modelo, velocidade, ram, hd, cd, preco) values (1012,  350,  64,  7, '8x',  799);
insert into PC (modelo, velocidade, ram, hd, cd, preco) values (1013,  753, 256, 60, '2x', 2499);

-- popula a tabela Laptop
insert into Laptop (modelo, velocidade, ram, hd, tela, preco) values (2001, 700,  64,  5, 12.1, 1448);
insert into Laptop (modelo, velocidade, ram, hd, tela, preco) values (2002, 800,  96, 10, 15.1, 2584);
insert into Laptop (modelo, velocidade, ram, hd, tela, preco) values (2003, 850,  64, 10, 15.1, 2738);
insert into Laptop (modelo, velocidade, ram, hd, tela, preco) values (2004, 550,  32,  5, 12.1,  999);
insert into Laptop (modelo, velocidade, ram, hd, tela, preco) values (2005, 600,  64,  6, 12.1, 2399);
insert into Laptop (modelo, velocidade, ram, hd, tela, preco) values (2006, 800,  96, 20, 15.7, 2999);
insert into Laptop (modelo, velocidade, ram, hd, tela, preco) values (2007, 850, 128, 20, 15.0, 3099);
insert into Laptop (modelo, velocidade, ram, hd, tela, preco) values (2008, 650,  64, 10, 12.1, 1249);
insert into Laptop (modelo, velocidade, ram, hd, tela, preco) values (2009, 750, 256, 20, 15.1, 2599);
insert into Laptop (modelo, velocidade, ram, hd, tela, preco) values (2010, 366,  64, 10, 12.1, 1499);

-- popula a tabela Impressora
insert into Impressora (modelo, colorida, tipo, preco) values (3001, true,  'ink-jet',  231);
insert into Impressora (modelo, colorida, tipo, preco) values (3002, true,  'ink-jet',  267);
insert into Impressora (modelo, colorida, tipo, preco) values (3003, false,   'laser',  390);
insert into Impressora (modelo, colorida, tipo, preco) values (3004, true,  'ink-jet',  439);
insert into Impressora (modelo, colorida, tipo, preco) values (3005, true,   'bubble',  200);
insert into Impressora (modelo, colorida, tipo, preco) values (3006, true,    'laser', 1999);
insert into Impressora (modelo, colorida, tipo, preco) values (3007, false,   'laser',  350);





