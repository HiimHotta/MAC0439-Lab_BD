


-- a) Uma visão chamada AgricultorCidade, com o código e o nome
-- do agricultor e o nome da cidade onde ele está localizado.


CREATE VIEW AgricultorCidade AS
      SELECT CodA, NomeA, NomeC 
      FROM Agricultor, Cidade
      WHERE Agricultor.CodC = Cidade.CodC;

-- b) Uma visão chamada ProdutosBaratos, com todos os dados de
-- produtos cujo preço por quilo é inferior à média dos preços.


CREATE VIEW ProdutosBaratos AS
    SELECT * 
    FROM Produto
    WHERE PrecoQuilo < (SELECT AVG (PrecoQuilo) FROM Produto);

-- c) Uma visão chamada ProdutosRU, com o código, nome e preço
-- dos produtos que já foram  entregues pelo menos uma vez para
-- o restaurante RU-USP.

CREATE VIEW ProdutosRU AS
    SELECT Produto.CodP, NomeP, PrecoQuilo 
    FROM Produto, Entrega, Restaurante
    WHERE Restaurante.nomeR = 'RU-USP'     AND 
	      Restaurante.CodR  = Entrega.CodR AND
          Produto.CodP      = Entrega.CodP;

-- d) Uma visão chamada RestauranteApoiadorAgriLocal com os dados
-- dos restaurantes que são abastecidos apenas por agricultores da
-- sua cidade.


CREATE OR REPLACE VIEW RestauranteApoiadorAgriLocal AS
    SELECT DISTINCT Restaurante.CodR,
                    Restaurante.NomeR, 
                    Restaurante.CodC 
    FROM Agricultor,
		 Entrega,
   		 Restaurante
    WHERE Agricultor.CodA = Entrega.CodA     AND
          Agricultor.CodC = Restaurante.CodC AND
          Entrega.CodR    = Restaurante.CodR;


-- e) Uma visão chamada ResumoConsumo que apresenta, para cada 
-- restaurante e cada produto, o nome do restaurante, o nome do
-- produto, o total em quilos recebidos do produto pelo restaurante
-- e o preço total correspondente.


CREATE OR REPLACE VIEW ResumoConsumo AS
    SELECT DISTINCT NomeR, 
                    NomeP, 
                    SUM (QtdeQuilos) AS TotalQuilo,
                    (PrecoQuilo * SUM (QtdeQuilos)) AS PrecoTotal
    FROM Entrega, Produto, Restaurante
   	WHERE Entrega.CodP = Produto.CodP     AND
      	  Entrega.CodR = Restaurante.CodR
    GROUP BY NomeR, NomeP, PrecoQuilo;

-- EXERCÍCIO 2

/****************************************************************
 a) Quais das visões do Exercício 1 são não atualizáveis? 
Justifique sua resposta.

 Obs.: Uma visão é não atualizável quando não se pode executar
comandos de inserção, alteração e remoção diretamente sobre ela.


 RESPOSTA:

 Atualizável: b
 Não atualizável: a, c (FROM (múltiplas tabelas))
                  d, e (Uso de SELECT DISTINCT)

****************************************************************/

-- SEM CÓDIGO

/****************************************************************
b) Para cada visão que você indicou na resposta do item (a), 
quando isso for possível, torne a visão atualizável reescrevendo
a definição da visão.

d, e (Usam DISTINCT então não sabia como converter)

****************************************************************/

-- a)
CREATE VIEW AgricultorCidadeAtt AS
      SELECT CodA, NomeA, (SELECT NomeC FROM Cidade WHERE Agricultor.CodC = Cidade.CodC) 
      FROM Agricultor

-- c)
CREATE VIEW ProdutosRUAtt AS
    SELECT 
        (SELECT CodP FROM Produto WHERE Produto.CodP = Entrega.CodP),
        (SELECT NomeP FROM Produto WHERE Produto.CodP = Entrega.CodP),
        (SELECT PrecoQuilo FROM Produto WHERE Produto.CodP = Entrega.CodP)
    FROM Entrega
    WHERE Entrega.CodR = (SELECT CodR FROM Restaurante WHERE Restaurante.NomeR = 'RU-USP')


/****************************************************************

c) Em quais das visões atualizáveis que você criou no Exercício 1
e no item (b) deste exercício podem ocorrer modificações com
anomalias? Para cada visão apontada, justifique a sua resposta 
com pelo menos um exemplo de comando que cause uma anomalia.

Obs.: uma modificação com anomalia é um comando INSERT ou UPDATE
sobre a visão que é aceito como válido pelo SGBD, mas que causa
uma modificação que não é refletida na visão em questão ou que
causa o desaparecimento de tuplas na visão.

 RESPOSTA: c, d, e estão protegidos por serem de múltiplas 
tabelas.

****************************************************************/

-- 1.a - Sem o CodA correto, não aparece na visão. (tupla fantasma)

insert INTO agricultorcidade VALUES (555, 'uuuu', 'iiii')

-- 1.b - Sem preço, não dá para saber se está abaixo da média

INSERT INTO produto VALUES (123, 'Teste', NULL);


/****************************************************************

Exercício 3: A visão AgricultorCidade do item (a) do Exercício 1
é não atualizável. Crie triggers que possibilitem a inserção,
alteração e remoção em AgricultorCidade

****************************************************************/

CREATE OR REPLACE FUNCTION InsereAgricultorCidade ()
RETURNS TRIGGER AS $$
    DECLARE
        codeC integer;
    BEGIN
        SELECT CodC INTO codeC FROM Cidade WHERE NomeC = NEW.NomeC;
        INSERT INTO Agricultor VALUES (NEW.CodA, NEW.NomeA, codeC);
    RETURN NEW;
    END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER InsercaoAgricultorCidade
INSTEAD OF INSERT ON AgricultorCidade
    FOR EACH ROW
        EXECUTE PROCEDURE InsereAgricultorCidade ();


CREATE OR REPLACE FUNCTION AtualizaAgricultorCidade ()
RETURNS TRIGGER AS $$
    DECLARE
        codeC integer;
    BEGIN
        SELECT CodC INTO codeC FROM Cidade WHERE NomeC = NEW.NomeC;
        UPDATE Agricultor SET (NomeA, CodC) = (NEW.NomeA, codeC) WHERE CodA = NEW.CodA; 
    RETURN NEW;
    END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER UpdateAgricultorCidade
INSTEAD OF UPDATE ON AgricultorCidade
    FOR EACH ROW
        EXECUTE PROCEDURE AtualizaAgricultorCidade ();


CREATE OR REPLACE FUNCTION RemocaoAgricultorCidade ()
RETURNS TRIGGER AS $$
    BEGIN
        DELETE FROM Agricultor WHERE CodA = OLD.CodA; 
    RETURN NEW;
    END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER DeleteAgricultorCidade
INSTEAD OF DELETE ON AgricultorCidade
    FOR EACH ROW
        EXECUTE PROCEDURE RemocaoAgricultorCidade ();
