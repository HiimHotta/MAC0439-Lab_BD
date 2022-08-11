

/***************************************************************
 a) Na alteração do preço de um PC, caso o preço seja aumentado,
garanta que o aumento seja no máximo de 50%. Na tentativa de
realização de um aumento superior a 50%, aplique um aumento de
apenas 50%.
***************************************************************/

CREATE OR REPLACE FUNCTION AumentaPrecoPC () 
RETURNS trigger AS $$
    BEGIN   
      	IF NEW.preco <= OLD.preco * 1.5 THEN
				UPDATE PC
				SET preco = OLD.preco
				WHERE modelo = NEW.modelo;
			ELSE
				UPDATE PC
				SET preco = OLD.preco * 1.5
				WHERE modelo = NEW.modelo;
		END IF;
        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;

-- Não consegui um jeito melhor de fazer essa parte, já que
-- entrava em loop :c
CREATE OR REPLACE TRIGGER LimiteAumentoPC 
	AFTER UPDATE OF preco ON PC
	FOR EACH ROW WHEN (pg_trigger_depth() = 0)
		EXECUTE FUNCTION AumentaPrecoPC ();


/***************************************************************
 b) Na inserção ou alteração de uma impressora, só permita que a
operação seja realizada se o tipo informado para a impressora 
for o mesmo de alguma outra impressora já existente na tabela.

https://stackoverflow.com/questions/22733254/prevent-insert-if-condition-is-met
***************************************************************/

CREATE OR REPLACE FUNCTION ChecaTipoExistente () 
RETURNS trigger AS $$
    BEGIN   
      	IF NOT EXISTS (SELECT tipo FROM IMPRESSORA WHERE tipo = NEW.tipo) THEN
      		RAISE NOTICE 'tipo de impressora inválido';
			RETURN NULL;
		END IF;
        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER GaranteInsercaoPorTipo 
	BEFORE INSERT ON Impressora
	FOR EACH ROW WHEN (pg_trigger_depth() = 0)
		EXECUTE FUNCTION ChecaTipoExistente ();

CREATE OR REPLACE TRIGGER GaranteAlteracaoPorTipo 
	BEFORE UPDATE ON Impressora
	FOR EACH ROW WHEN (pg_trigger_depth() = 0)
		EXECUTE FUNCTION ChecaTipoExistente ();

/***************************************************************
 c) Garanta, em todas as circunstâncias que possam causar uma
violação, que o preço de um laptop seja limitado ao preço do PC
mais caro que houver no BD (ou seja, na tentativa de atribuição
de um preço superior ao preço do PC mais caro, substitua-o pelo
preço do PC mais caro). 
***************************************************************/

CREATE OR REPLACE FUNCTION PrecoLimitadoLaptop () 
RETURNS trigger AS $$
	DECLARE
		max_preco numeric(6,2);
    BEGIN  
    	max_preco = (SELECT MAX (preco) FROM PC);
      	IF NEW.preco > max_preco THEN
      		RAISE NOTICE 'Preço do Laptop maior do que do PC';
      		NEW.preco = max_preco;
		END IF;
        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER InsercaoLaptopPrecoLimitado 
	BEFORE INSERT ON Laptop
	FOR EACH ROW WHEN (pg_trigger_depth() = 0)
		EXECUTE FUNCTION PrecoLimitadoLaptop ();


CREATE OR REPLACE TRIGGER AlteraLaptopPrecoLimitado 
	BEFORE UPDATE ON Laptop
	FOR EACH ROW WHEN (pg_trigger_depth() = 0)
		EXECUTE FUNCTION PrecoLimitadoLaptop ();

/***************************************************************
 d) Na inserção de um novo PC, caso ele não esteja cadastrado
ainda na tabela Produto, inclua-o em Produto, usando 'H' como
fabricante.
***************************************************************/

CREATE OR REPLACE FUNCTION InserePCnoProduto () 
RETURNS trigger AS $$
    BEGIN  
      	IF EXISTS (SELECT * FROM Produto WHERE modelo = NEW.modelo) THEN
      		RAISE NOTICE 'Inserindo PC não existente em Produto';
      		INSERT INTO produto VALUES ('H', NEW.modelo, 'pc');
		END IF;
        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER InserePcNaoCadastrado 
	BEFORE INSERT ON PC
	FOR EACH ROW WHEN (pg_trigger_depth() = 0)
		EXECUTE FUNCTION InsereProduto ();

