
-- CONSULTAS

-- a) Receba um preço como parâmetro de entrada e devolva o modelo do PC cujo preço é o mais
--   próximo.

CREATE OR REPLACE FUNCTION SelecionaModeloPorPreco (NUMERIC)
RETURNS INT AS $$
    DECLARE
        reg RECORD;
        menor_modelo INT;
        menor_preco numeric(6,2);
    BEGIN
        FOR reg IN SELECT * FROM pc LOOP
            IF abs (reg.preco - $1) <= abs (menor_preco - $1) OR 
               menor_preco IS NULL THEN
                menor_modelo = reg.modelo;
                menor_preco = reg.preco;
            END IF;

        END LOOP;
        RETURN menor_modelo;
    END;
$$ LANGUAGE plpgsql;

SELECT * FROM SelecionaModeloPorPreco (1000);

-- b) Receba um fabricante e um modelo como parâmetros de entrada e devolva o preço do produto
--    (não importando a que tipo de produto o modelo corresponda).

CREATE OR REPLACE FUNCTION SelecionaPorFabricanteModelo (IN fab CHAR(1), IN model INT)
RETURNS NUMERIC (6, 2) AS $$
    DECLARE
        tmp RECORD;
        price NUMERIC (6, 2);
    BEGIN
        SELECT *
        INTO tmp
        FROM produto
        WHERE fabricante = fab AND produto.modelo = model;

        IF tmp.tipo = 'pc' THEN
            SELECT preco INTO price FROM pc WHERE modelo = model;

        ELSEIF tmp.tipo = 'laptop' THEN
            SELECT preco INTO price FROM laptop WHERE modelo = model;

        ELSEIF tmp.tipo = 'impressora' THEN
            SELECT preco INTO price FROM impressora WHERE modelo = model;

        END IF;

        RETURN price;  

    END;
$$ LANGUAGE plpgsql;


-- c) Receba um modelo, um fabricante, uma velocidade, um tamanho de RAM e de HD como
-- parâmetros de entrada e insira como um novo PC no BD. Entretanto, se já existir um PC (ou um
-- outro produto) com o mesmo número de modelo (problema que será assinalado por meio de uma
-- exceção com SQLSTATE igual a '23000', correspondente a uma violação da restrição de primary
-- key), continue adicionando 1 ao número do modelo até encontrar um número de modelo que ainda
-- não apareça no BD.

CREATE OR REPLACE PROCEDURE InserePC (IN fab CHAR(1), 
                                      IN model INT,
                                      IN vel   INT, 
                                      IN t_ram INT, 
                                      IN t_hd  INT )
AS $$

    DECLARE
        contador INT := model;
        tmp INT;
    
    -- Comeca bloco de tratamento de excecoes
    BEGIN
        INSERT INTO produto VALUES (fab, model, 'pc');

        EXCEPTION WHEN SQLSTATE '23000' THEN
        BEGIN
            RAISE NOTICE 'O modelo informado já está em uso!';
            
            LOOP
                contador := contador + 1;
                SELECT modelo INTO tmp FROM produto WHERE modelo = contador;
                EXIT WHEN tmp IS NULL;
            END LOOP;

            INSERT INTO produto VALUES (fab, contador, 'pc');

            INSERT INTO pc VALUES (contador, vel, t_ram, t_hd);
        END;

        RETURN;
    END;

    $$ LANGUAGE plpgsql;



-- d) Dado um preço como parâmetro de entrada, calcule e mostre o número de PCs, o número de
-- laptops e o número de impressoras vendidos por um preço superior ao preço fornecido.

CREATE OR REPLACE FUNCTION QuantidadePorPreco(INT)
RETURNS SETOF TEXT AS $$
    DECLARE
        registro RECORD;
        quant_pc         INT := 0;
        quant_laptop     INT := 0;
        quant_impressora INT := 0;
        price ALIAS FOR $1;
    BEGIN
        RETURN NEXT (SELECT COUNT(*) FROM pc WHERE preco >= price);
        RETURN NEXT (SELECT COUNT(*) FROM laptop WHERE preco >= price);
        RETURN NEXT (SELECT COUNT(*) FROM impressora WHERE preco >= price);
    END;
$$ LANGUAGE plpgsql;

SELECT selecionafuncionarioporsalario (2400);