/***************************************************************
 e) Garanta, em todas as circunstâncias que podem causar uma
violação, que cada fabricante venda no máximo 7 modelos de
equipamentos diferentes.
***************************************************************/

CREATE OR REPLACE FUNCTION MaximoProdutoFabricante () 
RETURNS trigger AS $$
	DECLARE
		quant_produto INT;
    BEGIN  
    	quant_produto = (SELECT COUNT(*) FROM produto WHERE fabricante = NEW.fabricante);

      	IF quant_produto >= 7 THEN
      		RAISE NOTICE 'Máximo de produtos do fabricante é 7';
      		RETURN NULL;
		END IF;
        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER InsereMaximoProdutoFabricante
	BEFORE INSERT ON Produto
	FOR EACH ROW WHEN (pg_trigger_depth() = 0)
		EXECUTE FUNCTION MaximoProdutoFabricante ();

CREATE OR REPLACE TRIGGER AlteraMaximoProdutoFabricante
	BEFORE UPDATE ON Produto
	FOR EACH ROW WHEN (pg_trigger_depth() = 0)
		EXECUTE FUNCTION MaximoProdutoFabricante ();

/***************************************************************
f) Na remoção de qualquer equipamento da relação Produto, remova
o registro correspondente na relação PC, Laptop ou Impressora. 
***************************************************************/


-- NÃO FUNCIONA E NÃO DESCOBRI PORQUÊ, SÓ SEI QUE O IDEAL
-- ERA USAR ON DELETE CASCADE

CREATE OR REPLACE FUNCTION DeletaTodasTabelasProduto () 
RETURNS trigger AS $$
    BEGIN
    	DELETE FROM PC         WHERE modelo = NEW.modelo;
		DELETE FROM Laptop     WHERE modelo = NEW.modelo;
		DELETE FROM Impressora WHERE modelo = NEW.modelo;
        RETURN OLD;
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER DeleteProduto
	BEFORE DELETE ON Produto
	FOR EACH ROW WHEN (pg_trigger_depth() = 0)
		EXECUTE FUNCTION DeletaTodasTabelasProduto ();

/***************************************************************
g) Na remoção de qualquer equipamento das relações PC, Laptop ou
Impressora, remova o registro correspondente na relação Produto.
***************************************************************/

-- NÃO FUNCIONA, IDEIA QUE TIVE é tentar fazer o delete antes.

CREATE OR REPLACE PROCEDURE DeletaTodasTabelasPC () 
RETURNS trigger AS $$
    BEGIN
    	DELETE FROM Produto    WHERE modelo = NEW.modelo;
		DELETE FROM Laptop     WHERE modelo = NEW.modelo;
		DELETE FROM Impressora WHERE modelo = NEW.modelo;
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER DeleteProduto
	BEFORE DELETE ON PC
	FOR EACH ROW WHEN (pg_trigger_depth() = 0)
		EXECUTE PROCEDURE DeletaTodasTabelasPC ();
/***************************************************************
Exercício 2 – Responda as questões abaixo.
***************************************************************/

/***************************************************************
 a) Os triggers dos itens (f) e (g) do Exercício 1 acima causam
um ciclo de disparos infinitos? Justifique sua resposta.
***************************************************************/

-- Nem rodou pra mim, kkk. Infelizmente.

/***************************************************************
 b) O comportamento definido no item (f) ou no item (g) do
Exercício 1 poderia ser obtido por meio de uma restrição
explícita definida sobre o esquema do BD. Para qual dos dois
itens isso é verdade e que restrição seria essa? Exemplifique 
como ficaria a definição da restrição no comando “create table”
das tabelas envolvidas.
***************************************************************/

-- A restrição ON DELETE CASCADE funcionaria para o item (f) que
-- deleta o pai.

ALTER TABLE PC ADD FOREIGN KEY (modelo) REFERENCES Produto(modelo) ON DELETE CASCADE;